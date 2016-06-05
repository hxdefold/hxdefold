package defold;

import haxe.extern.EitherType;
import defold.support.*;

/**
    Manipulation of game objects and core hooks for Lua script logic.
**/
@:native("go")
extern class Go {
    static function animate(url:HashOrStringOrUrl, property:HashOrString, playback:Playback, to:EitherType<Vector3,EitherType<Quaternion,Float>>, easing:EitherType<Easing,Vector3>, duration:Float, ?delay:Float, ?complete_function:Void->Void):Void;
    static function cancel_animations(url:HashOrStringOrUrl, property:HashOrString):Void;

    @:overload(function(id:HashOrStringOrUrl):Void {})
    static function delete():Void;

    @:overload(function(ids:lua.Table<Int,Hash>):Void {})
    static function delete_all():Void;

    static function get(url:HashOrStringOrUrl, id:HashOrString):GoProperty;

    static function get_id(?path:String):Hash;

    static function get_position(?id:HashOrStringOrUrl):Vector3;
    static function get_rotation(?id:HashOrStringOrUrl):Quaternion;
    static function get_scale(?id:HashOrStringOrUrl):Float;
    static function get_scale_vector(?id:HashOrStringOrUrl):Vector3;

    static function get_world_position(?id:HashOrStringOrUrl):Vector3;
    static function get_world_rotation(?id:HashOrStringOrUrl):Quaternion;
    static function get_world_scale(?id:HashOrStringOrUrl):Float;

    static function property(name:String, def:GoProperty):Void;

    static function set(url:HashOrStringOrUrl, id:HashOrString, value:GoProperty):Void;

    static function set_position(position:Vector3, ?id:HashOrStringOrUrl):Void;
    static function set_rotation(rotation:Quaternion, ?id:HashOrStringOrUrl):Void;
    static function set_scale(rotation:EitherType<Float,Vector3>, ?id:HashOrStringOrUrl):Void;
}
