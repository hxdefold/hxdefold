package defold;

import defold.types.BufferData;

/** *
 * Functions for creating image objects.
 **/
@:native("_G.image")
extern final class Image {
	/**	 *
	 * Load image (PNG or JPEG) from buffer.
	 *
	 * @param buffer image data buffer
	 * @param options an optional table containing parameters for loading the image.
	 * @return object with the following fields: width, height, type and buffer (raw data). nil is returned if loading fails.
	* */
	static function load(buffer:String, ?options:ImageLoadOptions):Null<ImageLoadResult>;

	/**	 *
	 * Load image (PNG or JPEG) from a string buffer.
	 *
	 * @param buffer image data buffer
	 * @param options an optional table containing parameters for loading the image.
	 * @return object with the following fields: width, height, type and buffer (raw data). nil is returned if loading fails.
	* */
	static function load_buffer(buffer:String, ?options:ImageLoadOptions):Null<ImageLoadResult>;
}

typedef ImageLoadOptions = {
	/** True if alpha should be premultiplied into the color components. Defaults to `false`. **/
	var ?premultiply_alpha:Bool;

	/** True if the image contents should be flipped vertically. Defaults to `false`. **/
	var ?flip_vertically:Bool;
}

/** *
 * Return type of the `Image.load` method.
 **/
typedef ImageLoadResult = {
	var width:Int;
	var height:Int;
	var type:ImageType;
	var buffer:BufferData;
}

/** *
 * Image type, used in `ImageLoadResult.type`.
* */
@:native("_G.image")
extern enum abstract ImageType(Int) {
	@:native('TYPE_RGB')
	var Rgb;
	@:native('TYPE_RGBA')
	var Rgba;
	@:native('TYPE_LUMINANCE')
	var Luminance;
	@:native('TYPE_LUMINANCE_ALPHA')
	var LuminanceAlpha;
}
