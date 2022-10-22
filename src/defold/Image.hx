package defold;

import defold.types.BufferData;

/**
    Functions for creating image objects.
**/
@:native("_G.image")
extern class Image {
    /**
        Load image (PNG or JPEG) from buffer.

        @param buffer image data buffer
        @param premult premultiply alpha. optional and defaults to false
        @return object with the following fields: width, height, type and buffer (raw data). nil is returned if loading fails.
    **/
    static function load(buffer:String, ?premult:Bool):Null<ImageLoadResult>;
}

/**
    Return type of the `Image.load` method.
**/
typedef ImageLoadResult = {
    var width:Int;
    var height:Int;
    var type:ImageType;
    var buffer:BufferData;
}

/**
    Image type, used in `ImageLoadResult.type`.
**/
@:native("_G.image")
@:enum extern abstract ImageType(Int) {
    var TYPE_LUMINANCE;
    var TYPE_RGB;
    var TYPE_RGBA;
}
