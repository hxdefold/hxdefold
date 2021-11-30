package defold;

import haxe.extern.EitherType;
import defold.types.*;

/**
    Rendering functions, messages and constants. The "render" namespace is
    accessible only from render scripts.

    See `RenderMessages` for related messages.
**/
@:native("_G.render")
extern class Render {
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
    static function constant_buffer():RenderConstantBuffer;

    /**
        Deletes a render target.

        @param render_target render target to delete
    **/
    static function delete_render_target(render_target:RenderTarget):Void;

    /**
        Disables the currently enabled material.

        If a material is currently enabled, disable it.
    **/
    static function disable_material():Void;

    /**
        Disables a render state.

        @param state state to enable
    **/
    static function disable_state(state:RenderState):Void;

    /**
        Disables a texture for a render target.

        @param unit texture unit to enable disable for
    **/
    static function disable_texture(unit:Int):Void;

    /**
        Draws all objects matching a predicate.

        Draws all objects that match a specified predicate. An optional constant buffer can be
        provided to override the default constants. If no constants buffer is provided, a default
        system constants buffer is used containing constants as defined in materials and set through
        `*.set_constant()` and `*.reset_constant()` on visual components.

        @param predicate predicate to draw for
        @param constants optional constants to use while rendering
    **/
    static function draw(predicate:RenderPredicate, ?constants:RenderConstantBuffer):Void;

    /**
        Draws all 2d debug graphics (Deprecated).
    **/
    @:deprecated("Use `Render.draw_debug3d` to draw visual debug info.")
    static function draw_debug2d():Void;

    /**
        Draws all 3d debug graphics such as lines drawn with "draw_line" messages and physics visualization.
    **/
    static function draw_debug3d():Void;

    /**
        Enables a material.

        If another material was already enabled, it will be automatically disabled.

        @param material_id material id to enable
    **/
    static function enable_material(material_id:String):Void;

    /**
        Enables a render state.

        @param state state to enable
    **/
    static function enable_state(state:RenderState):Void;

    /**
        Enables a texture for a render target.

        @param unit texture unit to enable texture for
        @param render_target render target from which to enable the specified texture unit
        @param buffer_type buffer type from which to enable the texture
    **/
    static function enable_texture(unit:Int, render_target:RenderTarget, buffer_type:RenderBufferType):Void;

    /**
        Gets the window height, as specified for the project.

        @return specified window height
    **/
    static function get_height():Int;

    /**
        Retrieve a buffer height from a render target.

        @param render_target render target from which to retrieve the buffer height
        @param buffer_type which type of buffer to retrieve the height from
        @return the height of the render target buffer texture
    **/
    static function get_render_target_height(render_target:RenderTarget, buffer_type:RenderBufferType):Int;

    /**
        Retrieve a buffer width from a render target.

        @param render_target render target from which to retrieve the buffer width
        @param buffer_type which type of buffer to retrieve the width from
        @return the width of the render target buffer texture
    **/
    static function get_render_target_width(render_target:RenderTarget, buffer_type:RenderBufferType):Int;

    /**
        Gets the window width, as specified for the project.

        @return specified window width
    **/
    static function get_width():Int;

    /**
        Gets the actual window height.

        @return actual window height
    **/
    static function get_window_height():Int;

    /**
        Gets the actual window width.

        @return actual window width
    **/
    static function get_window_width():Int;

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
    static function predicate(predicates:lua.Table<Int,HashOrString>):RenderPredicate;

    /**
        Creates a new render target.

        Creates a new render target according to the supplied specification table.
    **/
    static function render_target(name:String, parameters:RenderTargetParameters):RenderTarget;

    /**
        Sets the blending function.

        @param source_factor source factor
        @param destination_factor destination factor
    **/
    static function set_blend_func(source_factor:RenderBlendFactor, destination_factor:RenderBlendFactor):Void;

    /**
        Sets the color mask.

        @param red red mask
        @param green green mask
        @param blue blue mask
        @param alpha alpha mask
    **/
    static function set_color_mask(red:Bool, green:Bool, blue:Bool, alpha:Bool):Void;

    /**
        Sets the cull face.

        @param face_type face type
    **/
    static function set_cull_face(face_type:RenderCullFaceType):Void;

    /**
        Sets the depth test function.

        @param func depth test function
    **/
    static function set_depth_func(func:RenderCompareFunc):Void;

    /**
        Sets the depth mask.

        @param depth depth mask
    **/
    static function set_depth_mask(depth:Bool):Void;

    /**
        Sets the polygon offset.

        @param factor polygon offset factor
        @param units polygon offset units
    **/
    static function set_polygon_offset(factor:Float, units:Float):Void;

    /**
        Sets the projection matrix to use when rendering.

        @param matrix projection matrix
    **/
    static function set_projection(matrix:Matrix4):Void;

    static var RENDER_TARGET_DEFAULT(default,never):RenderTarget;

    /**
        Sets a render target. Subsequent draw operations will be to the
        render target until it is replaced by a subsequent call to set_render_target.

        @param render_target render target to set. `Render.RENDER_TARGET_DEFAULT` to set the default render target
        @param options optional table with behaviour parameters
    **/
    static function set_render_target(render_target:RenderTarget, ?options:SetRenderTargetOptions):Void;

    /**
        Sets the render target size.

        @param render_target render target to set size for
        @param width new render target width
        @param height new render target height
    **/
    static function set_render_target_size(render_target:RenderTarget, width:Int, height:Int):Void;

    /**
        Sets the stencil test function.

        @param func stencil test function
        @param ref reference value for the stencil test
        @param mask mask that is ANDed with both the reference value and the stored stencil value when the test is done
    **/
    static function set_stencil_func(func:RenderCompareFunc, ref:Float, mask:Int):Void;

    /**
        Sets the stencil mask.

        @param mask stencil mask (number)
    **/
    static function set_stencil_mask(mask:Int):Void;

    /**
        Sets the stencil operator.

        @param sfail action to take when the stencil test fails
        @param dpfail the stencil action when the stencil test passes
        @param dppass the stencil action when both the stencil test and the depth test pass, or when the stencil test passes and either there is no depth buffer or depth testing is not enabled
    **/
    static function set_stencil_op(sfail:RenderStencilOp, dpfail:RenderStencilOp, dppass:RenderStencilOp):Void;

    /**
        Sets the view matrix to use when rendering.

        @param matrix view matrix to set
    **/
    static function set_view(matrix:Matrix4):Void;

    /**
        Sets the render viewport.

        @param x left corner
        @param y bottom corner
        @param width viewport width
        @param height viewport height
    **/
    static function set_viewport(x:Int, y:Int, width:Int, height:Int):Void;
}

