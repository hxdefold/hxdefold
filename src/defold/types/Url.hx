package defold.types;

/**
    Url object type, can be created with `defold.Msg.url`.
**/
extern final class Url {
    var socket:UrlSocket;
    var path:Hash;
    var fragment:Hash;
}
