package defold;

@:native("vmath")
extern class Vmath {
    static function conj(q:Quaternion):Quaternion;

    static function cross(v1:Vector3, v2:Vector3):Vector3;

    @:overload(function(v1:Vector4, v2:Vector4):Float {})
    static function dot(v1:Vector3, v2:Vector3):Float;

    static function inv(m:Matrix4):Matrix4;

    @:overload(function(v:Vector4):Float {})
    static function length(v:Vector3):Float;

    @:overload(function(v:Vector4):Float {})
    static function length_sqr(v:Vector3):Float;

    @:overload(function(t:Float, q1:Quaternion, q2:Quaternion):Quaternion {})
    @:overload(function(t:Float, n1:Float, n2:Float):Float {})
    @:overload(function(t:Float, v1:Vector4, v2:Vector4):Vector4 {})
    static function lerp(t:Float, v1:Vector3, v2:Vector3):Vector3;

    static function matrix4(?m:Matrix4):Matrix4;
    static function matrix4_axis_angle(v:Vector3, angle:Float):Matrix4;
    static function matrix4_from_quat(q:Quaternion):Matrix4;
    static function matrix4_frustum(left:Float, right:Float, bottom:Float, top:Float, near:Float, far:Float):Matrix4;
    static function matrix4_look_at(eye:Vector3, look_at:Vector3, up:Vector3):Matrix4;
    static function matrix4_orthographic(left:Float, right:Float, bottom:Float, top:Float, near:Float, far:Float):Matrix4;
    static function matrix4_perspective(fov:Float, aspect:Float, near:Float, far:Float):Matrix4;
    static function matrix4_rotation_x(angle:Float):Matrix4;
    static function matrix4_rotation_y(angle:Float):Matrix4;
    static function matrix4_rotation_z(angle:Float):Matrix4;

    @:overload(function(v:Vector4):Vector4 {})
    static function normalize(v:Vector3):Vector3;

    static function ortho_inv(m:Matrix4):Matrix4;

    static function project(v1:Vector3, v2:Vector3):Float;

    @:overload(function():Quaternion {})
    static function quat(x:Float, y:Float, z:Float, w:Float):Quaternion;
    static function quat_axis_angle(v:Vector3, angle:Float):Quaternion;
    static function quat_basis(x:Float, y:Float, z:Float):Quaternion;
    static function quat_from_to(v1:Vector3, v2:Vector3):Quaternion;
    static function quat_rotation_x(angle:Float):Quaternion;
    static function quat_rotation_y(angle:Float):Quaternion;
    static function quat_rotation_z(angle:Float):Quaternion;

    static function rotate(q:Quaternion, v:Vector3):Vector3;

    @:overload(function(t:Float, q1:Quaternion, q2:Quaternion):Quaternion {})
    @:overload(function(t:Float, v1:Vector4, v2:Vector4):Vector4 {})
    static function slerp(t:Float, v1:Vector3, v2:Vector3):Vector3;

    static function vector(t:lua.Table<Int,Float>):haxe.extern.EitherType<Vector3,Vector4>;

    @:overload(function():Vector3 {})
    @:overload(function(n:Float):Vector3 {})
    @:overload(function(v:Vector3):Vector3 {})
    static function vector3(x:Float, y:Float, z:Float):Vector3;

    @:overload(function():Vector4 {})
    @:overload(function(n:Float):Vector4 {})
    @:overload(function(v:Vector4):Vector4 {})
    static function vector4(x:Float, y:Float, z:Float, w:Float):Vector4;
}
