package defold.support;

#if (macro || doc_gen)
import haxe.macro.Context;
import haxe.macro.Expr;

/**
    This is a helper build macro for easily building classes with typed message constants.

    For example we can define a class like this:
    ```haxe
    @:build(defold.support.MessageBuilder.build())
    class MyMessages {
        var restart_game; // message with no params
        var set_counter:{counter:Int}; // message with params
    }
    ```

    It will be modified by this macro to this:
    ```haxe
    class MyMessages {
        public static final restart_game(default,never) = new Message<Void>("restart_game");
        public static final set_counter(default,never) = new Message<{counter:Int}>("set_counter");
    }
    ```

    This is handy for defining message enumerations that can later be used by pattern matching in `Script.on_message` methods.
**/
class MessageBuilder {
    public static function build():Array<Field> {
        #if macro
        var fields = Context.getBuildFields();
        for (field in fields) {
            switch (field.kind) {
                case FVar(t, null):
                    if (t == null) t = macro : Void;
                    var messageCT = macro : defold.types.Message<$t>;
                    var messageExpr = macro new defold.types.Message<$t>($v{field.name});
                    field.kind = FProp("default", "never", messageCT, messageExpr);
                    field.access.push(AFinal);
                    field.access.push(APublic);
                    field.access.push(AStatic);
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
