package defold;

import haxe.extern.EitherType;
import defold.types.*;
import defold.types.util.LuaArray;

/**
    Rendering functions, messages and constants. The "render" namespace is
    accessible only from render scripts.

    See `RenderMessages` for related messages.
**/
@:native("_G.render")
extern final class Render
{
    /**
        Clears the active render target.

        Clear buffers in the currently enabled render target with specified value.

        @param buffers Table with keys specifying which buffers to clear and values set to clear values.
    **/
    static function clear(buffers:RenderClearBuffers):Void;

    /**
        Create a new constant buffer..

        Constant buffers are used to set shader program variables and are optionally passed to the `Render.draw`
        function. The buffer's constant elements can be indexed like an ordinary Lua table, but you can't iterate
        over them with pairs() or ipairs().

        @return new constant buffer
    **/
    @:native('constant_buffer')
    static function constantBuffer():RenderConstantBuffer;

    /**
        Deletes a render target.

        @param renderTarget render target to delete
    **/
    @:native('delete_render_target')
    static function deleteRenderTarget(renderTarget:RenderTarget):Void;

    /**
        Disables the currently enabled material.

        If a material is currently enabled, disable it.
    **/
    @:native('disable_material')
    static function disableMaterial():Void;

    /**
        Disables a render state.

        @param state state to enable
    **/
    @:native('disable_state')
    static function disableState(state:RenderState):Void;

    /**
        Disables a texture for a render target.

        @param unit texture unit to enable disable for
    **/
    @:native('disable_texture')
    static function disableTexture(unit:Int):Void;

    /**
        Draws all objects matching a predicate.

        Draws all objects that match a specified predicate. An optional constant buffer can be
        provided to override the default constants. If no constants buffer is provided, a default
        system constants buffer is used containing constants as defined in materials and set through
        `*.set_constant()` and `*.reset_constant()` on visual components.

        @param predicate predicate to draw for
        @param options optional table with properties
    **/
    static function draw(predicate:RenderPredicate, ?options:RenderDrawOptions):Void;

    /**
        Draws all 2d debug graphics (Deprecated).
    **/
    @:deprecated("Use `Render.draw_debug3d` to draw visual debug info.")
    @:native('draw_debug2d')
    static function drawDebug2d():Void;

    /**
        Draws all 3d debug graphics such as lines drawn with "draw_line" messages and physics visualization.
    **/
    @:native('draw_debug3d')
    static function drawDebug3d():Void;

    /**
        Enables a material.

        If another material was already enabled, it will be automatically disabled.

        @param materialId material id to enable
    **/
    @:native('enable_material')
    static function enableMaterial(materialId:HashOrString):Void;

    /**
        Enables a render state.

        @param state state to enable
    **/
    @:native('enable_state')
    static function enableState(state:RenderState):Void;

    /**
        Enables a texture for a render target.

        @param unit texture unit to enable texture for
        @param renderTarget render target from which to enable the specified texture unit
        @param bufferType buffer type from which to enable the texture
    **/
    @:native('enable_texture')
    static function enableTexture(unit:Int, renderTarget:EitherType<RenderTarget,TextureResourceHandle>, bufferType:RenderBufferType):Void;

    /**
        Gets the window height, as specified for the project.

        @return specified window height
    **/
    @:pure
    @:native('get_height')
    static function getHeight():Int;

    /**
        Retrieve a buffer height from a render target.

        @param renderTarget render target from which to retrieve the buffer height
        @param bufferType which type of buffer to retrieve the height from
        @return the height of the render target buffer texture
    **/
    @:pure
    @:native('get_render_target_height')
    static function getRenderTargetHeight(renderTarget:RenderTarget, bufferType:RenderBufferType):Int;

    /**
        Retrieve a buffer width from a render target.

        @param renderTarget render target from which to retrieve the buffer width
        @param bufferType which type of buffer to retrieve the width from
        @return the width of the render target buffer texture
    **/
    @:pure
    @:native('get_render_target_width')
    static function getRenderTargetWidth(renderTarget:RenderTarget, bufferType:RenderBufferType):Int;

    /**
        Gets the window width, as specified for the project.

        @return specified window width
    **/
    @:pure
    @:native('get_width')
    static function getWidth():Int;

    /**
        Gets the actual window height.

        @return actual window height
    **/
    @:pure
    @:native('get_window_height')
    static function getWindowHeight():Int;

    /**
        Gets the actual window width.

        @return actual window width
    **/
    @:pure
    @:native('get_window_width')
    static function getWindowWidth():Int;

    /**
        Creates a new render predicate.

        This function returns a new render predicate for objects with materials matching
        the provided material tags. The provided tags are combined into a bit mask
        for the predicate. If multiple tags are provided, the predicate matches materials
        with all tags ANDed together.

        The current limit to the number of tags that can be defined is `64`.

        @param predicates table of tags that the predicate should match (table).
        @return new predicate
    **/
    static function predicate(predicates:LuaArray<HashOrString>):RenderPredicate;

    /**
        Creates a new render target.

        Creates a new render target according to the supplied specification table.
    **/
    @:native('render_target')
    static function renderTarget(parameters:lua.Table<RenderBufferType,RenderTargetParameters>):RenderTarget;

    /**
        Sets the blending function.

        @param sourceFactor source factor
        @param destinationFactor destination factor
    **/
    @:native('set_blend_func')
    static function setBlendFunc(sourceFactor:RenderBlendFactor, destinationFactor:RenderBlendFactor):Void;

    /**
        Sets the color mask.

        @param red red mask
        @param green green mask
        @param blue blue mask
        @param alpha alpha mask
    **/
    @:native('set_color_mask')
    static function setColorMask(red:Bool, green:Bool, blue:Bool, alpha:Bool):Void;

    /**
        Sets the cull face.

        @param faceType face type
    **/
    @:native('set_cull_face')
    static function setCullFace(faceType:RenderCullFaceType):Void;

    /**
        Sets the depth test function.

        @param func depth test function
    **/
    @:native('set_depth_func')
    static function setDepthFunc(func:RenderCompareFunc):Void;

    /**
        Sets the depth mask.

        @param depth depth mask
    **/
    @:native('set_depth_mask')
    static function setDepthMask(depth:Bool):Void;

    /**
        Sets the polygon offset.

        @param factor polygon offset factor
        @param units polygon offset units
    **/
    @:native('set_polygon_offset')
    static function setPolygonOffset(factor:Float, units:Float):Void;

    /**
        Sets the projection matrix to use when rendering.

        @param matrix projection matrix
    **/
    @:native('set_projection')
    static function setProjection(matrix:Matrix4):Void;

    /**
        Sets a render target. Subsequent draw operations will be to the
        render target until it is replaced by a subsequent call to set_render_target.

        @param renderarget render target to set. `RenderTarget.Default` to set the default render target
        @param options optional table with behaviour parameters
    **/
    @:native('set_render_target')
    static function setRenderTarget(renderarget:RenderTarget, ?options:SetRenderTargetOptions):Void;

    /**
        Sets the render target size.

        @param renderarget render target to set size for
        @param width new render target width
        @param height new render target height
    **/
    @:native('set_render_target_size')
    static function setRenderTargetSize(renderarget:RenderTarget, width:Int, height:Int):Void;

    /**
        Sets the stencil test function.

        @param func stencil test function
        @param ref reference value for the stencil test
        @param mask mask that is ANDed with both the reference value and the stored stencil value when the test is done
    **/
    @:native('set_stencil_func')
    static function setStencilFunc(func:RenderCompareFunc, ref:Float, mask:Int):Void;

    /**
        Sets the stencil mask.

        @param mask stencil mask (number)
    **/
    @:native('set_stencil_mask')
    static function setStencilMask(mask:Int):Void;

    /**
        Sets the stencil operator.

        @param sfail action to take when the stencil test fails
        @param dpfail the stencil action when the stencil test passes
        @param dppass the stencil action when both the stencil test and the depth test pass, or when the stencil test passes and either there is no depth buffer or depth testing is not enabled
    **/
    @:native('set_stencil_op')
    static function setStencilOp(sfail:RenderStencilOp, dpfail:RenderStencilOp, dppass:RenderStencilOp):Void;

    /**
        Sets the view matrix to use when rendering.

        @param matrix view matrix to set
    **/
    @:native('set_view')
    static function setView(matrix:Matrix4):Void;

    /**
        Sets the render viewport.

        @param x left corner
        @param y bottom corner
        @param width viewport width
        @param height viewport height
    **/
    @:native('set_viewport')
    static function setViewport(x:Int, y:Int, width:Int, height:Int):Void;
}

