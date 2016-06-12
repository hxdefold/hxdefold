package defold.types;

/**
    Url object type, can be created with `defold.Msg.url`.
**/
extern class Url {
    var socket:Int;
    var path:Hash;
    var fragment:Hash;
}
