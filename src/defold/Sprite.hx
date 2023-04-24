package defold;

import defold.types.*;

/**
    Functions, messages and properties used to manipulate sprite components.

    See `SpriteProperties` for related properties.
    See `SpriteMessages` for related messages.
**/
@:native("_G.sprite")
extern class Sprite {
    /**
        Play an animation on a sprite component from its tile set

        An optional completion callback function can be provided that will be called when
        the animation has completed playing. If no function is provided,
        a `animation_done` message is sent to the script that started the animation.

        @param url the sprite that should play the animation
        @param id name hash of the animation to play
        @param complete_function function to call when the animation has completed.
        @param play_properties optional table with properties
    **/
    static function play_flipbook<T>(url:HashOrStringOrUrl, id:Hash,
        ?complete_function:(self:T, message_id:Message<SpriteMessageAnimationDone>, message:SpriteMessageAnimationDone, sender:Url)->Void,
        ?play_properties:SpritePlayFlipbookProperties
    ):Void;

    /**
        Reset a shader constant for a sprite.

        The constant must be defined in the material assigned to the sprite.
        Resetting a constant through this function implies that the value defined in the material will be used.
        Which sprite to reset a constant for is identified by the URL.

        @param url the sprite that should have a constant reset
        @param name of the constant
    **/
    static function reset_constant(url:UrlOrString, name:HashOrString):Void;

    /**
        Set a shader constant for a sprite.

        The constant must be defined in the material assigned to the sprite.
        Setting a constant through this function will override the value set for that constant in the material.
        The value will be overridden until `Sprite.reset_constant` is called.
        Which sprite to set a constant for is identified by the URL.

        @param url the sprite that should have a constant set
        @param name of the constant
        @param value of the constant
    **/
    static function set_constant(url:UrlOrString, name:HashOrString, value:Vector4):Void;

    /**
        Sets horizontal flipping of the provided sprite's animations.

        Which sprite to flip is identified by the URL.
        If the currently playing animation is flipped by default, flipping it again will make it appear like the original texture.

        @param url the sprite that should flip its animations
        @param flip if the sprite should flip its animations or not
    **/
    static function set_hflip(url:UrlOrString, flip:Bool):Void;

    /**
        Sets vertical flipping of the provided sprite's animations.

        Which sprite to flip is identified by the URL.
        If the currently playing animation is flipped by default, flipping it again will make it appear like the original texture.

        @param url the sprite that should flip its animations
        @param flip if the sprite should flip its animations or not
    **/
    static function set_vflip(url:UrlOrString, flip:Bool):Void;
}

/**
    Properties related to the `Sprite` module.
**/
@:publicFields
class SpriteProperties {
    /**
        The non-uniform scale of the sprite.
    **/
    static var scale(default, never) = new Property<Vector3>("scale");

    /**
        The size of the sprite, not allowing for any additional scaling that may be applied.
        The type of the property is vector3. It is not possible to set the size if the size mode of the sprite is set to auto.
    **/
    static var size(default, never) = new Property<Vector3>("size");

    /**
        The image used when rendering the sprite.
    **/
    static var image(default, never) = new Property<TextureResourceReference>("image");

    /**
        The material used when rendering the sprite.
    **/
    static var material(default, never) = new Property<MaterialResourceReference>("material");

    /**
        The normalized animation cursor.
    **/
    static var cursor(default, never) = new Property<Float>("cursor");

    /**
        The animation playback rate. A multiplier to the animation playback rate.

        The playback_rate is a non-negative number, a negative value will be clamped to 0.
    **/
    static var playback_rate(default, never) = new Property<Float>("playback_rate");

    /**
        The current animation id. An animation that plays currently for the sprite.

        READ ONLY
    **/
    static var animation(default, never) = new Property<Hash>("animation");
}

/**
    Messages related to the `Sprite` module.
**/
@:publicFields
class SpriteMessages {
    /**
        Reports that an animation has completed.

        This message is sent to the sender of a `play_animation` message when the
        animation has completed.

        Note that this message is sent only for animations that play with the following
        playback modes:

         * Once Forward
         * Once Backward
         * Once Ping Pong

        See `play_animation` for more information and examples of how to use
        this message.
    **/
    static var animation_done(default, never) = new Message<SpriteMessageAnimationDone>("animation_done");

    /**
        Plays a sprite animation.

        Post this message to a sprite-component to make it play an animation from its tile set.
    **/
    static var play_animation(default, never) = new Message<SpriteMessagePlayAnimation>("play_animation");
}

/**
    Data for the `SpriteMessages.animation_done` message.
**/
typedef SpriteMessageAnimationDone = {
    /**
        The current tile of the sprite.
    **/
    var current_tile:Int;

    /**
        Id of the animation that was completed.
    **/
    var id:Hash;
}

/**
    Data for the `SpriteMessages.play_animation` message.
**/
typedef SpriteMessagePlayAnimation = {
    /**
        The id of the animation to play.
    **/
    var id:Hash;
}

/**
    Data for the `play_properties` argument of `Sprite.play_flipbook` method.
**/
typedef SpritePlayFlipbookProperties = {
    /**
        the normalized initial value of the animation cursor when the animation starts playing.
    **/
    var offset:Float;

    /**
        the rate with which the animation will be played. Must be positive.
    **/
    var playback_rate:Float;
}
