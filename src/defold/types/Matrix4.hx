package defold.types;

/**
    Matrix4 type, can be created with `defold.Vmath.matrix4`.
**/
@:forward
extern abstract Matrix4(Matrix4Data) {
    @:op(a * b)
    private static inline function mul(a:Matrix4, b:Matrix4):Matrix4 {
        return untyped __lua__("({0}) * ({1})", a, b);
    }

    @:op(a * b) @:commutative
    private static inline function mulScalar(a:Matrix4, b:Float):Matrix4 {
        return untyped __lua__("({0}) * ({1})", a, b);
    }

    @:op(a * b) @:commutative
    private static inline function mulVector(a:Matrix4, b:Vector4):Matrix4 {
        return untyped __lua__("({0}) * ({1})", a, b);
    }
}

extern class Matrix4Data {}