/**
    Table type for the `Render.clear` argument.
**/
typedef RenderClearBuffers = lua.Table<RenderBufferType, EitherType<Vector4, Float>>;

/**
    Messages related to the `Render` module.
**/
@:publicFields
class RenderMessages
{
    /**
        Set render clear color.

        This is the color that appears on the screen where nothing is rendered, i.e. background.
    **/
    static var clear_color(default, never) = new Message<RenderMessageClearColor>("clear_color");

    /**
        Draw a text on the screen.

        Draw a text on the screen. This should be used for debugging purposes only.
    **/
    static var draw_debug_text(default, never) = new Message<RenderMessageDrawDebugText>("draw_debug_text");

    /**
        Draw a line on the screen.

        This should mostly be used for debugging purposes.
    **/
    static var draw_line(default, never) = new Message<RenderMessageDrawLine>("draw_line");

    /**
        Draw a text on the screen.

        This should mostly be used for debugging purposes.
    **/
    static var draw_text(default, never) = new Message<RenderMessageDrawText>("draw_text");

    /**
        Resizes the window.

        Set the size of the game window. Only works on desktop platforms.
    **/
    static var resize(default, never) = new Message<RenderMessageResize>("resize");

    /**
        Reports a window size change.

        Reports a change in window size. This is initiated on window resize on desktop or by orientation changes
        on mobile devices.
    **/
    static var window_resized(default, never) = new Message<RenderMessageWindowResized>("window_resized");

