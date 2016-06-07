package defold;

import defold.support.UrlOrString;
import defold.support.HashOrString;

@:native("_G.tilemap")
extern class Tilemap {
    inline static function get_bounds(url:UrlOrString):TilemapBounds {
        return untyped __lua__("{{ {0}.get_bounds({1}) }}", Tilemap, url);
    }
    static function get_tile(url:UrlOrString, name:HashOrString, x:Int, y:Int):Int;
    static function reset_constant(url:UrlOrString, name:HashOrString):Void;
    static function set_constant(url:UrlOrString, name:HashOrString, value:Vector4):Void;
    static function set_tile(url:UrlOrString, name:HashOrString, x:Int, y:Int, newTile:Int, ?h_flip:Bool, ?v_flip:Bool):Void;
}

abstract TilemapBounds(lua.Table<Int,Int>) {
    public var x(get,never):Int;
    public var y(get,never):Int;
    public var w(get,never):Int;
    public var h(get,never):Int;
    inline function get_x() return this[1];
    inline function get_y() return this[2];
    inline function get_w() return this[3];
    inline function get_h() return this[4];
}

class TilemapMessages {
    @:deprecated("Use defold.Tilemap.set_tile instead")
    static var SetTile(default,never) = new Message<TilemapMessageSetTile>("set_tile");
}

typedef TilemapMessageSetTile = {
    layer_id:Hash,
    position:Vector3,
    tile:Int,
    dx:Int,
    dy:Int,
}
