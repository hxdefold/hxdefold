package defold;

@:forward
extern abstract Vector4(Vector4Data) {
    @:op(a + b)
    static inline function add(a:Vector4, b:Vector4):Vector4 {
        return untyped __lua__("({0}) + ({1})", a, b);
    }

    @:op(a - b)
    static inline function sub(a:Vector4, b:Vector4):Vector4 {
        return untyped __lua__("({0}) - ({1})", a, b);
    }

    @:op(a * b) @:commutative
    static inline function mul(a:Vector4, b:Float):Vector4 {
        return untyped __lua__("({0}) * ({1})", a, b);
    }
}

private extern class Vector4Data {
    var x:Float;
    var y:Float;
    var z:Float;
    var w:Float;
}
