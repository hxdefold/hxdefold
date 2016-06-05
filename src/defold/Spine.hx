package defold;

import defold.support.HashOrString;
import defold.support.UrlOrString;

@:native("spine")
extern class Spine {
    static function cancel(url:UrlOrString):Void;
    static function get_go(url:UrlOrString, bone_id:HashOrString):Hash;
    static function play(url:UrlOrString, animation_id:HashOrString, playback:Playback, blend_duration:Float, ?complete_function:Void->Void):Void;
    static function reset_constant(url:UrlOrString, name:HashOrString):Void;
    static function set_constant(url:UrlOrString, name:HashOrString, value:Vector4):Void;
    static function set_ik_target(url:UrlOrString, ik_constraint_id:HashOrString, target_url:UrlOrString):Void;
    static function set_ik_target_position(url:UrlOrString, ik_constraint_id:HashOrString, position:Vector3):Void;
}
