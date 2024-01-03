package defold;

import defold.types.*;
import defold.Go.GoPlayback;

/**
    Functions and messages for interacting with model components.

    See `ModelProperties` for related properties.
    See `ModelMessages` for related messages.
**/
@:native("_G.model")
extern final class Model
{
    /**
        Cancel all animation on a model.

        @param url the model for which to cancel the animation
    **/
    static function cancel(url:UrlOrString):Void;

    /**
        Retrieve the game object corresponding to a model skeleton bone.

        The returned game object can be used for parenting and transform queries.
        This function has complexity O(n), where n is the number of bones in the model skeleton.
        Game objects corresponding to a model skeleton bone can not be individually deleted.
        Only available from .script files.

        @param url the model to query
        @param boneId id of the corresponding bone
        @return id of the game object
    **/
    @:pure
    @:native('get_go')
    static function getGo(url:UrlOrString, boneId:HashOrString):Hash;

    /**
        Play an animation on a model.

        @param url the model for which to play the animation
        @param animId id of the animation to play
        @param playback playback mode of the animation
        @param playProperties optional table with properties
    **/
    @:native('play_anim')
    static function playAnim(url:UrlOrString, animId:HashOrString, playback:GoPlayback, ?playProperties:ModelPlayAnimProperties):Void;

    /**
        Reset a shader constant for a model.

        The constant must be defined in the material assigned to the model.
        Resetting a constant through this function implies that the value defined in the material will be used.
        Which model to reset a constant for is identified by the URL.

        @param url the model that should have a constant reset
        @param name of the constant
    **/
    @:native('reset_constant')
    static function resetConstant(url:UrlOrString, name:HashOrString):Void;

    /**
        Set a shader constant for a model component.

        The constant must be defined in the material assigned to the model.
        Setting a constant through this function will override the value set for that constant in the material.
        The value will be overridden until model.reset_constant is called.
        Which model to set a constant for is identified by the URL.

        @param url the model that should have a constant set
        @param name name of the constant
        @param value value of the constant
    **/
    @:native('set_constant')
    static function setConstant(url:UrlOrString, name:HashOrString, value:Vector4):Void;

    /**
     * Enable or disable visibility of a mesh.
     *
     * @param url the model
     * @param meshId the id of the mesh
     * @param enabled `true` if the mesh should be visible, `false` if it should be hidden
     */
    @:native('set_mesh_enabled')
    static function setMeshEnabled(url:HashOrStringOrUrl, meshId:HashOrStringOrUrl, enabled:Bool):Void;

    /**
     * Get the enabled state of a mesh
     *
     * @param url the model
     * @param meshId the id of the mesh
     * @return `true` true if the mesh is visible, false otherwise
     */
    @:native('get_mesh_enabled')
    static function getMeshEnabled(url:HashOrStringOrUrl, meshId:HashOrStringOrUrl):Bool;
}

/**
    Data for the `play_properties` argument of the `Model.play_anim` method.
**/
typedef ModelPlayAnimProperties =
{
    /**
        Duration of a linear blend between the current and new animation.
    **/
    var ?blend_duration:Float;

    /**
        The normalized initial value of the animation cursor when the animation starts playing.
    **/
    var ?offset:Float;

    /**
        The rate with which the animation will be played.
        Must be positive.
    **/
    var ?playback_rate:Float;
}

/**
    Messages related to the `Model` module.
**/
@:publicFields
class ModelMessages
{
    /**
        Reports the completion of a Model animation.

        This message is sent when a Model animation has finished playing back to the script
        that started the animation.

        No message is sent if a completion callback function was supplied
        when the animation was started. No message is sent if the animation is cancelled with
        `Model.cancel`. This message is sent only for animations that play with
        the following playback modes:

         * `GoPlayback.PLAYBACK_ONCE_FORWARD`
         * `GoPlayback.PLAYBACK_ONCE_BACKWARD`
         * `GoPlayback.PLAYBACK_ONCE_PINGPONG`
    **/
    static var model_animation_done(default, never) = new Message<ModelMessageModelAnimationDone>("model_animation_done");
}

/**
    Data for the `ModelMessages.model_animation_done` message.
**/
typedef ModelMessageModelAnimationDone =
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
    Properties related to the `Model` module.
**/
@:publicFields
class ModelProperties
{
    /**
        The current animation set on the component.
    **/
    static var animation(default, never) = new Property<Hash>("animation");

    /**
        The normalized animation cursor.

        Please note that model events may not fire as expected when the cursor is manipulated directly.
    **/
    static var cursor(default, never) = new Property<Float>("cursor");

    /**
        The animation playback rate. A multiplier to the animation playback rate.
    **/
    static var playback_rate(default, never) = new Property<Float>("playback_rate");

    /**
        (READ ONLY) Returns the texture path hash of the model. Used for getting/setting resource data
    **/
    static var texture0(default, never) = new Property<Hash>("texture0");
}
