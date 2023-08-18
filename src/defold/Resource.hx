package defold;

import defold.types.TextureResourceHandle;
import haxe.extern.EitherType;
import defold.Go.GoPlayback;
import defold.types.Hash;
import defold.types.Buffer;
import defold.types.HashOrString;
import defold.types.AtlasResourceReference;
import defold.types.FontResourceReference;
import defold.types.MaterialResourceReference;
import defold.types.TextureResourceReference;
import defold.types.TileSourceResourceReference;

/**
    Functions and constants to access resources.
**/
@:native("_G.resource")
extern final class Resource
{
    /**
        Constructor-like function with two purposes:

        - Load the specified resource as part of loading the script
        - Return a hash to the run-time version of the resource

        **Note:** This function can only be called within `@property()`.
    **/
    static function atlas(path:String):AtlasResourceReference;

    /**
        Constructor-like function with two purposes:

        - Load the specified resource as part of loading the script
        - Return a hash to the run-time version of the resource

        **Note:** This function can only be called within `@property()`.
    **/
    static function font(path:String):FontResourceReference;

    /**
        Loads the resource data for a specific resource.

        @param path The path to the resource
        @return the buffer stored on disc
    **/
    static function load(path:String):Buffer;

    /**
        Constructor-like function with two purposes:

        - Load the specified resource as part of loading the script
        - Return a hash to the run-time version of the resource

        **Note:** This function can only be called within `@property()`.
    **/
    static function material():MaterialResourceReference;

    /**
        Sets the resource data for a specific resource

        @param path The path to the resource
        @param The buffer of precreated data, suitable for the intended resource type
    **/
    static function set(path:HashOrString, buffer:Buffer):Void;

    /**
        Sets the pixel data for a specific texture.

        @param path The path to the resource
        @param table A table containing info about the texture
        @param buffer The buffer of precreated pixel data

        *NOTE* Currently, only 1 mipmap is generated.
    **/
    @:native('set_texture')
    static function setTexture(path:HashOrString, table:ResourceSetTextureInfo, buffer:Buffer):Void;

    /**
     * Gets texture info from a texture resource path or a texture handle.
     *
     * @param path the path to the resource or a texture handle
     * @return info about the texture
    **/
    @:pure
    @:native('get_texture_info')
    static function getTextureInfo(path:EitherType<HashOrString,TextureResourceHandle>):ResourceTextureInfo;

    /**
        This function creates a new atlas resource that can be used in the same way as any atlas created during build time.
        The path used for creating the atlas must be unique, trying to create a resource at a path that is already registered will trigger an error.
        If the intention is to instead modify an existing atlas, use the resource.set_atlas function.
        Also note that the path to the new atlas resource must have a '.texturesetc' extension, meaning "/path/my_atlas" is not a valid path but "/path/my_atlas.texturesetc" is.
        When creating the atlas, at least one geometry and one animation is required, and an error will be raised if these requirements are not met.
        A reference to the resource will be held by the collection that created the resource and will automatically be released when that collection is destroyed.
        Note that releasing a resource essentially means decreasing the reference count of that resource, and not necessarily that it will be deleted.

        @param path The path to the resource
        @param table A table containing info about how to create the texture
        @return Returns the atlas resource path
    **/
    @:native('create_atlas')
    static function createAtlas(path:String, table:ResourceAtlasInfo):Hash;

    /**
        This function creates a new buffer resource that can be used in the same way as any buffer created during build time.
        The function requires a valid buffer created from either buffer.create or another pre-existing buffer resource.
        By default, the new resource will take ownership of the buffer lua reference, meaning the buffer will not automatically be removed when the lua reference to the buffer is garbage collected.
        This behaviour can be overruled by specifying `transfer_ownership = false` in the argument table.
        If the new buffer resource is created from a buffer object that is created by another resource, the buffer object will be copied and the new resource
        will effectively own a copy of the buffer instead. Note that the path to the new resource must have the `.bufferc` extension,
        `/path/my_buffer` is not a valid path but `/path/my_buffer.bufferc` is.
        The path must also be unique, attempting to create a buffer with the same name as an existing resource will raise an error.

        @param path The path to the resource
        @param options A table containing info about how to create the buffer
        @return The resource buffer
    **/
    @:native('create_buffer')
    static function createBuffer(path:HashOrString, options:ResourceCreateBufferOptions):Buffer;

    /**
        Gets the buffer from a resource

        @param path The path to the resource
        @return The resource buffer
    **/
    @:pure
    @:native('get_buffer')
    static function getBuffer(path:HashOrString):Buffer;

    /**
        Sets the buffer of a resource

        @param path The path to the resource
        @param buffer The resource buffer
    **/
    @:native('set_buffer')
    static function setBuffer(path:HashOrString, buffer:Buffer):Void;

    /**
        Gets the text metrics from a font.

        @param url The font to get the (unscaled) metrics from
        @param text Text to measure
        @param options (optional) A table containing parameters for the text.
    **/
    @:pure
    @:native('get_text_metrics')
    static function getTextMetrics(url:Hash, text:String, ?options:ResourceGetTextMetricsOptions):ResourceTextMetrics;

    /**
        Constructor-like function with two purposes:

        - Load the specified resource as part of loading the script
        - Return a hash to the run-time version of the resource

        **Note:** This function can only be called within `@property()`.
    **/
    static function texture(path:String):TextureResourceReference;

    /**
        Constructor-like function with two purposes:

        - Load the specified resource as part of loading the script
        - Return a hash to the run-time version of the resource

        **Note:** This function can only be called within `@property()`.
    **/
    @:native('tile_source')
    static function tileSource(path:String):TileSourceResourceReference;
}

