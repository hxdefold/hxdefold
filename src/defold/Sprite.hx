package defold;

import defold.support.UrlOrString;
import defold.support.HashOrString;

/**
    Functions, messages and properties used to manipulate sprite components.

    See `SpriteMessages` for standard sprite messages.
**/
@:native("_G.sprite")
extern class Sprite {
    /**
        Reset a shader constant for a sprite.

        The constant must be defined in the material assigned to the sprite.
        Resetting a constant through this function implies that the value defined in the material will be used.
    **/
    static function reset_constant(url:UrlOrString, name:HashOrString):Void;

    /**
        Set a shader constant for a sprite.

        The constant must be defined in the material assigned to the sprite.
        Setting a constant through this function will override the value set for that constant in the material.
        The value will be overridden until `Sprite.reset_constant` is called.
    **/
    static function set_constant(url:UrlOrString, name:HashOrString, value:Vector4):Void;

    /**
        Make a sprite flip the animations horizontally or not.

        If the currently playing animation is flipped by default, flipping it again will make it appear like the original texture.
    **/
    static function set_hflip(url:UrlOrString, flip:Bool):Void;

    /**
        Make a sprite flip the animations vertically or not.

        If the currently playing animation is flipped by default, flipping it again will make it appear like the original texture.
    **/
    static function set_vflip(url:UrlOrString, flip:Bool):Void;
}

/**
    Messages related to sprite components.
**/
@:publicFields
class SpriteMessages {
    /**
        Reports that an animation has completed.

        This message is sent to the sender of a `PlayAnimation` message when the animation has completed.
        Note that only animations played either forward or backward once ever completes.
    **/
    static var AnimationDone(default,never) = new Message<{current_tile:Int, id:Hash}>("animation_done");

    /**
        Plays a sprite animation.

        Post this message to a sprite component to make it play an animation from its tile set.
    **/
    static var PlayAnimation(default,never) = new Message<{id:Hash}>("play_animation");
}