    /**
        The camera component that has camera focus will sent set_view_projection messages to the @render socket.
    **/
    static var set_view_projection(default, never) = new Message<RenderMessageSetViewProjection>("set_view_projection");

    /**
        The stretch projection stretches the view when the window resizes.
    **/
    static var use_stretch_projection(default, never) = new Message<RenderMessageUseStretchProjection>("use_stretch_projection");

    /**
        The fixed fit projection keeps the aspect ratio and shows more of the game when the window resizes.
    **/
    static var use_fixed_fit_projection(default, never) = new Message<RenderMessageUseFixedFitProjection>("use_fixed_fit_projection");

    /**
        The fixed projection keeps the aspect ratio and has a zoom to show more or less of the game.
    **/
    static var use_fixed_projection(default, never) = new Message<RenderMessageUseFixedProjection>("use_fixed_projection");

    /**
        Suitable for 3D games. Enables the perspective projection provided from a camera component .
    **/
    static var use_camera_projection(default, never) = new Message<Void>("use_camera_projection");
}

/**
    Data for the `RenderMessages.set_view_projection` message.
**/
typedef RenderMessageSetViewProjection =
{
    var view:Matrix4;
    var projection:Matrix4;
}

/**
    Data for the `RenderMessages.use_stretch_projection` message.
**/
typedef RenderMessageUseStretchProjection =
{
    /**
        near clipping plane
    **/
    var ?near:Float;

    /**
        far clipping plane
    **/
    var ?far:Float;
}

/**
    Data for the `RenderMessages.use_fixed_fit_projection` message.
**/
typedef RenderMessageUseFixedFitProjection =
{
    /**
        near clipping plane
    **/
    var ?near:Float;

    /**
        far clipping plane
    **/
    var ?far:Float;
}

/**
    Data for the `RenderMessages.use_fixed_projection` message.
**/
typedef RenderMessageUseFixedProjection =
{
    /**
        near clipping plane
    **/
    var ?near:Float;

    /**
        far clipping plane
    **/
    var ?far:Float;

    /**
        view zoom
    **/
    var ?zoom:Float;
}

/**
    Data for the `RenderMessages.clear_color` message.
**/
typedef RenderMessageClearColor =
{
    /**
        color to use as clear color
    **/
    var color:Vector4;
}

/**
    Data for the `RenderMessages.draw_debug_text` message.
**/
typedef RenderMessageDrawDebugText =
{
    /**
        position of the text
    **/
    var position:Vector3;

    /**
        the text to draw
    **/
    var text:String;

    /**
        color of the text
    **/
    var color:Vector4;
}

/**
    Data for the `RenderMessages.draw_line` message.
**/
typedef RenderMessageDrawLine =
{
    /**
        Start point of the line
    **/
    var start_point:Vector3;

    /**
        End point of the line
    **/
    var end_point:Vector3;

    /**
        Color of the line
    **/
    var color:Vector4;
}

