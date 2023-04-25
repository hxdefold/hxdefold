package defold;

import defold.types.*;
import defold.types.util.LuaArray;

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
    static function get_groups():LuaArray<Hash>;

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
        Pause all active voices.

        @param url the sound that should pause
        @param pause true if the sound should pause
    **/
    static function pause(url:HashOrStringOrUrl, pause:Bool):Void;

    /**
        Plays a sound.

        Make the sound component play its sound. Multiple voices are supported. The limit is set to 32 voices per sound component.

        Note that gain is in linear scale, between 0 and 1.
        To get the dB value from the gain, use the formula `20 * log(gain)`.
        Inversely, to find the linear value from a dB value, use the formula `10<sup>db/20</sup>`.

        A sound will continue to play even if the game object the sound component belonged to is deleted. You can send a stop_sound to stop the sound.

        @param url the sound that should play
        @param play_properties optional table with properties
        @return The `play_id` of the sound that was played.
    **/
    static function play<T>(url:HashOrStringOrUrl, ?play_properties:SoundPlayOptions, ?complete_function:T->Hash->SoundMessageSoundDone->Url->Void):SoundPlayId;

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
        Set panning on all active playing voices of a sound.

        The valid range is from `-1.0` to `1.0`, representing `-45` degrees left, to `+45` degrees right.

        @param url the sound to set the panning value to
        @param pan sound panning between `-1.0` and `1.0`
    **/
    static function set_pan(url:HashOrStringOrUrl, pan:Float):Void;

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

        Post this message to a sound-component to make it play its sound. Multiple voices is supported. The limit is set to 32 voices per sound component.
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

    /**
        Callback message indicating that a sound has finished playing.
    **/
    static var sound_done(default, never) = new Message<Void>("sound_done");
}

/**
    Data for the `Sound.play` options.
**/
typedef SoundPlayOptions = {
    /**
        Delay in seconds before the sound starts playing, default is 0.
    **/
    var ?delay:Float;

    /**
        Sound gain between 0 and 1, default is 1.

        The final gain of the sound will be a combination of this gain, the group gain and the master gain.
    **/
    var ?gain:Float;

    /**
        Sound pan between -1 and 1, default is 0. The final pan of the sound will be an addition of this pan and the sound pan.
    **/
    var ?pan:Float;

    /**
        Sound speed where 1.0 is normal speed, 0.5 is half speed and 2.0 is double speed.
        The final speed of the sound will be a multiplication of this speed and the sound speed.
    **/
    var ?speed:Float;
}

/**
    Data for the `SoundMessages.play_sound` message.
**/
typedef SoundMessagePlaySound = {
    /**
        Delay in seconds before the sound starts playing, default is 0.
    **/
    var ?delay:Float;

    /**
        Sound gain between 0 and 1, default is 1.

        The final gain of the sound will be a combination of this gain, the group gain and the master gain.
    **/
    var ?gain:Float;

    /**
        The identifier of the sound, can be used to distinguish between consecutive plays from the same component.
    **/
    var ?play_id:SoundPlayId;
}

/**
    Data for the `SoundMessages.set_gain` message.
**/
typedef SoundMessageSetGain = {
    /**
        Sound gain between 0 and 1, default is 1.
    **/
    var ?gain:Float;
}

/**
    Data for the `SoundMessages.sound_done` message.
**/
typedef SoundMessageSoundDone = {
    /**
        The sequential play identifier that was given by the sound.play function.
    **/
    var ?play_id: SoundPlayId;
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
