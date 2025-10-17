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
import defold.types.RenderTargetResourceReference;
import defold.types.TileSourceResourceReference;

/**
	Functions and constants to access resources.
**/
@:native("_G.resource")
extern final class Resource {
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
	static function material(?path:String):MaterialResourceReference;

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
	static function getTextureInfo(path:EitherType<HashOrString, TextureResourceHandle>):ResourceTextureInfo;

	/**
		Gets render target info from a render target resource path or a render target handle.

		@param path the path to the resource or a render target handle
		@return info about the render target and its attachments
	**/
	@:pure
	@:native('get_render_target_info')
	static function getRenderTargetInfo(path:EitherType<HashOrString, Int>):ResourceRenderTargetInfo;

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
			   Sets the buffer of a resource.

			   By default, setting the resource buffer will either copy the data from the incoming buffer object to the buffer stored in the destination resource,
			   or make a new buffer object if the sizes between the source buffer and the destination buffer stored in the resource differs. In some cases, e.g performance reasons,
			   it might be beneficial to just set the buffer object on the resource without copying or cloning.

			   To achieve this, set the transfer_ownership flag to true in the argument table.
			   Transferring ownership from a lua buffer to a resource with this function works exactly the same as resource.create_buffer: the destination resource
			   will take ownership of the buffer held by the lua reference, i.e the buffer will not automatically be removed when the lua reference to the buffer
			   is garbage collected. Note: When setting a buffer with transfer_ownership = true, the currently bound buffer in the resource will be destroyed.

		@param path The path to the resource
		@param buffer The resource buffer
		@param table options about how to set the buffer
	**/
	@:native('set_buffer')
	static function setBuffer(path:HashOrString, buffer:Buffer, table:ResourceSetBufferOptions):Void;

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
		Constructor-like function that loads the specified render target resource and returns a hash to its run-time version.
		Note: This function can only be called within @property().
	**/
	@:native('render_target')
	static function renderTarget(path:String):RenderTargetResourceReference;

	/**
		Constructor-like function with two purposes:

		- Load the specified resource as part of loading the script
		- Return a hash to the run-time version of the resource

		**Note:** This function can only be called within `@property()`.
	**/
	@:native('tile_source')
	static function tileSource(path:String):TileSourceResourceReference;

	/**
		Sets the atlas resource with the provided atlas data.
		This can be used to dynamically update an existing atlas resource with new data.

		@param path The path to the resource
		@param table A table containing info about the atlas
	**/
	@:native('set_atlas')
	static function setAtlas(path:HashOrString, table:ResourceAtlasInfo):Void;

	/**
		This function creates a new texture resource that can be used in the same way as any texture created during build time.
		The path to the new texture resource must have a '.texturec' extension, meaning "/path/my_texture" is not a valid path but "/path/my_texture.texturec" is.
		The path must also be unique, attempting to create a texture with the same name as an existing resource will raise an error.
		A reference to the resource will be held by the collection that created the resource and will automatically be released when that collection is destroyed.
		Note that releasing a resource essentially means decreasing the reference count of that resource, and not necessarily that it will be deleted.

		@param path The path to the resource
		@param table A table containing info about how to create the texture
		@return A texture resource handle
	**/
	@:native('create_texture')
	static function createTexture(path:String, table:ResourceCreateTextureInfo):TextureResourceHandle;

	/**
		This function creates a new texture resource that can be used in the same way as any texture created during build time.
		The path to the new texture resource must have a '.texturec' extension, meaning "/path/my_texture" is not a valid path but "/path/my_texture.texturec" is.
		The path must also be unique, attempting to create a texture with the same name as an existing resource will raise an error.
		A reference to the resource will be held by the collection that created the resource and will automatically be released when that collection is destroyed.
		Note that releasing a resource essentially means decreasing the reference count of that resource, and not necessarily that it will be deleted.

		@param path The path to the resource
		@param table A table containing info about how to create the texture
		@param callback Optional callback to be executed when the texture has been created
		@return A tuple containing the hash to the resource and the request ID
	**/
	@:multiReturn
	static inline function createTextureAsync(path:String, table:ResourceCreateTextureInfo,
			?callback:(CreateTextureRequestId, TextureResourceHandle) -> Void):CreateTextureAsyncResult {
		return createTextureAsync_(path, table, callback != null ? (self, request_id, resource) -> {
			untyped __lua__('_G._hxdefold_self_ = {0}', self);
			callback(request_id, resource);
			untyped __lua__('_G._hxdefold_self_ = nil');
		} : null);
	}

	@:native('create_texture_async') private static function createTextureAsync_(path:String, table:ResourceCreateTextureInfo,
		?callback:(Any, CreateTextureRequestId, TextureResourceHandle) -> Void):CreateTextureAsyncResult;
}