/**
    Table type for the `Render.clear` argument.
**/
typedef RenderClearBuffers = lua.Table<RenderBufferType,EitherType<Vector4,Float>>;

/**
    Messages related to the `Render` module.
**/
@:publicFields
class RenderMessages {
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
typedef RenderMessageSetViewProjection = {
    var view:Matrix4;
}

/**
    Data for the `RenderMessages.use_stretch_projection` message.
**/
typedef RenderMessageUseStretchProjection = {
  /**
      near clipping plane
  **/
  var near:Float;
  /**
      far clipping plane
  **/
  var far:Float;
}

/**
    Data for the `RenderMessages.use_fixed_fit_projection` message.
**/
typedef RenderMessageUseFixedFitProjection = {
  /**
      near clipping plane
  **/
  var near:Float;
  /**
      far clipping plane
  **/
  var far:Float;
}

/**
    Data for the `RenderMessages.use_fixed_projection` message.
**/
typedef RenderMessageUseFixedProjection = {
  /**
      near clipping plane
  **/
  var near:Float;
  /**
      far clipping plane
  **/
  var far:Float;
  /**
      view zoom
  **/
  var zoom:Float;
}

/**
    Data for the `RenderMessages.clear_color` message.
**/
typedef RenderMessageClearColor = {
    /**
        color to use as clear color
    **/
    var color:Vector4;
}

/**
    Data for the `RenderMessages.draw_debug_text` message.
**/
typedef RenderMessageDrawDebugText = {
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
typedef RenderMessageDrawLine = {
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
typedef RenderMessageDrawText = {
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
typedef RenderMessageResize = {
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
@:enum extern abstract RenderBufferType(Int) to Int {
    var BUFFER_COLOR_BIT;
    var BUFFER_DEPTH_BIT;
    var BUFFER_STENCIL_BIT;
}

/**
    Data for the `RenderMessages.window_resized` message.
**/
typedef RenderMessageWindowResized = {
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
extern class RenderConstantBuffer implements Dynamic<Dynamic> {}

/**
    Rendering target.
**/
extern class RenderTarget {}

/**
    Type of the `parameters` argument of the `Render.render_target` method.
**/
typedef RenderTargetParameters = {
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
@:enum extern abstract RenderFormat({}) {
    var FORMAT_LUMINANCE;
    var FORMAT_RGB;
    var FORMAT_RGBA;
    var FORMAT_RGB_DXT1;
    var FORMAT_RGBA_DXT1;
    var FORMAT_RGBA_DXT3;
    var FORMAT_RGBA_DXT5;
    var FORMAT_DEPTH;
    var FORMAT_STENCIL;
}

/**
    Type of the `RenderTargetParameters.min_filter` (and `mag_filter`) field.
**/
@:native("_G.render")
@:enum extern abstract RenderFilter({}) {
    var FILTER_LINEAR;
    var FILTER_NEAREST;
}

/**
    Type of the `RenderTargetParameters.u_wrap` (and `v_wrap`) field.
**/
@:native("_G.render")
@:enum extern abstract RenderWrap({}) {
    var WRAP_CLAMP_TO_BORDER;
    var WRAP_CLAMP_TO_EDGE;
    var WRAP_MIRRORED_REPEAT;
    var WRAP_REPEAT;
}

/**
    Rendering states enumeration.
**/
@:native("_G.render")
@:enum extern abstract RenderState({}) {
    var STATE_DEPTH_TEST;
    var STATE_STENCIL_TEST;
    var STATE_BLEND;
    var STATE_ALPHA_TEST;
    var STATE_CULL_FACE;
    var STATE_POLYGON_OFFSET_FILL;
}

/**
    Render predicate used in `Render.draw` and created by `Render.predicate`.
**/
extern class RenderPredicate {}

/**
    Render blend functions enumeration (see `Render.set_blend_func`).
**/
@:native("_G.render")
@:enum extern abstract RenderBlendFactor({}) {
    var BLEND_ZERO;
    var BLEND_ONE;
    var BLEND_SRC_COLOR;
    var BLEND_ONE_MINUS_SRC_COLOR;
    var BLEND_DST_COLOR;
    var BLEND_ONE_MINUS_DST_COLOR;
    var BLEND_SRC_ALPHA;
    var BLEND_ONE_MINUS_SRC_ALPHA;
    var BLEND_DST_ALPHA;
    var BLEND_ONE_MINUS_DST_ALPHA;
    var BLEND_SRC_ALPHA_SATURATE;
    var BLEND_CONSTANT_COLOR;
    var BLEND_ONE_MINUS_CONSTANT_COLOR;
    var BLEND_CONSTANT_ALPHA;
    var BLEND_ONE_MINUS_CONSTANT_ALPHA;
}

/**
    Rendering cull face type enumeration (see `Render.set_cull_face`).
**/
@:native("_G.render")
@:enum extern abstract RenderCullFaceType({}) {
    var FACE_FRONT;
    var FACE_BACK;
    var FACE_FRONT_AND_BACK;
}

/**
    Compare functions enumeration (used in `Render.set_depth_func` and `Render.set_stencil_func`).
**/
@:native("_G.render")
@:enum extern abstract RenderCompareFunc({}) {
    var COMPARE_FUNC_NEVER;
    var COMPARE_FUNC_LESS;
    var COMPARE_FUNC_LEQUAL;
    var COMPARE_FUNC_GREATER;
    var COMPARE_FUNC_GEQUAL;
    var COMPARE_FUNC_EQUAL;
    var COMPARE_FUNC_NOTEQUAL;
    var COMPARE_FUNC_ALWAYS;
}

/**
    Stencil operations enumeration (see `Render.set_stencil_func`).
**/
@:native("_G.render")
@:enum extern abstract RenderStencilOp({}) {
    var STENCIL_OP_KEEP;
    var STENCIL_OP_ZERO;
    var STENCIL_OP_REPLACE;
    var STENCIL_OP_INCR;
    var STENCIL_OP_INCR_WRAP;
    var STENCIL_OP_DECR;
    var STENCIL_OP_DECR_WRAP;
    var STENCIL_OP_INVERT;
}

/**
    Options for the `Render.set_render_target`.
**/
typedef SetRenderTargetOptions = {
    /**
        Transient frame buffer types are only valid while the render target is active, i.e becomes undefined when a new target is set by a subsequent call to `Render.set_render_target`.
        Default is all non-transient. Be aware that some hardware uses a combined depth stencil buffer and when this is the case both are considered non-transient if exclusively selected!
        A buffer type defined that doesn't exist in the render target is silently ignored
    **/
    var transient:lua.Table<Int,RenderBufferType>;
}
