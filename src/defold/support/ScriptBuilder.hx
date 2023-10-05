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
    public static final globalSelfRef: String = '_G._hxdefold_self_';


    public static macro function build(): Array<Field>
    {
        var scriptClass: ClassType = Context.getLocalClass().get();
        var newFields: Array<Field> = [];

        var properties: Array<Property> = [];
        var additionalInitStatements: Array<Expr> = [];
        var initMethod: Field = null;


        for (field in Context.getBuildFields())
        {
            if (field.access.contains(APublic) && !field.access.contains(AStatic))
            {
                Context.fatalError('script classes are not allowed to have non-static public fields', field.pos);
            }

            switch field.kind
            {
                /**
                 * Remove non-static variables and replace them with accessors to the self object.
                 */
                case FVar(t, e) if (!field.access.contains(AStatic)):

                    var isDefoldProperty: Bool = fieldContainsMeta(field, 'property');
                    var isReadOnly: Bool = fieldContainsMeta(field, 'readonly')
                                        || field.access.contains(AFinal);

                    // do some checks
                    if (field.access.contains(APublic))
                    {
                        Context.fatalError('public script class fields are not allowed', field.pos);
                    }
                    if (field.access.contains(AInline))
                    {
                        Context.fatalError('inline script class fields are not allowed', field.pos);
                    }
                    if (!isDefoldProperty && isReadOnly)
                    {
                        Context.fatalError('only script class fields that are marked as @property can be readonly', field.pos);
                    }


                    var meta: Metadata = [];
                    if (isDefoldProperty)
                    {
                        // this var should generate a script property
                        // store the default value in the meta here so that the script generator
                        // can add the default values as appropriate
                        meta.push({
                            name: 'property',
                            pos: field.pos,
                            params: e == null ? null : [ e ]
                        });

                        isReadOnly = isReadOnly || isReadOnlyType(t.toType());

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
                    newFields.push({
                        name: field.name,
                        pos: field.pos,
                        meta: meta,
                        access: [ APrivate ],
                        doc: field.doc,
                        kind: FProp('get', isReadOnly ? 'never' : 'set', t)
                    });

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
                    if (!isReadOnly)
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


                /**
                 * Properties are only allowed with getters and/or setters.
                 * Currently we are not handling properties with 'default' access, so we should make them raise errors.
                 */
                case FProp('default', _, _, _) | FProp(_, 'default', _, _)  if (!field.access.contains(AStatic)):
                    Context.fatalError('script class fields with access "default" are currently not supported', field.pos);


                /**
                 * Non-static dynamic functions are not currently supported.
                 * Only a single class instance is created in practice, so we should force the user to explicitly make it static.
                 */
                case FFun(f) if (field.access.contains(ADynamic) && !field.access.contains(AStatic)):
                    Context.fatalError('script classes shall not define non-static dynamic functions', field.pos);


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


        /**
         * Generate properties-related fields and types.
         */
        if (scriptClass.superClass != null)
        {
            // get properties from the super-classes as well
            properties = properties.concat(getProperties(scriptClass.superClass.t.get()));
        }
        if (!scriptClass.meta.has('noGen'))
        {
            definePropertiesType(scriptClass, properties, Context.currentPos());
        }
        newFields.push(generateCreateMethod(properties, Context.currentPos()));

        return newFields;
    }

    /**
     * This method defines a class called `ScriptNameProperties` with public static `Property<T>` fields
     * for each property of the `ScriptName` script.
     */
    static function definePropertiesType(scriptClass: ClassType, properties: Array<Property>, pos: Position): String
    {
        var fields: Array<Field> = [];
        for (prop in properties)
        {
            fields.push(generatePropertyField(prop.name, prop.name, prop.doc, prop.type.toComplexType(), pos));

            /**
             * Now let's go one step further...
             *
             * Take properties of the following 3 types: Vector3, Vector4, Quaternion
             * And generate also property hashes for their `.x`, `.y`, `.z`, and `.w` components!
             */
            switch prop.type.followWithAbstracts()
            {
                case TInst(_.get() => {pack: ["defold", "types", "_Vector3"], name: "Vector3Data"}, _):
                    fields.push(generatePropertyField(prop.name + 'X', prop.name + '.x', 'The x-component of property ${prop.name}', macro: Float, pos));
                    fields.push(generatePropertyField(prop.name + 'Y', prop.name + '.y', 'The y-component of property ${prop.name}', macro: Float, pos));
                    fields.push(generatePropertyField(prop.name + 'Z', prop.name + '.z', 'The z-component of property ${prop.name}', macro: Float, pos));

                case TInst(_.get() => {pack: ["defold", "types", "_Vector4"], name: "Vector4Data"}, _)
                   | TInst(_.get() => {pack: ["defold", "types", "_Quaternion"], name: "QuaternionData"}, _):
                    fields.push(generatePropertyField(prop.name + 'X', prop.name + '.x', 'The x-component of property ${prop.name}', macro: Float, pos));
                    fields.push(generatePropertyField(prop.name + 'Y', prop.name + '.y', 'The y-component of property ${prop.name}', macro: Float, pos));
                    fields.push(generatePropertyField(prop.name + 'Z', prop.name + '.z', 'The z-component of property ${prop.name}', macro: Float, pos));
                    fields.push(generatePropertyField(prop.name + 'W', prop.name + '.w', 'The w-component of property ${prop.name}', macro: Float, pos));

                default:
            }
        }

        var propertiesClassName: String = '${scriptClass.name}Properties';
        var typeDef: TypeDefinition = {
            pack: [],
            pos: pos,
            name: propertiesClassName,
            doc: 'List of properties defined in the ${scriptClass.name} script class.',
            kind: TDClass(null, null, null, true),
            fields: fields
        };
        Context.defineType(typeDef);

        return propertiesClassName;
    }

    static function getProperties(scriptClass: ClassType): Array<Property>
    {
        var properties: Array<Property> = [];

        if (scriptClass.superClass != null)
        {
            var superClass: ClassType = scriptClass.superClass.t.get();
            properties = properties.concat(getProperties(superClass));
        }

        for (field in scriptClass.fields.get())
        {
            switch field.kind
            {
                case FVar(t, e) if (field.meta.has('property')):
                    properties.push({
                        name: field.name,
                        type: field.type,
                        doc: field.doc
                    });

                default:
            };
        }

        return properties;
    }

    static function generatePropertyField(name: String, hashName: String, doc: String, type: ComplexType, pos: Position): Field
    {
        return {
            name: name,
            pos: pos,
            doc: doc,
            access: [ APublic, AStatic, AFinal ],
            kind: FVar(
                TPath({
                    pack: [ 'defold', 'types' ],
                    name: 'Property',
                    params: [ TPType(type) ]
                }),
                macro new defold.types.Property($v{hashName})
            )
        };
    }

    static function generateCreateMethod(properties: Array<Property>, pos: Position): Field
    {
        var args: Array<FunctionArg> = [];
        var argDocs: Array<String> = [];
        var tableInitExprs: Array<String> = [];

        for (i in 0...properties.length)
        {
            var property: Property = properties[i];
            if (isReadOnlyType(property.type))
            {
                // don't include readonly properties in the create method
                continue;
            }

            args.push({
                name: property.name,
                opt: true,
                type: property.type.toComplexType()
            });
            tableInitExprs.push('${property.name} = {$i}');
            argDocs.push('@param ${property.name} ${property.doc == null ? "" : property.doc}');
        }

        /**
         * The expression of the method is simply to initialize the lua table and return it.
         */
        var tableInit: String = '{ ${tableInitExprs.join(', ')} }';
        var tableInitArgs: Array<Expr> = [ macro $v{tableInit} ];
        for (property in properties)
        {
            tableInitArgs.push(macro $i{property.name});
        }
        var expr: Expr = {
            expr: EReturn({
                expr: EUntyped({
                    expr: ECall(
                        macro __lua__,
                        tableInitArgs
                    ),
                    pos: pos
                }),
                pos: pos
            }),
            pos: pos
        };

        var doc: String = 'This method can be used to create a type-safe properties table, that can be passed to the `Factory.create()` function when creating instances of an object that contains this script.

${argDocs.join('\n')}
@return the properties table
';

        return {
            name: 'create',
            pos: pos,
            doc: doc,
            access: [ APublic, AStatic, AInline ],
            meta: [ { name: ':pure', pos: pos } ],
            kind: FFun({
                args: args,
                ret: macro: lua.Table<String, defold.Go.GoProperty>,
                expr: expr
            })
        };
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
