package defold;

import defold.types.*;

/**
    Functions and messages for controlling sound components and
    mixer groups.

    See `SoundMessages` for related messages.
**/
@:native("_G.sound")
extern class Sound {
    /**
        Get mixer group gain

        Note that gain is in linear scale.

        @param group group name
        @return gain in linear scale
    **/
    static function get_group_gain(group:HashOrString):Float;

    /**
        Get a mixer group name as a string.

        Note that this function does not return correct group name in release mode

        @param group group name
        @return group name
    **/
    static function get_group_name(group:HashOrString):String;

    /**
        Get all mixer group names

        @return table of mixer groups names
    **/
    static function get_groups():lua.Table<Int,Hash>;

    /**
        Get peak value from mixer group.

        Note that the returned value might be an approximation and in particular
        the effective window might be larger than specified.

        @param group group name
        @param window window length in seconds
    **/
    static function get_peak(group:HashOrString, window:Float):SoundLeftRight<Float>;

    /**
        Get RMS (Root Mean Square) value from mixer group.

        Note that the returned value might be an approximation and in particular
        the effective window might be larger than specified.

        @param group group name
        @param window window length in seconds
    **/
    static function get_rms(group:HashOrString, window:Float):SoundLeftRight<Float>;

    /**
        Checks if background music is playing, e.g. from iTunes.

        On non mobile platforms, this function always return `false`.

        On Android you can only get a correct reading of this state if your game is not playing any sounds itself.
        This is a limitation in the Android SDK. If your game is playing any sounds, even with a gain of zero, this
        function will return `false`.

        The best time to call this function is:

         * In the `init` function of your main collection script before any sounds are triggered
         * In a window listener callback when the window.WINDOW_EVENT_FOCUS_GAINED event is received

        Both those times will give you a correct reading of the state even when your application is
        swapped out and in while playing sounds and it works equally well on Android and iOS.

        @return true if music is playing
    **/
    static function is_music_playing():Bool;

    /**
        Checks if a phone call is active. If there is an active phone call all
        other sounds will be muted until the phone call is finished.

        @return true if there is an active phone call
    **/
    static function is_phone_call_active():Bool;

    /**
        Plays a sound.

        Make the sound component play its sound. Multiple voices is supported. The limit is set to 32 voices per sound component.

        Note that gain is in linear scale, between 0 and 1.
        To get the dB value from the gain, use the formula `20 * log(gain)`.
        Inversely, to find the linear value from a dB value, use the formula `10<sup>db/20</sup>`.

        @param url the sound that should play
        @param play_properties optional table with properties
    **/
    static function play(url:HashOrStringOrUrl, ?play_properties:SoundMessagePlaySound):Void;

    /**
        Set gain on all active playing voices of a sound.

        Note that gain is in linear scale, between 0 and 1.
        To get the dB value from the gain, use the formula `20 * log(gain)`.
        Inversely, to find the linear value from a dB value, use the formula `10<sup>db/20</sup>`.

        @param url the sound to set the gain of
        @param gain sound gain between 0 and 1. The final gain of the sound will be a combination of this gain, the group gain and the master gain.
    **/
    static function set_gain(url:HashOrStringOrUrl, ?gain:Float):Void;

    /**
        Set mixer group gain

        Note that gain is in linear scale.

        @param group group name
        @param gain gain in linear scale
    **/
    static function set_group_gain(group:HashOrString, gain:Float):Bool;

    /**
        Stop a playing a sound(s).

        Stop playing all active voices

        @param url the sound that should stop
    **/
    static function stop(url:HashOrStringOrUrl):Void;
}

/**
    Messages related to the `Sound` module.
**/
@:publicFields
class SoundMessages {
    /**
        Plays a sound.

        Post this message to a sound-component to make it play its sound. Multiple voices is support. The limit is set to 32 voices per sound component.
    **/
    static var play_sound(default, never) = new Message<SoundMessagePlaySound>("play_sound");

    /**
        Set sound gain.

        Post this message to a sound-component to set gain on all active playing voices.
    **/
    static var set_gain(default, never) = new Message<SoundMessageSetGain>("set_gain");

    /**
        Stop a playing a sound(s).

        Post this message to a sound-component to make it stop playing all active voices
    **/
    static var stop_sound(default, never) = new Message<Void>("stop_sound");
}

/**
    Data for the `SoundMessages.play_sound` message and `Sound.play` method.
**/
typedef SoundMessagePlaySound = {
    /**
        Delay in seconds before the sound starts playing, default is 0.
    **/
    @:optional var delay:Float;

    /**
        Sound gain between 0 and 1, default is 1.

        The final gain of the sound will be a combination of this gain, the group gain and the master gain.
    **/
    @:optional var gain:Float;
}

/**
    Data for the `SoundMessages.set_gain` message.
**/
typedef SoundMessageSetGain = {
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
