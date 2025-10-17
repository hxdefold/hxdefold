package defold;

import defold.types.*;

/**
	Functions and messages used to manipulate tile map components.
**/
@:native("_G.tilemap")
extern final class Tilemap {
	/**
		Get the bounds for a tile map. This function returns multiple values:
		The lower left corner index x and y coordinates (1-indexed),
		the tile map width and the tile map height.

		The resulting values take all tile map layers into account, meaning that
		the bounds are calculated as if all layers were collapsed into one.

		@param url the tile map
	**/
	@:pure
	@:native('get_bounds')
	static function getBounds(url:HashOrStringOrUrl):TilemapBounds;

	/**
		Get the tile set at the specified position in the tilemap.
		The position is identified by the tile index starting at origo
		with index 1, 1. (see `Tilemap.set_tile`)
		Which tile map and layer to query is identified by the URL and the
		layer name parameters.

		@param url the tile map
		@param layer of the layer
		@param x x coordinate of the tile
		@param y y coordinate of the tile
		@return index of the tile
	**/
	@:pure
	@:native('get_tile')
	static function getTile(url:HashOrStringOrUrl, layer:HashOrString, x:Int, y:Int):Int;

	/**
		Get full tile info at the specified layer and coordinates.

		@param url the tile map
		@param layer of the layer
		@param x x coordinate of the tile
		@param y y coordinate of the tile
		@return Tile information (index and flags)
	**/
	@:pure
	@:native('get_tile_info')
	static function getTileInfo(url:HashOrStringOrUrl, layer:HashOrString, x:Int, y:Int):TilemapTileInfo;

	/**
		Get all tile indices for a layer as a table of rows.

		@param url the tile map
		@param layer of the layer
		@return table of rows with tile indexes
	**/
	@:pure
	@:native('get_tiles')
	static function getTiles(url:HashOrStringOrUrl, layer:HashOrString):lua.Table<Int, lua.Table<Int, Int>>;

	/**
		Reset a shader constant for a tile map.

		The constant must be defined in the material assigned to the tile map.
		Resetting a constant through this function implies that the value defined in the material will be used.
		Which tile map to reset a constant for is identified by the URL.

		@param url the tile map that should have a constant reset
		@param name of the constant
	**/
	@:native('reset_constant')
	static function resetConstant(url:HashOrStringOrUrl, name:HashOrString):Void;

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
	@:native('set_constant')
	static function setConstant(url:HashOrStringOrUrl, name:HashOrString, value:Vector4):Void;

	/**
		Set a tile in a tile map.

		Replace a tile in a tile map with a new tile.
		The coordinates of the tiles are indexed so that the "first" tile just
		above and to the right of origo has coordinates 1,1.
		Tiles to the left of and below origo are indexed 0, -1, -2 and so forth.

		+-------+-------+------+------+
		|  0,3  |  1,3  | 2,3  | 3,3  |
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
		@param layer name of the layer
		@param x x-coordinate of the tile
		@param y y-coordinate of the tile
		@param tile index of new tile to set. 0 resets the cell
		@param hFlipped if the tile should be horizontally flipped
		@param vFlipped if the tile should be vertically flipped
	**/
	@:native('set_tile')
	static function setTile(url:HashOrStringOrUrl, layer:HashOrString, x:Int, y:Int, tile:Int, ?hFlipped:Bool, ?vFlipped:Bool):Void;

	/**
		Sets the visibility of the tilemap layer.

		@param url the tile map
		@param layer name of the layer
		@param visible should the layer be visible
	**/
	@:native('set_visible')
	static function setVisible(url:HashOrStringOrUrl, layer:HashOrString, visible:Bool):Void;
}

/**
	Return value of `Tilemap.get_bounds` method.
**/
@:multiReturn extern final class TilemapBounds {
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

/**
	Tile info returned by `Tilemap.get_tile_info`.
**/
typedef TilemapTileInfo = {
	var index:Int;
	var h_flip:Bool;
	var v_flip:Bool;
	var rotate_90:Bool;
}
