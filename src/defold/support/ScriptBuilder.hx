package defold.support;

#if macro
import haxe.io.Path;
import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

using StringTools;
using haxe.macro.Tools;
using haxe.macro.TypeTools;


class ScriptBuilder
{
    public static macro function build(): Array<Field>
    {
        var newFields: Array<Field> = [];

        for (field in Context.getBuildFields())
        {
            var newField: Field = field;

            switch field.kind
            {
                /**
                 * Remove non-static variables and replace them with accessors to the self object.
                 */
                case FVar(t, e) if (!field.access.contains(AStatic)):

                    // do some checks
                    if (field.access.contains(APublic))
                    {
                        Context.fatalError('public properties are not allowed', field.pos);
                    }

                    // replace variable with a property
                    newField =
                    {
                        name: field.name,
                        pos: field.pos,
                        meta: [],
                        access: [ APrivate ],
                        doc: field.doc,
                        kind: FProp('get', 'set', t)
                    };
                    if (fieldContainsMeta(field, 'property'))
                    {
                        // this var should generate a script property
                        newField.meta.push({
                            name: 'property',
                            pos: field.pos,
                            params: e == null ? null : [ e ]
                        });
                    }
                    else if (e != null)
                    {
                        // this is a non-property field
                        // these should be initialized in init()
                        // so throw an error if a default value has been set here for now
                        Context.fatalError('non-property fields have to be initialized in init()', field.pos);
                    }

                    // create the getter
                    var luaPropRead: String = '_G.self.${field.name}';
                    newFields.push({
                        name: 'get_${field.name}',
                        pos: field.pos,
                        meta: [ { name: ':noCompletion', pos: field.pos } ],
                        access: [ APrivate ],
                        kind: FFun({
                            args: [],
                            ret: t,
                            expr: macro { return untyped __lua__($v{luaPropRead}); }
                        })
                    });

                    // create the setter
                    var luaPropWrite: String = '_G.self.${field.name} = value';
                    newFields.push({
                        name: 'set_${field.name}',
                        pos: field.pos,
                        meta: [ { name: ':noCompletion', pos: field.pos } ],
                        access: [ APrivate ],
                        kind: FFun({
                            args: [ {name: 'value', type: t} ],
                            ret: t,
                            expr: macro {
                                untyped __lua__($v{luaPropWrite});
                                return value;
                            }
                        })
                    });


                /**
                 * All other fields shall be kept as-is.
                 */
                default:
            }

            newFields.push(newField);
        }

        return newFields;
    }

    static function fieldContainsMeta(field: Field, name: String): Bool
    {
        for (meta in field.meta)
        {
            if (meta.name == name)
            {
                return true;
            }
        }
        return false;
    }
}
#end
