package defold;

@:forward
extern abstract Vector3(Vector3Data) {
    @:op(a + b)
    static inline function add(a:Vector3, b:Vector3):Vector3 {
        return untyped __lua__("({0}) + ({1})", a, b);
    }

    @:op(a - b)
    static inline function sub(a:Vector3, b:Vector3):Vector3 {
        return untyped __lua__("({0}) - ({1})", a, b);
    }

    @:op(a * b) @:commutative
    static inline function mul(a:Vector3, b:Float):Vector3 {
        return untyped __lua__("({0}) * ({1})", a, b);
    }
}

private extern class Vector3Data {
    var x:Float;
    var y:Float;
    var z:Float;
}
