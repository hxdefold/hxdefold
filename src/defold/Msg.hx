package defold;

import defold.support.HashOrString;
import defold.support.HashOrStringOrUrl;

@:native("msg")
extern class Msg {
    @:overload(function(receiver:Null<HashOrStringOrUrl>, message_id:Message<Void>):Void {})
    static function post<T>(receiver:Null<HashOrStringOrUrl>, message_id:Message<T>, message:T):Void;

    @:overload(function():Url {})
    @:overload(function(socket:String, path:HashOrString, fragment:HashOrString):Url {})
    static function url(urlstring:String):Url;
}
