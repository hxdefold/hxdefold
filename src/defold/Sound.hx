package defold;

import defold.support.HashOrString;

@:native("_G.sound")
extern class Sound {
    static function get_group_gain(group:HashOrString):Float;
    static function get_group_name(group:HashOrString):String;
    static function get_groups():lua.Table<Int,String>;
    static function get_peak(group:HashOrString, window:Float):Dynamic; // TODO: multi-return...
    static function get_rms(group:HashOrString, window:Float):Dynamic; // TODO: multi-return...
    static function is_music_playing():Bool;
    static function set_group_gain(group:HashOrString, gain:Float):Bool;
}
