package defold;

import defold.support.HashOrString;
import defold.support.UrlOrString;
import defold.Go.GoPlayback;

@:native("_G.spine")
extern class Spine {
    static function cancel(url:UrlOrString):Void;
    static function get_go(url:UrlOrString, bone_id:HashOrString):Hash;
    static function play(url:UrlOrString, animation_id:HashOrString, playback:GoPlayback, blend_duration:Float, ?complete_function:Void->Void):Void;
    static function reset_constant(url:UrlOrString, name:HashOrString):Void;
    static function set_constant(url:UrlOrString, name:HashOrString, value:Vector4):Void;
    static function set_ik_target(url:UrlOrString, ik_constraint_id:HashOrString, target_url:UrlOrString):Void;
    static function set_ik_target_position(url:UrlOrString, ik_constraint_id:HashOrString, position:Vector3):Void;
}

class SpineMessages {
    static var SpineAnimationDone(default,never) = new Message<{animation_id:Hash, playback:GoPlayback}>("spine_animation_done");
    static var SpineEvent(default,never) = new Message<SpineMessageSpineEvent>("spine_event");
}

typedef SpineMessageSpineEvent = {
    event_id:Hash,
    animation_id:Hash,
    t:Float,
    blend_weight:Float,
    integer:Int,
    float:Float,
    string:Hash,
}
