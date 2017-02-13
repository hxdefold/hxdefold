package defold;

import defold.types.*;

/**
    Functions and messages used to manipulate tile map components.
**/
@:native("_G.tilemap")
extern class Tilemap {
    /**
        Get the bounds for a tile map. This function returns multiple values:
        The lower left corner index x and y coordinates (1-indexed),
        the tile map width and the tile map height.

        The resulting values take all tile map layers into account, meaning that
        the bounds are calculated as if all layers were collapsed into one.

        @param url the tile map
    **/
    static function get_bounds(url:HashOrStringOrUrl):TilemapBounds;

    /**
        Get the tile set at the specified position in the tilemap.
        The position is identified by the tile index starting at origo
        with index 1, 1. (see `Tilemap.set_tile`)
        Which tile map and layer to query is identified by the URL and the
        layer name parameters.

        @param url the tile map
        @param name of the layer
        @param x x coordinate of the tile
        @param y y coordinate of the tile
        @return index of the tile
    **/
    static function get_tile(url:HashOrStringOrUrl, name:HashOrString, x:Int, y:Int):Int;

    /**
        Reset a shader constant for a tile map.

        The constant must be defined in the material assigned to the tile map.
        Resetting a constant through this function implies that the value defined in the material will be used.
        Which tile map to reset a constant for is identified by the URL.

        @param url the tile map that should have a constant reset
        @param name of the constant
    **/
    static function reset_constant(url:HashOrStringOrUrl, name:HashOrString):Void;

    /**
        Set a shader constant for a tile map.

        The constant must be defined in the material assigned to the tile map.
        Setting a constant through this function will override the value set for that constant in the material.
        The value will be overridden until tilemap.reset_constant is called.
        Which tile map to set a constant for is identified by the URL.

        @param url the tile map that should have a constant set
        @param name of the constant
        @param value of the constant
    **/
    static function set_constant(url:HashOrStringOrUrl, name:HashOrString, value:Vector4):Void;

    /**
        Set a tile in a tile map.

        Replace a tile in a tile map with a new tile.
        The coordinates of the tiles are indexed so that the "first" tile just
        above and to the right of origo has coordinates 1,1.
        Tiles to the left of and below origo are indexed 0, -1, -2 and so forth.

        +-------+-------+------+------+
        |  0,3  |  1,3  | 1,2  | 3,3  |
        +-------+-------+------+------+
        |  0,2  |  1,2  | 2,2  | 3,2  |
        +-------+-------+------+------+
        |  0,1  |  1,1  | 2,1  | 3,1  |
        +-------O-------+------+------+
        |  0,0  |  1,0  | 2,0  | 3,0  |
        +-------+-------+------+------+

        The coordinates must be within the bounds of the tile map as it were created. That is, it is not
        possible to extend the size of a tile map by setting tiles outside the edges.
        To clear a tile, set the tile to number 0. Which tile map and layer to manipulate is identified by
        the URL and the layer name parameters.

        @param url the tile map
        @param name name of the layer
        @param x x coordinate of the tile
        @param y y coordinate of the tile
        @param new_tile tile to set
        @param h_flip if the tile should be horizontally flipped
        @param v_flip if the tile should be vertically flipped
    **/
    static function set_tile(url:HashOrStringOrUrl, name:HashOrString, x:Int, y:Int, new_tile:Int, ?h_flip:Bool, ?v_flip:Bool):Void;
}

/**
    Return value of `Tilemap.get_bounds` method.
**/
@:multiReturn extern class TilemapBounds {
    /**
        x coordinate of the bottom left corner
    **/
    var x:Int;

    /**
        y coordinate of the bottom left corner
    **/
    var y:Int;

    /**
        number of columns in the tile map
    **/
    var w:Int;

    /**
        number of rows in the tile map
    **/
    var h:Int;
}
