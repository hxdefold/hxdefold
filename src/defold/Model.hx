package defold;

import defold.types.*;
import defold.Go.GoPlayback;

/**
    Functions and messages for interacting with model components.
**/
@:native("_G.model")
extern class Model {
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
        @param bone_id id of the corresponding bone
        @return id of the game object
    **/
    static function get_go(url:UrlOrString, bone_id:HashOrString):Hash;

    /**
        Play an animation on a model.

        @param url the model for which to play the animation
        @param anim_id id of the animation to play
        @param playback playback mode of the animation
        @param play_properties optional table with properties
    **/
    static function play_anim(url:UrlOrString, anim_id:HashOrString, playback:GoPlayback, ?play_properties:ModelPlayAnimProperties):Void;

    /**
        Reset a shader constant for a model.

        The constant must be defined in the material assigned to the model.
        Resetting a constant through this function implies that the value defined in the material will be used.
        Which model to reset a constant for is identified by the URL.

        @param url the model that should have a constant reset
        @param name of the constant
    **/
    static function reset_constant(url:UrlOrString, name:HashOrString):Void;

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
    static function set_constant(url:UrlOrString, name:HashOrString, value:Vector4):Void;
}

/**
    Data for the `play_properties` argument of the `Model.play_anim` method.
**/
typedef ModelPlayAnimProperties = {
    /**
        Duration of a linear blend between the current and new animation.
    **/
    @:optional var blend_duration:Float;

    /**
        The normalized initial value of the animation cursor when the animation starts playing.
    **/
    @:optional var offset:Float;

    /**
        The rate with which the animation will be played.
        Must be positive.
    **/
    @:optional var playback_rate:Float;
}
