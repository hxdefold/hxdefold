package defold.support;

#if (macro || doc_gen)
import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.ExprTools;
using haxe.macro.Tools;

/**
    This is a helper build macro for easily building classes with `Hash` values.

    For example we can define a class like this:
    ```haxe
    @:build(defold.support.PropertyBuilder.build())
    class MyProperties {
        var position: Vector3;
        var speed: Float;
        var positionY: Float = "position.y";
    }
    ```

    It will be modified by this macro to this:
    ```haxe
    class MyProperties {
        public static final position(default,never): defold.types.Property<Vector3> = new defold.types.Property("position");
        public static final speed(default,never): defold.types.Property<Speed> = new defold.types.Property("speed");
        public static final positionY(default,never): defold.types.Property<Float> = new defold.types.Property("position.y");
    }
    ```

    This is useful, because hashes that are used often should be pre-computed and stored for better performance.
    ```haxe
    Go.get(url, "position.y"); // slow

    Go.get(url, MyProperties.positionY); // faster
    ```
**/
class PropertyBuilder
{
    public static function build(): Array<Field>
    {
        #if macro
        var fields: Array<Field> = Context.getBuildFields();

        for (field in fields)
        {
            switch (field.kind)
            {
                case FVar(t, expr):
                    {
                        if (t == null)
                        {
                            Context.error('property fields need to have a type', field.pos);
                        }
                        var propCt: ComplexType = TPath(
                            {
                                pack: [ 'defold', 'types' ],
                                name: 'Property',
                                params: [ TPType(t) ]
                            });
                        var propExpr: Expr = macro new defold.types.Property($v{field.name});
                        if (expr != null)
                        {
                            propExpr = macro new defold.types.Property(${expr});
                        }

                        field.kind = FProp("default", "never", propCt, propExpr);

                        field.access.push(AFinal);
                        field.access.push(APublic);
                        field.access.push(AStatic);
                    }

                default:
            }
        }

        return fields;
        #else
        return [ ];
        #end
    }
}
#end
