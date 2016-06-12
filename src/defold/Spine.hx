package defold;

import defold.types.*;
import defold.Go.GoPlayback;

/**
    Functions and messages for interacting with the 'Spine' 2D bone animation system.

    See `SpineMessages` for messages related to spine component.
**/
@:native("_G.spine")
extern class Spine {
    /**
        Cancel all animation on a spine model.
    **/
    static function cancel(url:UrlOrString):Void;

    /**
        Retrieve the game object corresponding to a spine model skeleton bone.

        The returned game object can be used for parenting and transform queries.
        This function has complexity O(n), where n is the number of bones in the spine model skeleton.
        Game objects corresponding to a spine model skeleton bone can not be individually deleted.
    **/
    static function get_go(url:UrlOrString, bone_id:HashOrString):Hash;

    /**
        Play an animation on a spine model.
    **/
    static function play(url:UrlOrString, animation_id:HashOrString, playback:GoPlayback, blend_duration:Float, ?complete_function:Void->Void):Void;

    /**
        Reset a shader constant for a spine model.

        The constant must be defined in the material assigned to the spine model.
        Resetting a constant through this function implies that the value defined in the material will be used.
    **/
    static function reset_constant(url:UrlOrString, name:HashOrString):Void;

    /**
        Set a shader constant for a spine model.

        The constant must be defined in the material assigned to the spine model.
        Setting a constant through this function will override the value set for that constant in the material.
        The value will be overridden until `Spine.reset_constant` is called.
    **/
    static function set_constant(url:UrlOrString, name:HashOrString, value:Vector4):Void;

    /**
        Set the IK constraint object target position to follow position of a game object.
    **/
    static function set_ik_target(url:UrlOrString, ik_constraint_id:HashOrString, target_url:UrlOrString):Void;

    /**
        Set the target position of an IK constraint object.
    **/
    static function set_ik_target_position(url:UrlOrString, ik_constraint_id:HashOrString, position:Vector3):Void;
}

/**
    Messages related to spine components.
**/
@:publicFields
class SpineMessages {
    /**
        Reports the completion of a Spine animation.

        This message is sent when a Spine animation has finished playing back to the script that started the animation.
        This message is sent only for animations that play with the following playback modes and no message is sent if the animation is cancelled with `Spine.cancel`:
         * `GoPlayback.PLAYBACK_ONCE_FORWARD`
         * `GoPlayback.PLAYBACK_ONCE_BACKWARD`
         * `GoPlayback.PLAYBACK_ONCE_PINGPONG`
    **/
    static var SpineAnimationDone(default,never) = new Message<{animation_id:Hash, playback:GoPlayback}>("spine_animation_done");

    /**
        Reports an incoming event from the Spine animation.

        This message is sent when Spine animation playback fires events.
        These events has to be defined on the animation track in the Spine animation editor.
        An event can contain custom values expressed in the fields "integer", "float" and "string".
    **/
    static var SpineEvent(default,never) = new Message<SpineMessageSpineEvent>("spine_event");
}

/**
    Data for the `SpineMessages.SpineEvent` message.
**/
typedef SpineMessageSpineEvent = {
    /**
        The id of the event.
    **/
    var event_id:Hash;

    /**
        The id of the animation.
    **/
    var animation_id:Hash;

    /**
        The time of the event in seconds, relative to the start of the animation.
    **/
    var t:Float;

    /**
        The blend weight (between 0.0-1.0) of the current animation at time `t`.
    **/
    var blend_weight:Float;

    /**
        User defined integer value for the event.
    **/
    var integer:Int;

    /**
        User defined floating point value for the event.
    **/
    var float:Float;

    /**
        User defined string value for the event.
    **/
    var string:Hash;
}