/**
    Data for the `RenderMessages.draw_text` message.
**/
typedef RenderMessageDrawText =
{
    /**
        Position of the text
    **/
    var position:Vector3;

    /**
        The text to draw
    **/
    var text:String;
}

/**
    Data for the `RenderMessages.resize` message.
**/
typedef RenderMessageResize =
{
    /**
        The new window height
    **/
    var height:Int;

    /**
        The new window width
    **/
    var width:Int;
}

/**
    Render buffer types.
**/
@:native("_G.render")
extern enum abstract RenderBufferType(Int) to Int
{
    @:native('BUFFER_COLOR_BIT')
    var ColorBit;
    @:native('BUFFER_DEPTH_BIT')
    var DepthBit;
    @:native('BUFFER_STENCIL_BIT')
    var StencilBit;
}

/**
    Data for the `RenderMessages.window_resized` message.
**/
typedef RenderMessageWindowResized =
{
    /**
        the new window height
    **/
    var height:Int;

    /**
        the new window width
    **/
    var width:Int;
}

/**
    Rendering constant buffer.

    The buffer's constant elements can be indexed like an ordinary Lua table,
    but you can't iterate over them with pairs() or ipairs().
**/
extern final class RenderConstantBuffer implements Dynamic<Dynamic> {}

/**
    Rendering target.
**/
@:native("_G.render")
extern enum abstract RenderTarget({})
{
    @:native('RENDER_TARGET_DEFAULT')
    var Default;
}

/**
    Type of the `parameters` argument of the `Render.render_target` method.
**/
typedef RenderTargetParameters =
{
    var format:RenderFormat;
    var width:Int;
    var height:Int;
    var min_filter:RenderFilter;
    var mag_filter:RenderFilter;
    var u_wrap:RenderWrap;
    var v_wrap:RenderWrap;
}

/**
    Type of the `RenderTargetParameters.format` field.
**/
@:native("_G.render")
extern enum abstract RenderFormat({})
{
    @:native('FORMAT_LUMINANCE')
    var Luminance;
    @:native('FORMAT_RGB')
    var Rgb;
    @:native('FORMAT_RGBA')
    var Rgba;
    @:native('FORMAT_RGB_DXT1')
    var RgbDxt1;
    @:native('FORMAT_RGBA_DXT1')
    var RgbaDxt1;
    @:native('FORMAT_RGBA_DXT3')
    var RgbaDxt3;
    @:native('FORMAT_RGBA_DXT5')
    var RgbaDxt5;
    @:native('FORMAT_DEPTH')
    var Depth;
    @:native('FORMAT_STENCIL')
    var Stencil;
    @:native('FORMAT_RGB32F')
    var Rgb32f;
    @:native('FORMAT_RGBA16F')
    var Rgba16f;
    @:native('FORMAT_RGBA32F')
    var Rgba32f;
    @:native('FORMAT_R16F')
    var R16f;
    @:native('FORMAT_RG16F')
    var Rg16f;
    @:native('FORMAT_R32F')
    var R32f;
    @:native('FORMAT_RG32F')
    var Rg32f;
}

/**
    Type of the `RenderTargetParameters.min_filter` (and `mag_filter`) field.
**/
@:native("_G.render")
extern enum abstract RenderFilter({})
{
    @:native('FILTER_LINEAR')
    var Linear;
    @:native('FILTER_NEAREST')
    var Nearest;
}

/**
    Type of the `RenderTargetParameters.u_wrap` (and `v_wrap`) field.
**/
@:native("_G.render")
extern enum abstract RenderWrap({})
{
    @:native('WRAP_CLAMP_TO_BORDER')
    var ClampToBorder;
    @:native('WRAP_CLAMP_TO_EDGE')
    var ClampToEdge;
    @:native('WRAP_MIRRORED_REPEAT')
    var MirroredRepeat;
    @:native('WRAP_REPEAT')
    var Repeat;
}

/**
    Rendering states enumeration.
**/
@:native("_G.render")
extern enum abstract RenderState({})
{
    @:native('STATE_DEPTH_TEST')
    var DepthTest;
    @:native('STATE_STENCIL_TEST')
    var StencilTest;
    @:native('STATE_BLEND')
    var Blend;
    @:native('STATE_ALPHA_TEST')
    var AlphaTest;
    @:native('STATE_CULL_FACE')
    var CullFace;
    @:native('STATE_POLYGON_OFFSET_FILL')
    var PolygonOffsetFill;
}

