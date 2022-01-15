package defold;

import defold.types.*;
import defold.Go.GoPlayback;
import defold.Gui.GuiNode;

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
    static var spine_animation_done(default,never) = new Message<SpineMessageSpineAnimationDone>("spine_animation_done");

    /**
        Reports an incoming event from the Spine animation.

        This message is sent when Spine animation playback fires events.
        These events has to be defined on the animation track in the Spine animation editor.
        An event can contain custom values expressed in the fields "integer", "float" and "string".
    **/
    static var spine_event(default,never) = new Message<SpineMessageSpineEvent>("spine_event");
}

/**
    Data for the `SpineMessages.spine_animation_done` message.
**/
typedef SpineMessageSpineAnimationDone =
{
    /**
        The id of the completed animation.
    **/
    var animation_id:Hash;


    /**
        The playback mode of the completed animation.
    **/
    var playback:GoPlayback;
}

/**
    Data for the `SpineMessages.spine_event` message.
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

    /**
        the source spine gui node if the event originated from gui, otherwise nil
    **/
    var node:Null<GuiNode>;
}