/**
    Texture info used by the `Resource.set_texture` method.
**/
typedef ResourceSetTextureInfo =
{
    /**
        The texture type
    **/
    var type:ResourceTextureType;

    /**
        The width of the texture (in pixels)
    **/
    var width:Int;

    /**
        The height of the texture (in pixels)
    **/
    var height:Int;

    /**
        The texture format
    **/
    var format:ResourceTextureFormat;

    /**
        Optional x offset of the texture (in pixels)
    **/
    var ?x:Int;

    /**
        Optional y offset of the texture (in pixels)
    **/
    var ?y:Int;

    /**
        Optional mipmap to upload the data to
    **/
    var ?mipmap:Int;

    /**
        Specify the compression type for the data in the buffer object that holds the texture data. Defaults to `COMPRESSION_TYPE_DEFAULT`, i.e no compression.
    **/
    var ?compression_type:ResourceTextureCompressionType;
}

/**
    Texture info returned by the `Resource.get_texture_info` method.
**/
typedef ResourceTextureInfo =
{
    /**
        The opaque handle to the texture resource
    **/
    var handle:TextureResourceHandle;

    /**
        Width of the texture
    **/
    var width:Int;

    /**
        Height of the texture
    **/
    var height:Int;

    /**
        Depth of the texture (i.e 1 for a 2D texture and 6 for a cube map)
    **/
    var depth:Int;

    /**
        Number of mipmaps of the texture
    **/
    var mipmaps:Int;

    /**
        The texture type. Supported values:
    **/
    var type:ResourceTextureType;
}

/**
    Atlas info used by the `Resource.create_atlas` method.
**/
typedef ResourceAtlasInfo =
{
    /**
        The path to the texture resource, e.g "/main/my_texture.texturec"
    **/
    var texture:HashOrString;

    /**
        A list of the animations in the atlas.
    **/
    var animations:Array<ResourceAtlasAnimationInfo>;

    /**
        A list of the geometries that should map to the texture data.
    **/
    var geometries:Array<ResourceAtlasGeometriesInfo>;
}

/**
    Atlas animation info used by the `Resource.create_atlas` method.
**/
typedef ResourceAtlasAnimationInfo =
{
    /**
        The id of the animation, used in e.g `Sprite.play_animation`.
    **/
    var id:String;

    /**
        The width of the animation.
    **/
    var width:Int;

    /**
        The height of the animation.
    **/
    var height:Int;

    /**
        Index to the first geometry of the animation. Indices are lua based and must be in the range of 1 .. in atlas.
    **/
    var frame_start:Int;

    /**
        Index to the last geometry of the animation. Indices are lua based and must be in the range of 1 .. in atlas.
    **/
    var frame_end:Int;

    /**
        Playback mode of the animation, the default value is `PLAYBACK_ONCE_FORWARD`.
    **/
    var ?playback:GoPlayback;

    /**
        FPS of the animation, the default value is `30`.
    **/
    var ?fps:Int;

    /**
        Flip the animation vertically, the default value is `false`.
    **/
    var ?flip_vertical:Bool;

    /**
        Flip the animation horizontally, the default value is `false`.
    **/
    var ?flip_horizontal:Bool;
}

/**
    Atlas geometries used by the `Resource.create_atlas` method.
**/
typedef ResourceAtlasGeometriesInfo =
{
    /**
        A list of the vertices in texture space of the geometry in the form {px0, py0, px1, py1, ..., pxn, pyn}.
    **/
    var vertices:Array<Int>;

    /**
        A list of the uv coordinates in texture space of the geometry in the form of {u0, v0, u1, v1, ..., un, vn}
    **/
    var uvs:Array<Int>;

    /**
        A list of the indices of the geometry in the form {i0, i1, i2, ..., in}. Each tripe in the list represents a triangle.
    **/
    var indices:Array<Int>;
}

/**
    Options used by the `Resource.get_text_metrics` method.
**/
typedef ResourceGetTextMetricsOptions =
{
    /**
        The width of the text field. Not used if `line_break` is false.
    **/
    var ?width:Int;

    /**
        The leading (default `1.0`)
    **/
    var ?leading:Float;

    /**
        The tracking (default `1.0`)
    **/
    var ?tracking:Float;

    /**
        If the calculation should consider line breaks (default `false`).
    **/
    var ?line_break:Bool;
}

