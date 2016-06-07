package defold;

import defold.support.HashOrString;

@:native("_G.sound")
extern class Sound {
    static function get_group_gain(group:HashOrString):Float;
    static function get_group_name(group:HashOrString):String;
    static function get_groups():lua.Table<Int,Hash>;
    inline static function get_peak(group:HashOrString, window:Float):SoundLeftRight<Float> {
        return untyped __lua__("{{ {0}.get_peak({1}, {2}) }}", Sound, group, window);
    }
    inline static function get_rms(group:HashOrString, window:Float):SoundLeftRight<Float> {
        return untyped __lua__("{{ {0}.get_rms({1}, {2}) }}", Sound, group, window);
    }
    static function is_music_playing():Bool;
    static function set_group_gain(group:HashOrString, gain:Float):Bool;
}

abstract SoundLeftRight<T>(lua.Table<Int,T>) {
    public var left(get,never):T;
    public var right(get,never):T;
    inline function get_left() return this[1];
    inline function get_right() return this[2];
}

class SoundMessages {
    static var PlaySound(default,never) = new Message<{?delay:Float, ?gain:Float}>("play_sound");
    static var SetGain(default,never) = new Message<{?gain:Float}>("set_gain");
    static var StopSound(default,never) = new Message<Void>("stop_sound");
}
