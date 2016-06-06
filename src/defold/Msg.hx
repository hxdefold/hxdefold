package defold;

import haxe.extern.EitherType;
import defold.support.HashOrString;
import defold.support.HashOrStringOrUrl;

@:native("_G.msg")
extern class Msg {
    @:overload(function(receiver:Null<HashOrStringOrUrl>, message_id:Message<Void>):Void {})
    static function post<T>(receiver:Null<HashOrStringOrUrl>, message_id:Message<T>, message:T):Void;

    @:overload(function():Url {})
    @:overload(function(socket:EitherType<String,Int>, path:HashOrString, fragment:HashOrString):Url {})
    static function url(urlstring:String):Url;
}
