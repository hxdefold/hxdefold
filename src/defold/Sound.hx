package defold;

import defold.types.*;

/**
    Functions and messages for controlling sound components.

    See `SoundMessages` for sound component messages.
**/
@:native("_G.sound")
extern class Sound {
    /**
        Get mixer group gain.

        Note that gain is in linear scale.
    **/
    static function get_group_gain(group:HashOrString):Float;

    /**
        Get a mixer group name as a string.

        Note that this function does not return correct group name in release mode
    **/
    static function get_group_name(group:HashOrString):String;

    /**
        Get all mixer group names.
    **/
    static function get_groups():lua.Table<Int,Hash>;

    /**
        Get peak gain value from mixer group.

        Note that the returned value might be an approximation and
        in particular the effective window might be larger than specified.
    **/
    static function get_peak(group:HashOrString, window:Float):SoundLeftRight<Float>;

    /**
        Get RMS (Root Mean Square) value from mixer group.

        Note that the returned value might be an approximation and
        in particular the effective window might be larger than specified.
    **/
    static function get_rms(group:HashOrString, window:Float):SoundLeftRight<Float>;

    /**
        Checks if background music is playing, e.g. from iTunesю
    **/
    static function is_music_playing():Bool;

    /**
        Set mixer group gain.

        Note that gain is in linear scale.
    **/
    static function set_group_gain(group:HashOrString, gain:Float):Bool;
}

/**
    Messages related to sound components.
**/
@:publicFields
class SoundMessages {
    /**
        Plays a sound.

        Post this message to a sound-component to make it play its sound.
        Multiple voices is supported. The limit is set to 32 voices per sound component.
    **/
    static var PlaySound(default,never) = new Message<SoundMessagePlaySound>("play_sound");

    /**
        Set sound gain.

        Post this message to a sound-component to set gain on all active playing voices.

        `gain` is between 0 and 1, default is 1.
    **/
    static var SetGain(default,never) = new Message<{?gain:Float}>("set_gain");

    /**
        Stop a playing a sound(s).

        Post this message to a sound-component to make it stop playing all active voices.
    **/
    static var StopSound(default,never) = new Message<Void>("stop_sound");
}

/**
    Data for `SoundMessages.PlaySound` message.
**/
typedef SoundMessagePlaySound = {
    /**
        Delay in seconds before the sound starts playing, default is 0.
    **/
    @:optional var delay:Float;

    /**
        Sound gain between 0 and 1, default is 1.
    **/
    @:optional var gain:Float;
}

/**
    A type for returning multiple values from the sound component API.
**/
@:multiReturn extern class SoundLeftRight<T> {
    /**
        Left channel value.
    **/
    var left:T;

    /**
        Right channel value.
    **/
    var right:T;
}
