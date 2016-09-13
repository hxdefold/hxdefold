package defold;

import defold.types.*;

/**
    Functions for controlling tilemap components.

    See `TilemapMessages` for tilemap component messages.
**/
@:native("_G.tilemap")
extern class Tilemap {
    /**
        Get the tile set at the specified position in the tilemap.

        The returned tile to set is identified by its index starting with 1 in the top left corner of the tile set.
        The coordinates of the tile is 1-indexed (see `Tilemap.set_tile`).
    **/
    static function get_bounds(url:UrlOrString):TilemapBounds;

    /**
        Get a tile from a tile map.

        Get the tile set at the specified position in the tilemap.
        The position is identified by the tile index starting at origo with index 1, 1. (see `Tilemap.set_tile`).
    **/
    static function get_tile(url:UrlOrString, name:HashOrString, x:Int, y:Int):Int;

    /**
        Reset a shader constant for a tile map.

        The constant must be defined in the material assigned to the tile map.
        Resetting a constant through this function implies that the value defined in the material will be used.
    **/
    static function reset_constant(url:UrlOrString, name:HashOrString):Void;

    /**
        Set a shader constant for a tile map.

        The constant must be defined in the material assigned to the tile map.
        Setting a constant through this function will override the value set for that constant in the material.
        The value will be overridden until `Tilemap.reset_constant` is called.
    **/
    static function set_constant(url:UrlOrString, name:HashOrString, value:Vector4):Void;

    /**
        Set a tile in a tile map.

        Replace a tile in a tile map with a new tile.

        The coordinates of the tiles are indexed so that the "first" tile just above and to the right of origo has coordinates 1,1.
        Tiles to the left of and below origo are indexed 0, -1, -2 and so forth.

        The coordinates must be within the bounds of the tile map as it were created. That is, it is not possible to
        extend the size of a tile map by setting tiles outside the edges.

        To clear a tile, set the tile to number 0.
    **/
    static function set_tile(url:UrlOrString, name:HashOrString, x:Int, y:Int, newTile:Int, ?h_flip:Bool, ?v_flip:Bool):Void;
}

/**
    Messages for the tilemap components.
**/
@:publicFields
class TilemapMessages {
    /**
        Changes a tile in a tile map.

        Send this message to a tile map component to change the tile in one of its cells.

        DEPRECATED! Use `Tilemap.set_tile` instead.
    **/
    @:deprecated("Use Tilemap.set_tile instead")
    static var SetTile(default,never) = new Message<TilemapMessageSetTile>("set_tile");
}

/**
    Return value of `Tilemap.get_bounds` method.
**/
@:multiReturn extern class TilemapBounds {
    var x:Int;
    var y:Int;
    var w:Int;
    var h:Int;
}

/**
    Data for the `TilemapMessages.SetTile` message.

    DEPRECATED! Use `Tilemap.set_tile` instead.
**/
@:deprecated("Use Tilemap.set_tile instead")
typedef TilemapMessageSetTile = {
    /**
        Id of the layer for which to change a tile
    **/
    var layer_id:Hash;

    /**
        The position of the cell for which to change the tile (world space).
    **/
    var position:Vector3;

    /**
        Index of the tile to change to in the tile set, 1 for the first tile and 0 to clear the tile (0 by default).
    **/
    @:optional var tile:Int;

    /**
        Horizontal offset from the supplied position to the requested cell (grid space, 0 by default).
    **/
    @:optional var dx:Int;

    /**
        Vertical offset from the supplied position to the requested cell (grid space, 0 by default).
    **/
    @:optional var dy:Int;
}
