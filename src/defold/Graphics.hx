package defold;

/** *
 * Graphics functions and constants.
 * 
 * Note: Graphics-related constants are exposed here. Existing constants under
 * the render and resource modules may still be present but are deprecated in
 * favor of using this module.
 **/
@:native("_G.graphics")
extern final class Graphics {}

/** *
 * Texture formats and related graphics constants moved from render/resource.
 * These are exposed as enums to allow type-safe usage and availability checks
 * when the constant may be missing on some devices (null underlying value).
 **/
@:native("_G.graphics")
extern enum abstract GraphicsTextureFormat(Null<Int>) {
	@:native('TEXTURE_FORMAT_LUMINANCE') var Luminance;
	@:native('TEXTURE_FORMAT_RGB') var Rgb;
	@:native('TEXTURE_FORMAT_RGBA') var Rgba;
	@:native('TEXTURE_FORMAT_RGBA_ASTC_4X4') var RgbaAstc4x4;
	@:native('TEXTURE_FORMAT_RGB_BC1') var RgbBc1;
	@:native('TEXTURE_FORMAT_RGBA_BC3') var RgbaBc3;
	@:native('TEXTURE_FORMAT_R_BC4') var RBc4;
	@:native('TEXTURE_FORMAT_RG_BC5') var RgBc5;
	@:native('TEXTURE_FORMAT_RGBA_BC7') var RgbaBc7;
	@:native('TEXTURE_FORMAT_RGB16F') var Rgb16f;
	@:native('TEXTURE_FORMAT_RGB32F') var Rgb32f;
	@:native('TEXTURE_FORMAT_RGBA16F') var Rgba16f;
	@:native('TEXTURE_FORMAT_RGBA32F') var Rgba32f;
	@:native('TEXTURE_FORMAT_R16F') var R16f;
	@:native('TEXTURE_FORMAT_RG16F') var Rg16f;
	@:native('TEXTURE_FORMAT_R32F') var R32f;
	@:native('TEXTURE_FORMAT_RG32F') var Rg32f;
}

@:native("_G.graphics")
extern enum abstract GraphicsTextureType(Null<Int>) {
	@:native('TEXTURE_TYPE_2D') var Type2D;
	@:native('TEXTURE_TYPE_2D_ARRAY') var Type2DArray;
	@:native('TEXTURE_TYPE_3D') var Type3D;
	@:native('TEXTURE_TYPE_CUBE_MAP') var TypeCubeMap;
	@:native('TEXTURE_TYPE_IMAGE_2D') var TypeImage2D;
	@:native('TEXTURE_TYPE_IMAGE_3D') var TypeImage3D;
}

@:native("_G.graphics")
extern enum abstract GraphicsTextureWrap({}) {
	@:native('TEXTURE_WRAP_CLAMP_TO_BORDER') var ClampToBorder;
	@:native('TEXTURE_WRAP_CLAMP_TO_EDGE') var ClampToEdge;
	@:native('TEXTURE_WRAP_MIRRORED_REPEAT') var MirroredRepeat;
	@:native('TEXTURE_WRAP_REPEAT') var Repeat;
}

@:native("_G.graphics")
extern enum abstract GraphicsTextureFilter({}) {
	@:native('TEXTURE_FILTER_DEFAULT') var Default;
	@:native('TEXTURE_FILTER_LINEAR') var Linear;
	@:native('TEXTURE_FILTER_LINEAR_MIPMAP_LINEAR') var LinearMipmapLinear;
	@:native('TEXTURE_FILTER_LINEAR_MIPMAP_NEAREST') var LinearMipmapNearest;
	@:native('TEXTURE_FILTER_NEAREST') var Nearest;
	@:native('TEXTURE_FILTER_NEAREST_MIPMAP_LINEAR') var NearestMipmapLinear;
	@:native('TEXTURE_FILTER_NEAREST_MIPMAP_NEAREST') var NearestMipmapNearest;
}

