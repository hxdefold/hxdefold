package defold;

import haxe.extern.EitherType;

@:native("_G.render")
extern class Render {
    static function clear(buffers:lua.Table<RenderBufferType,EitherType<Vector4,Float>>):Void;
    static function constant_buffer():ConstantBuffer;
    static function delete_render_target(render_target:RenderTarget):Void;
    static function disable_material():Void;
    static function disable_render_target(render_target:RenderTarget):Void;
    static function disable_state(state:RenderState):Void;
    static function disable_texture(unit:Int, render_target:RenderTarget):Void;
    static function draw(predicate:RenderPredicate, ?constants:ConstantBuffer):Void;
    static function draw_debug2d():Void;
    static function draw_debug3d():Void;
    static function enable_material(material_id:String):Void;
    static function enable_render_target(render_target:RenderTarget):Void;
    static function enable_state(state:RenderState):Void;
    static function enable_texture(unit:Int, render_target:RenderTarget, buffer_type:RenderBufferType):Void;
    static function get_height():Int;
    static function get_render_target_height(render_target:RenderTarget, buffer_type:RenderBufferType):Int;
    static function get_render_target_width(render_target:RenderTarget, buffer_type:RenderBufferType):Int;
    static function get_width():Int;
    static function get_window_height():Int;
    static function get_window_width():Int;
    static function predicate(predicates:lua.Table<Int,String>):RenderPredicate;
    static function render_target(name:String, parameters:RenderTargetParameters):RenderTarget;
    static function set_blend_func(source_factor:RenderBlendFactor, destination_factor:RenderBlendFactor):Void;
    static function set_color_mask(red:Bool, green:Bool, blue:Bool, alpha:Bool):Void;
    static function set_cull_face(face_type:RenderFaceType):Void;
    static function set_depth_func(func:RenderFunc):Void;
    static function set_depth_mask(depth:Bool):Void;
    static function set_polygon_offset(factor:Float, units:Float):Void;
    static function set_projection(matrix:Matrix4):Void;
    static function set_render_target_size(render_target:RenderTarget, width:Int, height:Int):Void;
    static function set_stencil_func(func:RenderFunc, ref:Float, mask:Int):Void;
    static function set_stencil_mask(mask:Int):Void;
    static function set_stencil_op(sfail:RenderStencilOp, dpfail:RenderStencilOp, dppass:RenderStencilOp):Void;
    static function set_view(matrix:Matrix4):Void;
    static function set_viewport(x:Int, y:Int, width:Int, height:Int):Void;
}

@:publicFields
class RenderMessages {
    static var ClearColor(default,never) = new Message<{color:Vector4}>("clear_color");
    static var DrawLine(default,never) = new Message<RenderMessageDrawLine>("draw_line");
    static var DrawText(default,never) = new Message<RenderMessageDrawText>("draw_text");
    static var WindowResized(default,never) = new Message<{width:Int, height:Int}>("window_resized");
}

typedef RenderMessageDrawLine = {
    start_point:Vector3,
    end_point:Vector3,
    color:Vector4,
}

typedef RenderMessageDrawText = {
    position:Vector3,
    text:String,
}

@:native("_G.render")
@:enum extern abstract RenderBufferType(Int) {
    var BUFFER_COLOR_BIT;
    var BUFFER_DEPTH_BIT;
    var BUFFER_STENCIL_BIT;
}

extern class ConstantBuffer implements Dynamic<Dynamic> {}

extern class RenderTarget {}

typedef RenderTargetParameters = {
    var format:RenderFormat;
    var width:Int;
    var height:Int;
    var min_filter:RenderFilter;
    var mag_filter:RenderFilter;
    var u_wrap:RenderWrap;
    var v_wrap:RenderWrap;
}

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

@:native("_G.render")
@:enum extern abstract RenderFilter({}) {
    var FILTER_LINEAR;
    var FILTER_NEAREST;
}

@:native("_G.render")
@:enum extern abstract RenderWrap({}) {
    var WRAP_CLAMP_TO_BORDER;
    var WRAP_CLAMP_TO_EDGE;
    var WRAP_MIRRORED_REPEAT;
    var WRAP_REPEAT;
}

@:native("_G.render")
@:enum extern abstract RenderState({}) {
    var STATE_DEPTH_TEST;
    var STATE_STENCIL_TEST;
    var STATE_BLEND;
    var STATE_ALPHA_TEST;
    var STATE_CULL_FACE;
    var STATE_POLYGON_OFFSET_FILL;
}

extern class RenderPredicate {}

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

@:native("_G.render")
@:enum extern abstract RenderFaceType({}) {
    var FACE_FRONT;
    var FACE_BACK;
    var FACE_FRONT_AND_BACK;
}

@:native("_G.render")
@:enum extern abstract RenderFunc({}) {
    var COMPARE_FUNC_NEVER;
    var COMPARE_FUNC_LESS;
    var COMPARE_FUNC_LEQUAL;
    var COMPARE_FUNC_GREATER;
    var COMPARE_FUNC_GEQUAL;
    var COMPARE_FUNC_EQUAL;
    var COMPARE_FUNC_NOTEQUAL;
    var COMPARE_FUNC_ALWAYS;
}

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