/**
 * The ID for a request to create a texture asynchronously.
 */
extern abstract CreateTextureRequestId(Int) {}

/**
	Texture info used by the `Resource.set_texture` method.
**/
typedef ResourceSetTextureInfo = {
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
typedef ResourceTextureInfo = {
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
	Render target info returned by the `Resource.get_render_target_info` method.
**/
typedef ResourceRenderTargetInfo = {
	/** The opaque handle to the render target resource */
	var handle:Int;

	/** A table of attachments */
	var attachments:LuaArray<ResourceRenderTargetAttachmentInfo>;
}

/**
	Render target attachment info used by the `Resource.get_render_target_info` method.
**/
typedef ResourceRenderTargetAttachmentInfo = {
	/** Width of the texture */
	var width:Int;

	/** Height of the texture */
	var height:Int;

	/** Depth of the texture (1 for 2D / 6 for cube map) */
	var depth:Int;

	/** Number of mipmaps of the texture */
	var mipmaps:Int;

	/** Texture type */
	var type:ResourceTextureType;

	/** The attachment buffer type */
	var buffer_type:ResourceRenderTargetBufferType;

	/** The hashed path to the attachment texture resource (only available for resource render targets) */
	var ?texture:Hash;

	/** The opaque handle to the attachment texture resource */
	var handle:TextureResourceHandle;
}

/**
	Render target attachment buffer types.
**/
@:native("_G.resource")
extern enum abstract ResourceRenderTargetBufferType({}) {
	@:native('BUFFER_TYPE_COLOR0') var Color0;
	@:native('BUFFER_TYPE_COLOR1') var Color1;
	@:native('BUFFER_TYPE_COLOR2') var Color2;
	@:native('BUFFER_TYPE_COLOR3') var Color3;
	@:native('BUFFER_TYPE_DEPTH') var Depth;
	@:native('BUFFER_TYPE_STENCIL') var Stencil;
}

/**
	Atlas info used by the `Resource.create_atlas` method.
**/
typedef ResourceAtlasInfo = {
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
typedef ResourceAtlasAnimationInfo = {
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
typedef ResourceAtlasGeometriesInfo = {
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
typedef ResourceGetTextMetricsOptions = {
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
typedef ResourceTextMetrics = {
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
	@:native('TEXTURE_TYPE_2D')
	var Type2D;

	/**
		Cube map texture type
	**/
	@:native('TEXTURE_TYPE_CUBE_MAP')
	var TypeCubeMap;

	/**
		2D Array texture type
	**/
	@:native('TEXTURE_TYPE_2D_ARRAY')
	var TypeArray2D;
}

/**
	Resource format used in `ResourceTextureInfo.format` field.

	Note that the device running your game might not support all of these features, and the constants will only be exposed if it does.

	On the Haxe side, use the `isAvailable()` method on the enum to check if a format is supported.
**/
@:native("_G.resource")
extern enum abstract ResourceTextureFormat(Null<Int>) {
	/**
		Luminance type texture format.
	**/
	@:native('TEXTURE_FORMAT_LUMINANCE')
	var Luminance;

	/**
		RGB type texture format.
	**/
	@:native('TEXTURE_FORMAT_RGB')
	var Rgb;

	/**
		RGBA type texture format.
	**/
	@:native('TEXTURE_FORMAT_RGBA')
	var Rgba;

	/**
		RGB_PVRTC_2BPPV1 type texture format
	**/
	@:native('TEXTURE_FORMAT_RGB_PVRTC_2BPPV1')
	var RgbPvrtc2BPPv1;

	/**
		RGB_PVRTC_4BPPV1 type texture format
	**/
	@:native('TEXTURE_FORMAT_RGB_PVRTC_4BPPV1')
	var RgbPvrtc4BPPv1;

	/**
		RGBA_PVRTC_2BPPV1 type texture format
	**/
	@:native('TEXTURE_FORMAT_RGBA_PVRTC_2BPPV1')
	var RgbaPvrtc2BPPv1;

	/**
		RGBA_PVRTC_4BPPV1 type texture format
	**/
	@:native('TEXTURE_FORMAT_RGBA_PVRTC_4BPPV1')
	var RgbaPvrtc4BPPv1;

	/**
		RGB_ETC1 type texture format
	**/
	@:native('TEXTURE_FORMAT_RGB_ETC1')
	var RgbEtc1;

	/**
		RGBA_ETC2 type texture format
	**/
	@:native('TEXTURE_FORMAT_RGBA_ETC2')
	var RgbEtc2;

	/**
		RGBA_ASTC_4x4 type texture format
	**/
	@:native('TEXTURE_FORMAT_RGBA_ASTC_4x4')
	var RgbaAstc4x4;

	/**
		RGB_BC1 type texture format
	**/
	@:native('TEXTURE_FORMAT_RGB_BC1')
	var RgbBc1;

	/**
		RGBA_BC3 type texture format
	**/
	@:native('TEXTURE_FORMAT_RGBA_BC3')
	var RgbaBc3;

	/**
		R_BC4 type texture format
	**/
	@:native('TEXTURE_FORMAT_R_BC4')
	var RBC4;

	/**
		RG_BC5 type texture format
	**/
	@:native('TEXTURE_FORMAT_RG_BC5')
	var RgBC5;

	/**
		RGBA_BC7 type texture format
	**/
	@:native('TEXTURE_FORMAT_RGBA_BC7')
	var RgbaBC7;

	/**
		RGB16F type texture format
	**/
	@:native('TEXTURE_FORMAT_RGB16F')
	var Rgb16f;

	/**
		RGB32F type texture format
	**/
	@:native('TEXTURE_FORMAT_RGB32F')
	var Rgb32f;

	/**
		RGBA16F type texture format
	**/
	@:native('TEXTURE_FORMAT_RGBA16F')
	var Rgba16f;

	/**
		RGBA32F type texture format
	**/
	@:native('TEXTURE_FORMAT_RGBA32F')
	var Rgba32f;

	/**
		R16F type texture format
	**/
	@:native('TEXTURE_FORMAT_R16F')
	var R16f;

	/**
		RG16F type texture format
	**/
	@:native('TEXTURE_FORMAT_RG16F')
	var Rg16f;

	/**
		R32F type texture format
	**/
	@:native('TEXTURE_FORMAT_R32F')
	var R32f;

	/**
		RG32F type texture format
	**/
	@:native('TEXTURE_FORMAT_RG32F')
	var Rg32f;

	/**
		Checks if the device running the game supports this format.

		@return `true` if the format is available on the device, otherwise `false`
	**/
	public inline function isAvailable():Bool {
		return this != null;
	}
}

@:native("_G.resource")
extern enum abstract ResourceTextureCompressionType({}) {
	/**
		No compression.
	**/
	@:native('COMPRESSION_TYPE_DEFAULT')
	var Default;

	/**
		Compression with BASIS_UASTC.
	**/
	@:native('COMPRESSION_TYPE_BASIS_UASTC')
	var BasisUastc;
}

/**
	Options used by the `Resource.create_buffer` method.
**/
typedef ResourceCreateBufferOptions = {
	/**
		the buffer to bind to this resource.
	**/
	var buffer:Buffer;

	/**
		Optional flag to determine wether or not the resource should take over ownership of the buffer object (default `true`)
	**/
	var ?transfer_ownership:Bool;
}

/**
	Options used by the `Resource.set_buffer` method.
**/
typedef ResourceSetBufferOptions = {
	/**
		Optional flag to determine wether or not the resource should take over ownership of the buffer object (default `false`)
	**/
	var ?transfer_ownership:Bool;
}

/**
	Texture info used by the `Resource.create_texture` and `Resource.create_texture_async` methods.
**/
typedef ResourceCreateTextureInfo = {
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
		Optional buffer containing pixel data, the format of the pixel data must match the specified format field
	**/
	var ?buffer:Buffer;

	/**
		Optional depth of the texture (required if type is TEXTURE_TYPE_CUBE_MAP (=6) or TEXTURE_TYPE_2D_ARRAY)
	**/
	var ?depth:Int;

	/**
		Optional flag to specify if mipmaps should be generated. Defaults to `false`
	**/
	var ?generate_mipmaps:Bool;

	/**
		Optional number of mipmaps to generate or present in the optional buffer
	**/
	var ?num_mipmaps:Int;
}

/**
 * Return values from createTextureAsync
 */
@:multiReturn
typedef CreateTextureAsyncResult = {
	var path:Hash;
	var request_id:CreateTextureRequestId;
}
