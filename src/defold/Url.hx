package defold;

// TODO: looks like most apis support passing strings instead of url object
// so maybe it makes sense to make an abstract with with "from String"
extern class Url {
    var socket:Int;
    var path:Hash;
    var fragment:Hash;
}
