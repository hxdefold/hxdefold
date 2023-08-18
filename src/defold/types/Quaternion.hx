package defold.types;

/**
    Quaternion type, can be created with `defold.Vmath.quat`.
**/
@:forward
extern abstract Quaternion(QuaternionData) {
    @:op(a * b)
    private static inline function mul(a:Quaternion, b:Quaternion):Quaternion {
        return untyped __lua__("({0}) * ({1})", a, b);
    }
}

private extern final class QuaternionData {
    var x:Float;
    var y:Float;
    var z:Float;
    var w:Float;
}
