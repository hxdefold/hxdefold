package defold;

/**
    Functions for mathematical operations on vectors, matrices and quaternions.
**/
@:native("_G.vmath")
extern class Vmath {
    /**
        Calculates the conjugate of a quaternion.
    **/
    static function conj(q:Quaternion):Quaternion;

    /**
        Calculates the cross-product of two vectors.
    **/
    static function cross(v1:Vector3, v2:Vector3):Vector3;

    /**
        Calculates the dot-product of two vectors.
    **/
    @:overload(function(v1:Vector4, v2:Vector4):Float {})
    static function dot(v1:Vector3, v2:Vector3):Float;

    /**
        Calculates the inverse matrix.
    **/
    static function inv(m:Matrix4):Matrix4;

    /**
        Calculates the vector length.
    **/
    @:overload(function(v:Vector4):Float {})
    static function length(v:Vector3):Float;

    /**
        Calculates the squared vector length.
    **/
    @:overload(function(v:Vector4):Float {})
    static function length_sqr(v:Vector3):Float;

    /**
        Lerps between two vectors/quaternions/numbers.
    **/
    @:overload(function(t:Float, q1:Quaternion, q2:Quaternion):Quaternion {})
    @:overload(function(t:Float, n1:Float, n2:Float):Float {})
    @:overload(function(t:Float, v1:Vector4, v2:Vector4):Vector4 {})
    static function lerp(t:Float, v1:Vector3, v2:Vector3):Vector3;

    /**
        Creates a a copy of the specified matrix or new identity matrix.
    **/
    static function matrix4(?m:Matrix4):Matrix4;

    /**
        Creates a matrix from an axis and an angle.
    **/
    static function matrix4_axis_angle(v:Vector3, angle:Float):Matrix4;

    /**
        Creates a matrix from a quaternion.
    **/
    static function matrix4_from_quat(q:Quaternion):Matrix4;

    /**
        Creates a frustum matrix.
    **/
    static function matrix4_frustum(left:Float, right:Float, bottom:Float, top:Float, near:Float, far:Float):Matrix4;

    /**
        Creates a look-at view matrix.
    **/
    static function matrix4_look_at(eye:Vector3, look_at:Vector3, up:Vector3):Matrix4;

    /**
        Creates an orthographic projection matrix.
    **/
    static function matrix4_orthographic(left:Float, right:Float, bottom:Float, top:Float, near:Float, far:Float):Matrix4;

    /**
        Creates a perspective projection matrix.
    **/
    static function matrix4_perspective(fov:Float, aspect:Float, near:Float, far:Float):Matrix4;

    /**
        Creates a matrix from rotation around x-axis.
    **/
    static function matrix4_rotation_x(angle:Float):Matrix4;

    /**
        Creates a matrix from rotation around y-axis.
    **/
    static function matrix4_rotation_y(angle:Float):Matrix4;

    /**
        Creates a matrix from rotation around z-axis.
    **/
    static function matrix4_rotation_z(angle:Float):Matrix4;

    /**
        Normalizes a vector.
    **/
    @:overload(function(v:Vector4):Vector4 {})
    static function normalize(v:Vector3):Vector3;

    /**
        Calculates the inverse of an ortho-normal matrix.
    **/
    static function ortho_inv(m:Matrix4):Matrix4;

    /**
        Projects a vector onto another vector.
    **/
    static function project(v1:Vector3, v2:Vector3):Float;

    /**
        Creates a new quaternion from another existing quaternion, from its coordinates or a new identity quaternion,
    **/
    @:overload(function(?q:Quaternion):Quaternion {})
    static function quat(x:Float, y:Float, z:Float, w:Float):Quaternion;

    /**
        Creates a quaternion from axis and angle.

        Returns quaternion representing the axis-angle rotation.
    **/
    static function quat_axis_angle(v:Vector3, angle:Float):Quaternion;

    /**
        Creates a quaternion from three base vectors.

        Returns quaternion representing the rotation of the specified base vectors.
    **/
    static function quat_basis(x:Vector3, y:Vector3, z:Vector3):Quaternion;

    /**
        Creates a quaternion based on a vector rotation.
    **/
    static function quat_from_to(v1:Vector3, v2:Vector3):Quaternion;

    /**
        Creates a quaternion from rotation around x-axis.
    **/
    static function quat_rotation_x(angle:Float):Quaternion;

    /**
        Creates a quaternion from rotation around y-axis.
    **/
    static function quat_rotation_y(angle:Float):Quaternion;

    /**
        Creates a quaternion from rotation around z-axis.
    **/
    static function quat_rotation_z(angle:Float):Quaternion;

    /**
        Rotates a vector by a quaternion.

        Returns the rotated vector.
    **/
    static function rotate(q:Quaternion, v:Vector3):Vector3;

    /**
        Slerps between two vectors or quaternions.
    **/
    @:overload(function(t:Float, q1:Quaternion, q2:Quaternion):Quaternion {})
    @:overload(function(t:Float, v1:Vector4, v2:Vector4):Vector4 {})
    static function slerp(t:Float, v1:Vector3, v2:Vector3):Vector3;

    /**
        Creates a new vector from a table of values.
    **/
    // TODO: this should return some generic Vector type
    static function vector(t:lua.Table<Int,Float>):haxe.extern.EitherType<Vector3,Vector4>;

    /**
        Creates a new zero vector, a vector from scalar value, from another existing vector or from given coordinates.
    **/
    @:overload(function():Vector3 {})
    @:overload(function(n:Float):Vector3 {})
    @:overload(function(v:Vector3):Vector3 {})
    static function vector3(x:Float, y:Float, z:Float):Vector3;

    /**
        Creates a new zero vector, a vector from scalar value, from another existing vector or from given coordinates.
    **/
    @:overload(function():Vector4 {})
    @:overload(function(n:Float):Vector4 {})
    @:overload(function(v:Vector4):Vector4 {})
    static function vector4(x:Float, y:Float, z:Float, w:Float):Vector4;
}
