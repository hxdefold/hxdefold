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

typedef Property =
{
    var name: String;
    var type: Type;
    var doc: String;
}

class ScriptBuilder
{
    public static final globalSelfRef: String = '_G.__hxdefold_self__';


    public static macro function build(): Array<Field>
    {
        var scriptClass: ClassType = Context.getLocalClass().get();
        var newFields: Array<Field> = [];

        var additionalInitStatements: Array<Expr> = [];
        var initMethod: Field = null;
        var properties: Array<Property> = [];


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

                    var readOnly: Bool = false;
                    var meta: Metadata = [];

                    if (fieldContainsMeta(field, 'property'))
                    {
                        // this var should generate a script property
                        // store the default value in the meta here so that the script generator
                        // can add the default values as appropriate
                        meta.push({
                            name: 'property',
                            pos: field.pos,
                            params: e == null ? null : [ e ]
                        });

                        readOnly = isReadOnlyType(t.toType());

                        properties.push({
                            name: field.name,
                            type: t.toType(),
                            doc: field.doc
                        });
                    }
                    else if (e != null)
                    {
                        // this is a non-property field with a default value specified
                        // these should be initialized in init()
                        additionalInitStatements.push({expr: EBinop(OpAssign, macro $i{field.name}, e), pos: field.pos});
                    }

                    // replace variable with a property
                    var luaPropRef: String = '${globalSelfRef}.${field.name}';
                    var newField: Field =
                    {
                        name: field.name,
                        pos: field.pos,
                        meta: meta,
                        access: [ APrivate ],
                        doc: field.doc,
                        kind: FProp('get', readOnly ? 'never' : 'set', t)
                    };

                    // create the getter
                    newFields.push({
                        name: 'get_${field.name}',
                        pos: field.pos,
                        // here the :pure tag is important!
                        meta: [ { name: ':noCompletion', pos: field.pos }, { name: ':pure', pos: field.pos } ],
                        access: [ APrivate, AInline ],
                        kind: FFun({
                            args: [],
                            ret: t,
                            expr: macro return untyped $i{luaPropRef}
                        })
                    });

                    // create the setter
                    if (!readOnly)
                    {
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
                    }

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


        if (!scriptClass.meta.has('noGen'))
        {
            definePropertiesType(scriptClass, properties);
        }

        return newFields;
    }

    /**
     * This method defines a class called `ScriptNameProperties` with public static `Property<T>` fields
     * for each property of the `ScriptName` script.
     */
    static function definePropertiesType(scriptClass: ClassType, properties: Array<Property>): String
    {
        var fields: Array<Field> = [];
        for (prop in properties)
        {
            fields.push({
                name: prop.name,
                pos: scriptClass.pos,
                doc: prop.doc,
                access: [ APublic, AStatic, AFinal ],
                kind: FVar(
                    TPath({
                        pack: [ 'defold', 'types' ],
                        name: 'Property',
                        params: [ TPType(prop.type.toComplexType()) ]
                    }),
                    macro new defold.types.Property($v{prop.name})
                )
            });
        }

        var propertiesClassName: String = '${scriptClass.name}Properties';
        var typeDef: TypeDefinition = {
            pack: [],
            pos: scriptClass.pos,
            name: propertiesClassName,
            doc: 'List of properties defined in the ${scriptClass.name} script class.',
            kind: TDClass(null, null, null, true),
            fields: fields
        };
        Context.defineType(typeDef);

        return propertiesClassName;
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

    static function isReadOnlyType(type: Type): Bool
    {
        return switch type
        {
            case TAbstract(_.get() => {pack: ["defold", "types"], name: "AtlasResourceReference"}, _)
               | TAbstract(_.get() => {pack: ["defold", "types"], name: "FontResourceReference"}, _)
               | TAbstract(_.get() => {pack: ["defold", "types"], name: "MaterialResourceReference"}, _)
               | TAbstract(_.get() => {pack: ["defold", "types"], name: "TextureResourceReference"}, _)
               | TAbstract(_.get() => {pack: ["defold", "types"], name: "TileSourceResourceReference"}, _)
               | TAbstract(_.get() => {pack: ["defold", "types"], name: "BufferResourceReference"}, _):
                true;

            default: false;
        }
    }
}
#end