/**
    Text metrics returned by the `Resource.get_text_metrics` method.
**/
typedef ResourceTextMetrics =
{
    /**
        The width of the text.
    **/
    var width:Float;

    /**
        The height of the text.
    **/
    var height:Float;

    var max_ascent:Float;
    var max_descent:Float;
}

/**
    Resource type used in `ResourceTextureInfo.type` field.
**/
@:native("_G.resource")
extern enum abstract ResourceTextureType(Int)
{
    /**
        2D texture type.
    **/
    var TEXTURE_TYPE_2D;

    /**
        Cube map texture type
    **/
    var TEXTURE_TYPE_CUBE_MAP;

    /**
        2D Array texture type
    **/
    var TEXTURE_TYPE_2D_ARRAY;
}

/**
    Resource format used in `ResourceTextureInfo.format` field.

    Note that the device running your game might not support all of these features, and the constants will only be exposed if it does.

    On the Haxe side, use the `isAvailable()` method on the enum to check if a format is supported.
**/
@:native("_G.resource")
extern enum abstract ResourceTextureFormat(Null<Int>)
{
    /**
        Luminance type texture format.
    **/
    var TEXTURE_FORMAT_LUMINANCE;

    /**
        RGB type texture format.
    **/
    var TEXTURE_FORMAT_RGB;

    /**
        RGBA type texture format.
    **/
    var TEXTURE_FORMAT_RGBA;

    /**
        RGB_PVRTC_2BPPV1 type texture format
    **/
    var TEXTURE_FORMAT_RGB_PVRTC_2BPPV1;

    /**
        RGB_PVRTC_4BPPV1 type texture format
    **/
    var TEXTURE_FORMAT_RGB_PVRTC_4BPPV1;

    /**
        RGBA_PVRTC_2BPPV1 type texture format
    **/
    var TEXTURE_FORMAT_RGBA_PVRTC_2BPPV1;

    /**
        RGBA_PVRTC_4BPPV1 type texture format
    **/
    var TEXTURE_FORMAT_RGBA_PVRTC_4BPPV1;

    /**
        RGB_ETC1 type texture format
    **/
    var TEXTURE_FORMAT_RGB_ETC1;

    /**
        RGBA_ETC2 type texture format
    **/
    var TEXTURE_FORMAT_RGBA_ETC2;

    /**
        RGBA_ASTC_4x4 type texture format
    **/
    var TEXTURE_FORMAT_RGBA_ASTC_4x4;

    /**
        RGB_BC1 type texture format
    **/
    var TEXTURE_FORMAT_RGB_BC1;

    /**
        RGBA_BC3 type texture format
    **/
    var TEXTURE_FORMAT_RGBA_BC3;

    /**
        R_BC4 type texture format
    **/
    var TEXTURE_FORMAT_R_BC4;

    /**
        RG_BC5 type texture format
    **/
    var TEXTURE_FORMAT_RG_BC5;

    /**
        RGBA_BC7 type texture format
    **/
    var TEXTURE_FORMAT_RGBA_BC7;

    /**
        RGB16F type texture format
    **/
    var TEXTURE_FORMAT_RGB16F;

    /**
        RGB32F type texture format
    **/
    var TEXTURE_FORMAT_RGB32F;

    /**
        RGBA16F type texture format
    **/
    var TEXTURE_FORMAT_RGBA16F;

    /**
        RGBA32F type texture format
    **/
    var TEXTURE_FORMAT_RGBA32F;

    /**
        R16F type texture format
    **/
    var TEXTURE_FORMAT_R16F;

    /**
        RG16F type texture format
    **/
    var TEXTURE_FORMAT_RG16F;

    /**
        R32F type texture format
    **/
    var TEXTURE_FORMAT_R32F;

    /**
        RG32F type texture format
    **/
    var TEXTURE_FORMAT_RG32F;

    /**
        Checks if the device running the game supports this format.

        @return `true` if the format is available on the device, otherwise `false`
    **/
    public inline function isAvailable():Bool
    {
        return this != null;
    }
}

@:native("_G.resource")
extern enum abstract ResourceTextureCompressionType({})
{
    /**
        No compression.
    **/
    var COMPRESSION_TYPE_DEFAULT;

    /**
        Compression with basic UASTC.
    **/
    var COMPRESSION_TYPE_BASIS_UASTC;
}

/**
    Options used by the `Resource.create_buffer` method.
**/
typedef ResourceCreateBufferOptions =
{
    /**
        the buffer to bind to this resource.
    **/
    var buffer:Buffer;

    /**
        Optional flag to determine wether or not the resource should take over ownership of the buffer object (default `true`)
    **/
    var ?transfer_ownership:Bool;
}
