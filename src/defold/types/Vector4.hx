package defold.types;

/**
    Vector4 type, can be created with `defold.Vmath.vector4`.
**/
@:forward
extern abstract Vector4(Vector4Data) {
    @:op(a + b)
    private static inline function add(a:Vector4, b:Vector4):Vector4 {
        return untyped __lua__("({0}) + ({1})", a, b);
    }

    @:op(a - b)
    private static inline function sub(a:Vector4, b:Vector4):Vector4 {
        return untyped __lua__("({0}) - ({1})", a, b);
    }

    @:op(-b)
    private static inline function neg(a:Vector4):Vector4 {
        return untyped __lua__("-({0})", a);
    }

    @:op(a * b) @:commutative
    private static inline function mulScalar(a:Vector4, b:Float):Vector4 {
        return untyped __lua__("({0}) * ({1})", a, b);
    }

    @:op(a / b) @:commutative
    private static inline function divScalar(a:Vector4, b:Float):Vector4 {
        return untyped __lua__("({0}) / ({1})", a, b);
    }

    @:op(a * b)
    private static inline function mul(a:Vector4, b:Vector4):Vector4 {
        return untyped __lua__("({0}) * ({1})", a, b);
    }
}

private extern class Vector4Data {
    var x:Float;
    var y:Float;
    var z:Float;
    var w:Float;
}
