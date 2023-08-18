package defold;

import defold.types.*;

/**
    Functions for passing messages and constructing URL objects.
**/
@:native("_G.msg")
extern final class Msg
{
    /**
        Post a message to a receiving URL. The most common case is to send messages
        to a component. If the component part of the receiver is omitted, the message
        is broadcast to all components in the game object.

        The following receiver shorthands are available:

         * `"."` the current game object
         * `"#"` the current component

        NOTE: There is a 2 kilobyte limit to the message parameter table size.

        @param receiver The receiver must be a string in URL-format, a URL object, a hashed string or `nil`.
        @param messageId The id must be a string or a hashed string.
        @param message a lua table with message parameters to send.
    **/
    @:overload(function(receiver:Null<HashOrStringOrUrl>, messageId:Message<Void>):Void {})
    static function post<T>(receiver:Null<HashOrStringOrUrl>, messageId:Message<T>, message:T):Void;

    /**
        Creates a new URL.

        The format of the string must be `"[socket:][path][#fragment]"`, which is similar to a http URL.

        When addressing instances, `socket` is the name of the collection. `path` is the id of the instance,
        which can either be relative the instance of the calling script or global. `fragment` would be the id of the desired component.

        Calling without `urlstring` is equivalent to `Msg.url("")`.

        @param urlstring string to create the url from
        @param socket socket of the URL
        @param path path of the URL
        @param fragment fragment of the URL
        @return a new URL
    **/
    @:pure
    @:overload(function():Url {})
    @:overload(function(socket:HashOrString, path:HashOrString, fragment:HashOrString):Url {})
    @:overload(function(socket:UrlSocket, path:HashOrString, fragment:HashOrString):Url {})
    static function url(urlstring:String):Url;
}
