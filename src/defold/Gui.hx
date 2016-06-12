package defold;

import haxe.extern.EitherType;
import defold.types.*;

@:native("_G.gui")
extern class Gui {
    static var PROP_POSITION(default,null):String;
    static var PROP_ROTATION(default,null):String;
    static var PROP_SCALE(default,null):String;
    static var PROP_COLOR(default,null):String;
    static var PROP_OUTLINE(default,null):String;
    static var PROP_SHADOW(default,null):String;
    static var PROP_SIZE(default,null):String;
    static var PROP_FILL_ANGLE(default,null):String;
    static var PROP_INNER_RADIUS(default,null):String;
    static var PROP_SLICE9(default,null):String;

    static var RGB(default,null):String;
    static var RGBA(default,null):String;
    static var LUMINANCE(default,null):String;

    static function animate<T>(node:GuiNode, property:String, to:EitherType<Vector3,Vector4>, easing:EitherType<GuiEasing,EitherType<Vector3,Vector4>>, duration:Float, ?delay:Float, ?complete_function:T->GuiNode->Void, ?playback:GuiPlayback):Void;
    static function cancel_animation(node:GuiNode, property:String):Void;

    static function cancel_flipbook(node:GuiNode):Void;
    static function clone(node:GuiNode):GuiNode;
    static function clone_tree(node:GuiNode):lua.Table<Hash,GuiNode>;
    static function delete_node(node:GuiNode):Void;
    static function delete_texture(texture:HashOrString):Void;
    static function get_adjust_mode(node:GuiNode):GuiAdjustMode;
    static function get_blend_mode(node:GuiNode):GuiBlendMode;
    static function get_clipping_inverted(node:GuiNode):Bool;
    static function get_clipping_mode(node:GuiNode):GuiClippingMode;
    static function get_clipping_visible(node:GuiNode):Bool;
    static function get_color(node:GuiNode):Vector4;
    static function get_fill_angle(node:GuiNode):Float;
    static function get_flipbook(node:GuiNode):Hash;
    static function get_font(node:GuiNode):Hash;
    static function get_height():Float;
    static function get_id(node:GuiNode):Hash;
    static function get_index(node:GuiNode):Float;
    static function get_inner_radius(node:GuiNode):Float;
    static function get_layer(node:GuiNode):Hash;
    static function get_layout():Hash;
    static function get_leading(node:GuiNode):Float;
    static function get_line_break(node:GuiNode):Bool;
    static function get_node(id:HashOrString):GuiNode;
    static function get_outer_bounds(node:GuiNode):GuiOuterBounds;
    static function get_outline(node:GuiNode):Vector4;
    static function get_parent(node:GuiNode):Null<GuiNode>;
    static function get_perimeter_vertices():Int;
    static function get_pivot(node:GuiNode):GuiPivot;
    static function get_position(node:GuiNode):Vector3;
    static function get_rotation(node:GuiNode):Vector3;
    static function get_scale(node:GuiNode):Vector3;
    static function get_screen_position(node:GuiNode):Vector3;
    static function get_shadow(node:GuiNode):Vector4;
    static function get_size(node:GuiNode):Vector3;
    static function get_size_mode(node:GuiNode):GuiSizeMode;
    static function get_slice9(node:GuiNode):Vector4;
    static function get_text(node:GuiNode):String;
    static function get_text_metrics(font:HashOrString, text:String, ?width:Float, ?line_breaks:Bool, ?leading:Float, ?tracking:Float):GuiTextMetrics;
    static function get_text_metrics_from_node(node:GuiNode):GuiTextMetrics;
    static function get_texture(node:GuiNode):Hash;
    static function get_tracking(node:GuiNode):Float;
    static function get_width():Float;
    static function get_xanchor(node:GuiNode):GuiXAnchor;
    static function get_yanchor(node:GuiNode):GuiYAnchor;
    static function hide_keyboard():Void;
    static function is_enabled(node:GuiNode):Bool;
    static function move_above(node:GuiNode, ref:GuiNode):Void;
    static function move_below(node:GuiNode, ref:GuiNode):Void;
    static function new_box_node(pos:EitherType<Vector3,Vector4>, size:Vector3):GuiNode;
    static function new_pie_node(pos:EitherType<Vector3,Vector4>, size:Vector3):GuiNode;
    static function new_text_node(pos:EitherType<Vector3,Vector4>, text:String):GuiNode;
    static function new_texture(texture:HashOrString, width:Float, height:Float, type:String, buffer:String):Bool;
    static function pick_node(node:GuiNode, x:Float, y:Float):Bool;
    static function play_flipbook(node:GuiNode, animation:HashOrString, complete_function:Void->Void):Void;
    static function reset_keyboard():Void;
    static function reset_nodes():Void;
    static function set_adjust_mode(node:GuiNode, adjust_mode:GuiAdjustMode):Void;
    static function set_blend_mode(node:GuiNode, blend_mode:GuiBlendMode):Void;
    static function set_clipping_inverted(node:GuiNode, visible:Bool):Void;
    static function set_clipping_mode(node:GuiNode, clipping_mode:GuiClippingMode):Void;
    static function set_clipping_visible(node:GuiNode, visible:Bool):Void;
    static function set_color(node:GuiNode, color:EitherType<Vector3,Vector4>):Void;
    static function set_enabled(node:GuiNode, enabled:Bool):Void;
    static function set_fill_angle(node:GuiNode, angle:Float):Void;
    static function set_font(node:GuiNode, font:HashOrString):Void;
    static function set_id(node:GuiNode, id:HashOrString):Void;
    static function set_inner_radius(node:GuiNode, inner:Float):Void;
    static function set_layer(node:GuiNode, layer:HashOrString):Void;
    static function set_leading(node:GuiNode, leading:Float):Void;
    static function set_line_break(node:GuiNode, text:String):Void;
    static function set_outer_bounds(node:GuiNode, bounds:GuiOuterBounds):Void;
    static function set_outline(node:GuiNode, color:EitherType<Vector3,Vector4>):Void;
    static function set_parent(node:GuiNode, parent:GuiNode):Void;
    static function set_perimeter_vertices(vertex:Int):Void;
    static function set_pivot(node:GuiNode, pivot:GuiPivot):Void;
    static function set_position(node:GuiNode, position:EitherType<Vector3,Vector4>):Void;
    static function set_render_order(order:Float):Void;
    static function set_rotation(node:GuiNode, rotation:EitherType<Vector3,Vector4>):Void;
    static function set_scale(node:GuiNode, scale:EitherType<Vector3,Vector4>):Void;
    static function set_shadow(node:GuiNode, color:EitherType<Vector3,Vector4>):Void;
    static function set_size(node:GuiNode, size:EitherType<Vector3,Vector4>):Void;
    static function set_size_mode(node:GuiNode, size_mode:GuiSizeMode):Void;
    static function set_slice9(node:GuiNode, params:Vector4):Void;
    static function set_text(node:GuiNode, text:String):Void;
    static function set_texture(node:GuiNode, texture:HashOrString):Void;
    static function set_texture_data(texture:HashOrString, width:Float, height:Float, type:String, buffer:String):Bool;
    static function set_tracking(node:GuiNode, tracking:Float):Void;
    static function set_xanchor(node:GuiNode, anchor:GuiXAnchor):Void;
    static function set_yanchor(node:GuiNode, anchor:GuiYAnchor):Void;
    static function show_keyboard(type:GuiKeyboardType, autoclose:Bool):Void;
}