/**
    Render predicate used in `Render.draw` and created by `Render.predicate`.
**/
extern final class RenderPredicate {}

/**
    Render blend functions enumeration (see `Render.set_blend_func`).
**/
@:native("_G.render")
extern enum abstract RenderBlendFactor({})
{
    @:native('BLEND_ZERO')
    var Zero;
    @:native('BLEND_ONE')
    var One;
    @:native('BLEND_SRC_COLOR')
    var SrcColor;
    @:native('BLEND_ONE_MINUS_SRC_COLOR')
    var OneMinusSrcColor;
    @:native('BLEND_DST_COLOR')
    var DstColor;
    @:native('BLEND_ONE_MINUS_DST_COLOR')
    var OneMinusDstColor;
    @:native('BLEND_SRC_ALPHA')
    var SrcAlpha;
    @:native('BLEND_ONE_MINUS_SRC_ALPHA')
    var OneMinusSrcAlpha;
    @:native('BLEND_DST_ALPHA')
    var DstAlpha;
    @:native('BLEND_ONE_MINUS_DST_ALPHA')
    var OneMinusDstAlpha;
    @:native('BLEND_SRC_ALPHA_SATURATE')
    var AlphaSaturate;
    @:native('BLEND_CONSTANT_COLOR')
    var ConstantColor;
    @:native('BLEND_ONE_MINUS_CONSTANT_COLOR')
    var OneMinusConstantColor;
    @:native('BLEND_CONSTANT_ALPHA')
    var ConstantAlpha;
    @:native('BLEND_ONE_MINUS_CONSTANT_ALPHA')
    var OneMinusConstantAlpha;
}

/**
    Rendering cull face type enumeration (see `Render.set_cull_face`).
**/
@:native("_G.render")
extern enum abstract RenderCullFaceType({})
{
    @:native('FACE_FRONT')
    var Front;
    @:native('FACE_BACK')
    var Back;
    @:native('FACE_FRONT_AND_BACK')
    var FrontAndBack;
}

/**
    Compare functions enumeration (used in `Render.set_depth_func` and `Render.set_stencil_func`).
**/
@:native("_G.render")
extern enum abstract RenderCompareFunc({})
{
    @:native('COMPARE_FUNC_NEVER')
    var Never;
    @:native('COMPARE_FUNC_LESS')
    var Less;
    @:native('COMPARE_FUNC_LEQUAL')
    var LessEqual;
    @:native('COMPARE_FUNC_GREATER')
    var Greater;
    @:native('COMPARE_FUNC_GEQUAL')
    var GreaterEqual;
    @:native('COMPARE_FUNC_EQUAL')
    var Equal;
    @:native('COMPARE_FUNC_NOTEQUAL')
    var NotEqual;
    @:native('COMPARE_FUNC_ALWAYS')
    var Always;
}

/**
    Stencil operations enumeration (see `Render.set_stencil_func`).
**/
@:native("_G.render")
extern enum abstract RenderStencilOp({})
{
    @:native('STENCIL_OP_KEEP')
    var Keep;
    @:native('STENCIL_OP_ZERO')
    var Zero;
    @:native('STENCIL_OP_REPLACE')
    var Replace;
    @:native('STENCIL_OP_INCR')
    var Incr;
    @:native('STENCIL_OP_INCR_WRAP')
    var IncrWrap;
    @:native('STENCIL_OP_DECR')
    var Decr;
    @:native('STENCIL_OP_DECR_WRAP')
    var DecrWrap;
    @:native('STENCIL_OP_INVERT')
    var Invert;
}

/**
    Options for the `Render.set_render_target`.
**/
typedef SetRenderTargetOptions =
{
    /**
        Transient frame buffer types are only valid while the render target is active, i.e becomes undefined when a new target is set by a subsequent call to `Render.set_render_target`.
        Default is all non-transient. Be aware that some hardware uses a combined depth stencil buffer and when this is the case both are considered non-transient if exclusively selected!
        A buffer type defined that doesn't exist in the render target is silently ignored
    **/
    var transient:LuaArray<RenderBufferType>;
}

typedef RenderDrawOptions =
{
    /**
        A frustum matrix used to cull renderable items. (E.g. local frustum = proj * view).
    **/
    var ?frustum:Matrix4;

    /**
        Constants to use while rendering
    **/
    var ?constants:RenderConstantBuffer;
}
