package defold.types;

/** *
 * Matrix4 type, can be created with `defold.Vmath.matrix4`.
 *
 * The first number is the row (starting from 0) and the second number is the column.
 * Columns can be accessed with c0 to c3, returning a vector4. Example: m.m21 which is equal to m.c1.z
* */
@:forward
extern abstract Matrix4(Matrix4Data)
{
    @:op(a * b)
    private static inline function mul(a:Matrix4, b:Matrix4):Matrix4
    {
        return untyped __lua__("({0}) * ({1})", a, b);
    }

    @:op(a * b) @:commutative
    private static inline function mulScalar(a:Matrix4, b:Float):Matrix4
    {
        return untyped __lua__("({0}) * ({1})", a, b);
    }

    @:op(a * b) @:commutative
    private static inline function mulVector(a:Matrix4, b:Vector4):Matrix4
    {
        return untyped __lua__("({0}) * ({1})", a, b);
    }
}

typedef Matrix4Data =
{
    var m00:Float;
    var m01:Float;
    var m02:Float;
    var m03:Float;

    var m10:Float;
    var m11:Float;
    var m12:Float;
    var m13:Float;

    var m20:Float;
    var m21:Float;
    var m22:Float;
    var m23:Float;

    var m30:Float;
    var m31:Float;
    var m32:Float;
    var m33:Float;

    var c0:Vector4;
    var c1:Vector4;
    var c2:Vector4;
    var c3:Vector4;
}