extern class GuiNode {}

@:native("_G.gui")
@:enum extern abstract GuiPlayback({}) {

}

@:native("_G.gui")
@:enum extern abstract GuiAdjustMode({}) {
    var ADJUST_FIT;
    var ADJUST_ZOOM;
    var ADJUST_STRETCH;
}

@:native("_G.gui")
@:enum extern abstract GuiBlendMode({}) {
    var BLEND_ALPHA;
    var BLEND_ADD;
    var BLEND_ADD_ALPHA;
    var BLEND_MULT;
}

@:native("_G.gui")
@:enum extern abstract GuiClippingMode({}) {
    var CLIPPING_MODE_NONE;
    var CLIPPING_MODE_STENCIL;
}

@:native("_G.gui")
@:enum extern abstract GuiPivot({}) {
    var PIVOT_CENTER;
    var PIVOT_N;
    var PIVOT_NE;
    var PIVOT_E;
    var PIVOT_SE;
    var PIVOT_S;
    var PIVOT_SW;
    var PIVOT_W;
    var PIVOT_NW;
}

@:native("_G.gui")
@:enum extern abstract GuiSizeMode({}) {
    var SIZE_MODE_MANUAL;
    var SIZE_MODE_AUTOMATIC;
}

typedef GuiTextMetrics = {
    var width:Float;
    var height:Float;
    var max_ascent:Float;
    var max_descent:Float;
}

@:native("_G.gui")
@:enum extern abstract GuiXAnchor({}) {
    var ANCHOR_NONE;
    var ANCHOR_LEFT;
    var ANCHOR_RIGHT;
}

@:native("_G.gui")
@:enum extern abstract GuiYAnchor({}) {
    var ANCHOR_NONE;
    var ANCHOR_TOP;
    var ANCHOR_BOTTOM;
}

@:native("_G.gui")
@:enum extern abstract GuiOuterBounds({}) {
    var BOUNDS_RECTANGLE;
    var BOUNDS_ELLIPSE;
}

@:native("_G.gui")
@:enum extern abstract GuiKeyboardType({}) {
    var KEYBOARD_TYPE_DEFAULT;
    var KEYBOARD_TYPE_EMAIL;
    var KEYBOARD_TYPE_NUMBER_PAD;
    var KEYBOARD_TYPE_PASSWORD;
}

@:native("_G.gui")
@:enum extern abstract GuiEasing({}) {
    var EASING_INBACK;
    var EASING_INBOUNCE;
    var EASING_INCIRC;
    var EASING_INCUBIC;
    var EASING_INELASTIC;
    var EASING_INEXPO;
    var EASING_INOUTBACK;
    var EASING_INOUTBOUNCE;
    var EASING_INOUTCIRC;
    var EASING_INOUTCUBIC;
    var EASING_INOUTELASTIC;
    var EASING_INOUTEXPO;
    var EASING_INOUTQUAD;
    var EASING_INOUTQUART;
    var EASING_INOUTQUINT;
    var EASING_INOUTSINE;
    var EASING_INQUAD;
    var EASING_INQUART;
    var EASING_INQUINT;
    var EASING_INSINE;
    var EASING_LINEAR;
    var EASING_OUT;
    var EASING_OUTBACK;
    var EASING_OUTBOUNCE;
    var EASING_OUTCIRC;
    var EASING_OUTCUBIC;
    var EASING_OUTELASTIC;
    var EASING_OUTEXPO;
    var EASING_OUTINBACK;
    var EASING_OUTINBOUNCE;
    var EASING_OUTINCIRC;
    var EASING_OUTINCUBIC;
    var EASING_OUTINELASTIC;
    var EASING_OUTINEXPO;
    var EASING_OUTINQUAD;
    var EASING_OUTINQUART;
    var EASING_OUTINQUINT;
    var EASING_OUTINSINE;
    var EASING_OUTQUAD;
    var EASING_OUTQUART;
    var EASING_OUTQUINT;
    var EASING_OUTSINE;
}
