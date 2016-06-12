package defold;

import haxe.extern.EitherType;
import defold.types.*;

/**
    Functions for passing messages and constructing URL objects.
**/
@:native("_G.msg")
extern class Msg {
    /**
        Posts a message to a receiving URL.
    **/
    @:overload(function(receiver:Null<HashOrStringOrUrl>, message_id:Message<Void>):Void {})
    static function post<T>(receiver:Null<HashOrStringOrUrl>, message_id:Message<T>, message:T):Void;

    /**
        The format of the string must be "[socket:][path][#fragment]", which is similar to a http URL.

        When addressing instances, `socket` is the name of the collection.
        `path` is the id of the instance, which can either be relative the instance of the calling script or global.
        `fragment` would be the id of the desired component.

        Calling without `urlstring` is equivalent to `Msg.url("")`.
    **/
    @:overload(function():Url {})
    @:overload(function(socket:EitherType<String,Int>, path:HashOrString, fragment:HashOrString):Url {})
    static function url(urlstring:String):Url;
}
