package defold;

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
extern class Resource {
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
        Return a reference to the Manifest that is currently loaded.

        @return reference to the Manifest that is currently loaded
    **/
    static function get_current_manifest():ResourceManifestReference;

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
    static function set_texture(path:HashOrString, table:ResourceTextureInfo, buffer:Buffer):Void;

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
    static function create_atlas(path:String, table:ResourceAtlasInfo):Hash;

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
    static function create_buffer(path:HashOrString, options:ResourceCreateBufferOptions):Buffer;

    /**
        Gets the buffer from a resource

        @param path The path to the resource
        @return The resource buffer
    **/
    static function get_buffer(path:HashOrString):Buffer;

    /**
        Sets the buffer of a resource

        @param path The path to the resource
        @param buffer The resource buffer
    **/
    static function set_buffer(path:HashOrString, buffer:Buffer):Void;

    /**
        Gets the text metrics from a font.

        @param url The font to get the (unscaled) metrics from
        @param text Text to measure
        @param options (optional) A table containing parameters for the text.
    **/
    static function get_text_metrics(url:Hash, text:String, ?options:ResourceGetTextMetricsOptions):ResourceTextMetrics;

    /**
        Create, verify, and store a manifest to device.

        Create a new manifest from a buffer. The created manifest is verified
        by ensuring that the manifest was signed using the bundled public/private
        key-pair during the bundle process and that the manifest supports the current
        running engine version. Once the manifest is verified it is stored on device.
        The next time the engine starts (or is rebooted) it will look for the stored
        manifest before loading resources. Storing a new manifest allows the
        developer to update the game, modify existing resources, or add new
        resources to the game through LiveUpdate.

        @param manifest_buffer the binary data that represents the manifest
        @param callback the callback function executed once the engine has attempted to store the manifest.
    **/
    static function store_manifest<T>(manifest_buffer:String, callback:(self:T, status:ResourceLiveUpdateStatus)->Void):Void;

    /**
        Stores a zip file and uses it for live update content. The path is renamed and stored in the (internal) live update location.

        @param path the path to the original file on disc
        @param callback the callback function executed after the storage has completed
        @param options optional table with extra parameters
    **/
    static function store_archive<T>(path:String, callback:(self:T, status:ResourceLiveUpdateStatus)->Void, ?options:ResourceStoreArchiveOptions):Void;

    /**
        Is any liveupdate data mounted and currently in use? This can be used to determine if a new manifest or zip file should be downloaded.

        @return true if a liveupdate archive (any format) has been loaded
    **/
    static function is_using_liveupdate_data():Bool;

    /**
        Add a resource to the data archive and runtime index.

        The resource will be verified internally before being added to the data archive.

        @param manifest_reference The manifest to check against.
        @param data The resource data that should be stored.
        @param hexdigest The expected hash for the resource, retrieved through collectionproxy.missing_resources.
        @param callback  The callback function that is executed once the engine has been attempted to store
        the resource. Arguments:
         * `self` The current object.
         * `hexdigest` The hexdigest of the resource.
         * `status` Whether or not the resource was successfully stored.
    **/
    static function store_resource<T>(manifest_reference:ResourceManifestReference, data:String, hexdigest:String, callback:T->String->Bool->Void):Void;

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
    static function tile_source(path:String):TileSourceResourceReference;
}

/**
    Resource manifest reference used by the `Resource` module.
**/
typedef ResourceManifestReference = Int;

/**
    Texture info used by the `Resource.set_texture` method.
**/
typedef ResourceTextureInfo = {
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
extern enum abstract ResourceTextureType(Int) {
    /**
        2D texture type.
    **/
    var TEXTURE_TYPE_2D;
}

/**
    Resource format used in `ResourceTextureInfo.format` field.
**/
@:native("_G.resource")
extern enum abstract ResourceTextureFormat(Int) {
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
}

@:native("_G.resource")
extern enum abstract ResourceLiveUpdateStatus({}) {
    /**
        Mismatch between between expected bundled resources and actual bundled resources.
        The manifest expects a resource to be in the bundle, but it was not found in the bundle.
        This is typically the case when a non-excluded resource was modified between publishing the bundle and publishing the manifest.
    **/
    var LIVEUPDATE_BUNDLED_RESOURCE_MISMATCH;

    /**
        Mismatch between running engine version and engine versions supported by manifest.
    **/
    var LIVEUPDATE_ENGINE_VERSION_MISMATCH;

    /**
        Failed to parse manifest data buffer. The manifest was probably produced by a different engine version.
    **/
    var LIVEUPDATE_FORMAT_ERROR;

    /**
        The handled resource is invalid.
    **/
    var LIVEUPDATE_INVALID_RESOURCE;

    var LIVEUPDATE_OK;

    /**
        Mismatch between scheme used to load resources.
        Resources are loaded with a different scheme than from manifest, for example over HTTP or directly from file.
        This is typically the case when running the game directly from the editor instead of from a bundle.
    **/
    var LIVEUPDATE_SCHEME_MISMATCH;

    /**
        Mismatch between manifest expected signature and actual signature.
    **/
    var LIVEUPDATE_SIGNATURE_MISMATCH;

    /**
        Mismatch between manifest expected version and actual version.
    **/
    var LIVEUPDATE_VERSION_MISMATCH;
}

@:native("_G.resource")
extern enum abstract ResourceTextureCompressionType({}) {
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
    Options used by the `Resource.store_archive` method.
**/
typedef ResourceStoreArchiveOptions =
{
    /**
        If archive should be verified as well as stored (defaults to `true`).
    **/
    var ?verify:Bool;
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
