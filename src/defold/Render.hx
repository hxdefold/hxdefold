package defold;

import haxe.extern.EitherType;
import defold.types.*;

/**
    Rendering functionality to be used from render scripts.

    See `RenderMessages` for messages related to render scripts.
**/
@:native("_G.render")
extern class Render {
    /**
        Clears the active render target.

        Clear buffers in the currently enabled render target with specified value.
    **/
    static function clear(buffers:lua.Table<RenderBufferType,EitherType<Vector4,Float>>):Void;

    /**
        Create a new constant buffer.

        Constant buffers are used to set shader program variables
        and are optionally passed to the `Render.draw` function.
    **/
    static function constant_buffer():RenderConstantBuffer;

    /**
        Deletes a render target.
    **/
    static function delete_render_target(render_target:RenderTarget):Void;

    /**
        Disables the currently enabled material.
    **/
    static function disable_material():Void;

    /**
        Disables a render target.
    **/
    static function disable_render_target(render_target:RenderTarget):Void;

    /**
        Disables a render state.
    **/
    static function disable_state(state:RenderState):Void;

    /**
        Disables a texture for a render target.
    **/
    static function disable_texture(unit:Int, render_target:RenderTarget):Void;

    /**
        Draws all objects matching a predicate.

        An optional constants buffer can be provided to override the default constants.
        If no constants buffer is provided, a default system constants buffer is used
        containing constants as defined in materials and set through `*.set_constant()`
        and `*.reset_constant()` on visual components.
    **/
    static function draw(predicate:RenderPredicate, ?constants:RenderConstantBuffer):Void;

    /**
        Draws all 2d debug graphics (Deprecated).
    **/
    @:deprecated
    static function draw_debug2d():Void;

    /**
        Draws all 3d debug graphics.
    **/
    static function draw_debug3d():Void;

    /**
        Enables a material.

        If another material was already enabled, it will be automatically disabled.
    **/
    static function enable_material(material_id:String):Void;

    /**
        Enables a render target.
    **/
    static function enable_render_target(render_target:RenderTarget):Void;

    /**
        Enables a render state.
    **/
    static function enable_state(state:RenderState):Void;

    /**
        Enables a texture for a render target.
    **/
    static function enable_texture(unit:Int, render_target:RenderTarget, buffer_type:RenderBufferType):Void;

    /**
        Gets the window height, as specified for the project.
    **/
    static function get_height():Int;

    /**
        Retrieve a buffer height from a render target.
    **/
    static function get_render_target_height(render_target:RenderTarget, buffer_type:RenderBufferType):Int;

    /**
        Retrieve a buffer width from a render target.
    **/
    static function get_render_target_width(render_target:RenderTarget, buffer_type:RenderBufferType):Int;

    /**
        Gets the window width, as specified for the project.
    **/
    static function get_width():Int;

    /**
        Gets the window height.
    **/
    static function get_window_height():Int;

    /**
        Gets the actual window width.
    **/
    static function get_window_width():Int;

    /**
        Creates a new render predicate.
    **/
    static function predicate(predicates:lua.Table<Int,String>):RenderPredicate;

    /**
        Creates a new render target.
    **/
    static function render_target(name:String, parameters:RenderTargetParameters):RenderTarget;

    /**
        Sets the blending function.
    **/
    static function set_blend_func(source_factor:RenderBlendFactor, destination_factor:RenderBlendFactor):Void;

    /**
        Sets the color mask.
    **/
    static function set_color_mask(red:Bool, green:Bool, blue:Bool, alpha:Bool):Void;

    /**
        Sets the cull face.
    **/
    static function set_cull_face(face_type:RenderFaceType):Void;

    /**
        Sets the depth test function.
    **/
    static function set_depth_func(func:RenderCompareFunc):Void;

    /**
        Sets the depth mask.
    **/
    static function set_depth_mask(depth:Bool):Void;

    /**
        Sets the polygon offset.
    **/
    static function set_polygon_offset(factor:Float, units:Float):Void;

    /**
        Sets the projection matrix.
    **/
    static function set_projection(matrix:Matrix4):Void;

    /**
        Sets the render target size.
    **/
    static function set_render_target_size(render_target:RenderTarget, width:Int, height:Int):Void;

    /**
        Sets the stencil test function.
    **/
    static function set_stencil_func(func:RenderCompareFunc, ref:Float, mask:Int):Void;

    /**
        Sets the stencil mask.
    **/
    static function set_stencil_mask(mask:Int):Void;

    /**
        Sets the stencil operator.
    **/
    static function set_stencil_op(sfail:RenderStencilOp, dpfail:RenderStencilOp, dppass:RenderStencilOp):Void;

    /**
        Sets the view matrix.
    **/
    static function set_view(matrix:Matrix4):Void;

    /**
        Sets the render viewport.
    **/
    static function set_viewport(x:Int, y:Int, width:Int, height:Int):Void;
}

/**
    Messages related to render scripts.
**/
@:publicFields
class RenderMessages {
    /**
        Set render clear color.

        This is the color that appears on the screen where nothing is rendered, i.e. background.
    **/
    static var ClearColor(default,never) = new Message<{color:Vector4}>("clear_color");

    /**
        Draw a line on the screen.

        This should mostly be used for debugging purposes.
    **/
    static var DrawLine(default,never) = new Message<RenderMessageDrawLine>("draw_line");

    /**
        Draw a text on the screen.

        This should mostly be used for debugging purposes.
    **/
    static var DrawText(default,never) = new Message<RenderMessageDrawText>("draw_text");

    /**
        Reports a change in window size.

        This is initiated on window resize on desktop or by orientation changes on mobile devices.
    **/
    static var WindowResized(default,never) = new Message<{width:Int, height:Int}>("window_resized");
}

/**
    Data for the `RenderMessages.DrawLine` message.
**/
typedef RenderMessageDrawLine = {
    start_point:Vector3,
    end_point:Vector3,
    color:Vector4,
}

/**
    Data for the `RenderMessages.DrawText` message.
**/
typedef RenderMessageDrawText = {
    position:Vector3,
    text:String,
}

/**
    Render buffer types.
**/
@:native("_G.render")
@:enum extern abstract RenderBufferType(Int) {
    var BUFFER_COLOR_BIT;
    var BUFFER_DEPTH_BIT;
    var BUFFER_STENCIL_BIT;
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
@:enum extern abstract RenderFaceType({}) {
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
