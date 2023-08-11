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
using haxe.macro.ExprTools;


private typedef PropertyInit =
{
    var name: String;
    var value: String;
}

class ScriptBuilder
{
    public static macro function build(): Array<Field>
    {
        var newFields: Array<Field> = [];

        var additionalInitStatements: Array<Expr> = [];
        var initMethod: Field = null;


        for (field in Context.getBuildFields())
        {
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
                    var newField: Field =
                    {
                        name: field.name,
                        pos: field.pos,
                        meta: [],
                        access: [ APrivate ],
                        doc: field.doc,
                        kind: FProp('get', 'set', t)
                    };
                    var luaPropRef: String = '_G.self.${field.name}';
                    if (fieldContainsMeta(field, 'property'))
                    {
                        // this var should generate a script property
                        // store the default value in the meta here so that the script generator
                        // can add the default values as appropriate
                        newField.meta.push({
                            name: 'property',
                            pos: field.pos,
                            params: e == null ? null : [ e ]
                        });
                    }
                    else if (e != null)
                    {
                        // this is a non-property field with a default value specified
                        // these should be initialized in init()
                        additionalInitStatements.push({expr: EBinop(OpAssign, macro $i{field.name}, e), pos: field.pos});
                    }

                    // create the getter
                    newFields.push({
                        name: 'get_${field.name}',
                        pos: field.pos,
                        // here the :pure tag is important!
                        meta: [ { name: ':noCompletion', pos: field.pos } ],
                        access: [ APrivate, AInline ],
                        kind: FFun({
                            args: [],
                            ret: t,
                            expr: macro return untyped $i{luaPropRef}
                        })
                    });

                    // create the setter
                    newFields.push({
                        name: 'set_${field.name}',
                        pos: field.pos,
                        meta: [ { name: ':noCompletion', pos: field.pos } ],
                        access: [ APrivate, AInline ],
                        kind: FFun({
                            args: [ {name: 'value', type: t} ],
                            ret: t,
                            expr: macro return untyped $i{luaPropRef} = value
                        })
                    });

                    newFields.push(newField);


                /**
                 * The init method is kept and added later, in case we want to add some statements to it.
                 */
                case FFun(f) if (field.name == 'init'):
                    initMethod = field;


                /**
                 * All other fields shall be kept as-is.
                 */
                default:
                    newFields.push(field);
            }
        }


        /**
         * If any additional init statements are needed for the class, insert them here...
         */
        if (additionalInitStatements.length > 0)
        {
            // we need to add initialization statements to init()
            if (initMethod == null)
            {
                initMethod = createDefaultInit(additionalInitStatements);
            }
            else
            {
                var existingExprs: Expr = switch initMethod.kind
                {
                    case FFun(f): f.expr;

                    default: Context.fatalError('init is not a function?', initMethod.pos);
                }

                initMethod =
                {
                    name: initMethod.name,
                    meta: initMethod.meta,
                    pos: initMethod.pos,
                    access: initMethod.access,
                    doc: initMethod.doc,
                    kind: FFun({
                        args: [],
                        expr: macro $b{additionalInitStatements.concat([existingExprs])}
                    })
                }
            }
        }


        if (initMethod != null)
        {
            newFields.push(initMethod);
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

    static function createDefaultInit(exprs: Array<Expr>): Field
    {
        return {
            name: 'init',
            pos: Context.currentPos(),
            access: [ AOverride ],
            kind: FFun({
                args: [],
                expr: macro {
                    super.init();
                    $b{exprs}
                }
            })
        };
    }

    static function getInitMethod(): Field
    {
        for (field in Context.getBuildFields())
        {
            if (field.name == 'init')
            {
                return field;
            }
        }
        return null;
    }
}
#end
