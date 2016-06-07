package defold;

import haxe.extern.EitherType;
import defold.support.*;

/**
    Manipulation of game objects and core hooks for Lua script logic.
**/
@:native("_G.go")
extern class Go {
    static function animate(url:HashOrStringOrUrl, property:HashOrString, playback:GoPlayback, to:EitherType<Vector3,EitherType<Quaternion,Float>>, easing:EitherType<GoEasing,Vector3>, duration:Float, ?delay:Float, ?complete_function:Void->Void):Void;
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

@:publicFields
class GoMessages {
    static var AcquireInputFocus(default,never) = new Message<Void>("acquire_input_focus");
    static var Disable(default,never) = new Message<Void>("disable");
    static var Enable(default,never) = new Message<Void>("enable");
    static var ReleaseInputFocus(default,never) = new Message<Void>("release_input_focus");
    static var SetParent(default,never) = new Message<{parent_id:Hash, ?keep_world_transform:Int}>("set_parent");
}

@:native("_G.go")
@:enum extern abstract GoEasing({}) {
    var EASING_INBACK;
    var EASING_INBOUNCE;
    var EASING_INCIRC;
    var EASING_INCUBIC;
    var EASING_INELASTIC;
    var EASING_INEXPO;
    var EASING_INOUTBACK;
    var EASING_INOUTBOUNCE;
    var EASING_INOUTCIRC;
    var EASING_INOUTCUBIC;
    var EASING_INOUTELASTIC;
    var EASING_INOUTEXPO;
    var EASING_INOUTQUAD;
    var EASING_INOUTQUART;
    var EASING_INOUTQUINT;
    var EASING_INOUTSINE;
    var EASING_INQUAD;
    var EASING_INQUART;
    var EASING_INQUINT;
    var EASING_INSINE;
    var EASING_LINEAR;
    var EASING_OUTBACK;
    var EASING_OUTBOUNCE;
    var EASING_OUTCIRC;
    var EASING_OUTCUBIC;
    var EASING_OUTELASTIC;
    var EASING_OUTEXPO;
    var EASING_OUTINBACK;
    var EASING_OUTINBOUNCE;
    var EASING_OUTINCIRC;
    var EASING_OUTINCUBIC;
    var EASING_OUTINELASTIC;
    var EASING_OUTINEXPO;
    var EASING_OUTINQUAD;
    var EASING_OUTINQUART;
    var EASING_OUTINQUINT;
    var EASING_OUTINSINE;
    var EASING_OUTQUAD;
    var EASING_OUTQUART;
    var EASING_OUTQUINT;
    var EASING_OUTSINE;
}

@:native("_G.go")
@:enum extern abstract GoPlayback({}) {
    var PLAYBACK_ONCE_FORWARD;
    var PLAYBACK_ONCE_BACKWARD;
    var PLAYBACK_ONCE_PINGPONG;
    var PLAYBACK_LOOP_FORWARD;
    var PLAYBACK_LOOP_BACKWARD;
    var PLAYBACK_LOOP_PINGPONG;
}