@:native("_G.graphics")
extern enum abstract GraphicsCompareFunc({}) {
	@:native('COMPARE_FUNC_NEVER') var Never;
	@:native('COMPARE_FUNC_LESS') var Less;
	@:native('COMPARE_FUNC_LEQUAL') var LessEqual;
	@:native('COMPARE_FUNC_GREATER') var Greater;
	@:native('COMPARE_FUNC_GEQUAL') var GreaterEqual;
	@:native('COMPARE_FUNC_EQUAL') var Equal;
	@:native('COMPARE_FUNC_NOTEQUAL') var NotEqual;
	@:native('COMPARE_FUNC_ALWAYS') var Always;
}

@:native("_G.graphics")
extern enum abstract GraphicsStencilOp({}) {
	@:native('STENCIL_OP_KEEP') var Keep;
	@:native('STENCIL_OP_ZERO') var Zero;
	@:native('STENCIL_OP_REPLACE') var Replace;
	@:native('STENCIL_OP_INCR') var Incr;
	@:native('STENCIL_OP_INCR_WRAP') var IncrWrap;
	@:native('STENCIL_OP_DECR') var Decr;
	@:native('STENCIL_OP_DECR_WRAP') var DecrWrap;
	@:native('STENCIL_OP_INVERT') var Invert;
}

@:native("_G.graphics")
extern enum abstract GraphicsFaceType({}) {
	@:native('FACE_TYPE_FRONT') var Front;
	@:native('FACE_TYPE_BACK') var Back;
	@:native('FACE_TYPE_FRONT_AND_BACK') var FrontAndBack;
}

@:native("_G.graphics")
extern enum abstract GraphicsState({}) {
	@:native('STATE_DEPTH_TEST') var DepthTest;
	@:native('STATE_STENCIL_TEST') var StencilTest;
	@:native('STATE_BLEND') var Blend;
	@:native('STATE_ALPHA_TEST') var AlphaTest;
	@:native('STATE_CULL_FACE') var CullFace;
	@:native('STATE_POLYGON_OFFSET_FILL') var PolygonOffsetFill;
	@:native('STATE_SCISSOR_TEST') var ScissorTest;
}

@:native("_G.graphics")
extern enum abstract GraphicsBufferType({}) {
	@:native('BUFFER_TYPE_COLOR0_BIT') var Color0Bit;
	@:native('BUFFER_TYPE_COLOR1_BIT') var Color1Bit;
	@:native('BUFFER_TYPE_COLOR2_BIT') var Color2Bit;
	@:native('BUFFER_TYPE_COLOR3_BIT') var Color3Bit;
	@:native('BUFFER_TYPE_DEPTH_BIT') var DepthBit;
	@:native('BUFFER_TYPE_STENCIL_BIT') var StencilBit;
}

@:native("_G.graphics")
extern enum abstract GraphicsBlendFactor({}) {
	@:native('BLEND_FACTOR_ZERO') var Zero;
	@:native('BLEND_FACTOR_ONE') var One;
	@:native('BLEND_FACTOR_SRC_COLOR') var SrcColor;
	@:native('BLEND_FACTOR_ONE_MINUS_SRC_COLOR') var OneMinusSrcColor;
	@:native('BLEND_FACTOR_DST_COLOR') var DstColor;
	@:native('BLEND_FACTOR_ONE_MINUS_DST_COLOR') var OneMinusDstColor;
	@:native('BLEND_FACTOR_SRC_ALPHA') var SrcAlpha;
	@:native('BLEND_FACTOR_ONE_MINUS_SRC_ALPHA') var OneMinusSrcAlpha;
	@:native('BLEND_FACTOR_DST_ALPHA') var DstAlpha;
	@:native('BLEND_FACTOR_ONE_MINUS_DST_ALPHA') var OneMinusDstAlpha;
	@:native('BLEND_FACTOR_SRC_ALPHA_SATURATE') var SrcAlphaSaturate;
	@:native('BLEND_FACTOR_CONSTANT_COLOR') var ConstantColor;
	@:native('BLEND_FACTOR_ONE_MINUS_CONSTANT_COLOR') var OneMinusConstantColor;
	@:native('BLEND_FACTOR_CONSTANT_ALPHA') var ConstantAlpha;
	@:native('BLEND_FACTOR_ONE_MINUS_CONSTANT_ALPHA') var OneMinusConstantAlpha;
}
