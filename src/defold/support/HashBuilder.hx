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
    @:build(defold.support.HashBuilder.build())
    class MyProperties {
        var zoom;
        var speed;
        var positionY = "position.y";
    }
    ```

    It will be modified by this macro to this:
    ```haxe
    class MyProperties {
        public static final zoom(default,never) = Defold.hash("zoom");
        public static final speed(default,never) = Defold.hash("speed");
        public static final positionY(default,never) = Defold.hash("position.y");
    }
    ```

    This is useful, because hashes that are used often should be pre-computed and stored for better performance.
    ```haxe
    Go.get(url, "position.y"); // slow

    Go.get(url, MyProperties.positionY); // faster
    ```
**/
class HashBuilder {
	public static function build():Array<Field> {
		#if macro
		var fields:Array<Field> = Context.getBuildFields();

		for (field in fields) {
			switch (field.kind) {
				case FVar(t, expr):
					{
						if (t == null) {
							// Field without type, update its expression.
							var hashCT = macro:defold.types.Hash;
							var hashExpr = macro Defold.hash($v{field.name});

							if (expr != null) {
								hashExpr = macro Defold.hash(${expr});
							}

							field.kind = FProp("default", "never", hashCT, hashExpr);
						} else {
							field.kind = FProp("default", "never", t, expr);
						}
						field.access.push(AFinal);
						field.access.push(APublic);
						field.access.push(AStatic);
					}

				default:
			}
		}

		return fields;
		#else
		return [];
		#end
	}
}
#end
