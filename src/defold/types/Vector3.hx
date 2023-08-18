package defold.types;

/**
    Vector3 type, can be created with `defold.Vmath.vector3`.
**/
@:forward
extern abstract Vector3(Vector3Data) {
    @:op(a + b)
    private static inline function add(a:Vector3, b:Vector3):Vector3 {
        return untyped __lua__("({0}) + ({1})", a, b);
    }

    @:op(a - b)
    private static inline function sub(a:Vector3, b:Vector3):Vector3 {
        return untyped __lua__("({0}) - ({1})", a, b);
    }

    @:op(-b)
    private static inline function neg(a:Vector3):Vector3 {
        return untyped __lua__("-({0})", a);
    }

    @:op(a * b) @:commutative
    private static inline function mulScalar(a:Vector3, b:Float):Vector3 {
        return untyped __lua__("({0}) * ({1})", a, b);
    }

    @:op(a / b)
    private static inline function divScalar(a:Vector3, b:Float):Vector3 {
        return untyped __lua__("({0}) / ({1})", a, b);
    }

    @:op(a * b)
    private static inline function mul(a:Vector3, b:Vector3):Vector3 {
        return untyped __lua__("({0}) * ({1})", a, b);
    }
}

private extern final class Vector3Data {
    var x:Float;
    var y:Float;
    var z:Float;
}
