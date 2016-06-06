package defold;

import haxe.extern.EitherType;
import defold.support.HashOrString;

@:native("gui")
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

    static function animate<T>(node:Node, property:String, to:EitherType<Vector3,Vector4>, easing:EitherType<GuiEasing,EitherType<Vector3,Vector4>>, duration:Float, ?delay:Float, ?complete_function:T->Node->Void, ?playback:GuiPlayback):Void;
    static function cancel_animation(node:Node, property:String):Void;

    static function cancel_flipbook(node:Node):Void;
    static function clone(node:Node):Node;
    static function clone_tree(node:Node):lua.Table<Hash,Node>;
    static function delete_node(node:Node):Void;
    static function delete_texture(texture:HashOrString):Void;
    static function get_adjust_mode(node:Node):GuiAdjustMode;
    static function get_blend_mode(node:Node):GuiBlendMode;
    static function get_clipping_inverted(node:Node):Bool;
    static function get_clipping_mode(node:Node):GuiClippingMode;
    static function get_clipping_visible(node:Node):Bool;
    static function get_color(node:Node):Vector4;
    static function get_fill_angle(node:Node):Float;
    static function get_flipbook(node:Node):Hash;
    static function get_font(node:Node):Hash;
    static function get_height():Float;
    static function get_id(node:Node):Hash;
    static function get_index(node:Node):Float;
    static function get_inner_radius(node:Node):Float;
    static function get_layer(node:Node):Hash;
    static function get_layout():Hash;
    static function get_leading(node:Node):Float;
    static function get_line_break(node:Node):Bool;
    static function get_node(id:HashOrString):Node;
    static function get_outer_bounds(node:Node):GuiOuterBounds;
    static function get_outline(node:Node):Vector4;
    static function get_parent(node:Node):Null<Node>;
    static function get_perimeter_vertices():Int;
    static function get_pivot(node:Node):GuiPivot;
    static function get_position(node:Node):Vector3;
    static function get_rotation(node:Node):Vector3;
    static function get_scale(node:Node):Vector3;
    static function get_screen_position(node:Node):Vector3;
    static function get_shadow(node:Node):Vector4;
    static function get_size(node:Node):Vector3;
    static function get_size_mode(node:Node):GuiSizeMode;
    static function get_slice9(node:Node):Vector4;
    static function get_text(node:Node):String;
    static function get_text_metrics(font:HashOrString, text:String, ?width:Float, ?line_breaks:Bool, ?leading:Float, ?tracking:Float):GuiTextMetrics;
    static function get_text_metrics_from_node(node:Node):GuiTextMetrics;
    static function get_texture(node:Node):Hash;
    static function get_tracking(node:Node):Float;
    static function get_width():Float;
    static function get_xanchor(node:Node):GuiXAnchor;
    static function get_yanchor(node:Node):GuiYAnchor;
    static function hide_keyboard():Void;
    static function is_enabled(node:Node):Bool;
    static function move_above(node:Node, ref:Node):Void;
    static function move_below(node:Node, ref:Node):Void;
    static function new_box_node(pos:EitherType<Vector3,Vector4>, size:Vector3):Node;
    static function new_pie_node(pos:EitherType<Vector3,Vector4>, size:Vector3):Node;
    static function new_text_node(pos:EitherType<Vector3,Vector4>, text:String):Node;
    static function new_texture(texture:HashOrString, width:Float, height:Float, type:String, buffer:String):Bool;
    static function pick_node(node:Node, x:Float, y:Float):Bool;
    static function play_flipbook(node:Node, animation:HashOrString, complete_function:Void->Void):Void;
    static function reset_keyboard():Void;
    static function reset_nodes():Void;
    static function set_adjust_mode(node:Node, adjust_mode:GuiAdjustMode):Void;
    static function set_blend_mode(node:Node, blend_mode:GuiBlendMode):Void;
    static function set_clipping_inverted(node:Node, visible:Bool):Void;
    static function set_clipping_mode(node:Node, clipping_mode:GuiClippingMode):Void;
    static function set_clipping_visible(node:Node, visible:Bool):Void;
    static function set_color(node:Node, color:EitherType<Vector3,Vector4>):Void;
    static function set_enabled(node:Node, enabled:Bool):Void;
    static function set_fill_angle(node:Node, angle:Float):Void;
    static function set_font(node:Node, font:HashOrString):Void;
    static function set_id(node:Node, id:HashOrString):Void;
    static function set_inner_radius(node:Node, inner:Float):Void;
    static function set_layer(node:Node, layer:HashOrString):Void;
    static function set_leading(node:Node, leading:Float):Void;
    static function set_line_break(node:Node, text:String):Void;
    static function set_outer_bounds(node:Node, bounds:GuiOuterBounds):Void;
    static function set_outline(node:Node, color:EitherType<Vector3,Vector4>):Void;
    static function set_parent(node:Node, parent:Node):Void;
    static function set_perimeter_vertices(vertex:Int):Void;
    static function set_pivot(node:Node, pivot:GuiPivot):Void;
    static function set_position(node:Node, position:EitherType<Vector3,Vector4>):Void;
    static function set_render_order(order:Float):Void;
    static function set_rotation(node:Node, rotation:EitherType<Vector3,Vector4>):Void;
    static function set_scale(node:Node, scale:EitherType<Vector3,Vector4>):Void;
    static function set_shadow(node:Node, color:EitherType<Vector3,Vector4>):Void;
    static function set_size(node:Node, size:EitherType<Vector3,Vector4>):Void;
    static function set_size_mode(node:Node, size_mode:GuiSizeMode):Void;
    static function set_slice9(node:Node, params:Vector4):Void;
    static function set_text(node:Node, text:String):Void;
    static function set_texture(node:Node, texture:HashOrString):Void;
    static function set_texture_data(texture:HashOrString, width:Float, height:Float, type:String, buffer:String):Bool;
    static function set_tracking(node:Node, tracking:Float):Void;
    static function set_xanchor(node:Node, anchor:GuiXAnchor):Void;
    static function set_yanchor(node:Node, anchor:GuiYAnchor):Void;
    static function show_keyboard(type:GuiKeyboardType, autoclose:Bool):Void;
}

@:native("gui")
@:enum extern abstract GuiPlayback({}) {

}

@:native("gui")
@:enum extern abstract GuiAdjustMode({}) {
    var ADJUST_FIT;
    var ADJUST_ZOOM;
    var ADJUST_STRETCH;
}

@:native("gui")
@:enum extern abstract GuiBlendMode({}) {
    var BLEND_ALPHA;
    var BLEND_ADD;
    var BLEND_ADD_ALPHA;
    var BLEND_MULT;
}

@:native("gui")
@:enum extern abstract GuiClippingMode({}) {
    var CLIPPING_MODE_NONE;
    var CLIPPING_MODE_STENCIL;
}

@:native("gui")
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

@:native("gui")
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

@:native("gui")
@:enum extern abstract GuiXAnchor({}) {
    var ANCHOR_NONE;
    var ANCHOR_LEFT;
    var ANCHOR_RIGHT;
}

@:native("gui")
@:enum extern abstract GuiYAnchor({}) {
    var ANCHOR_NONE;
    var ANCHOR_TOP;
    var ANCHOR_BOTTOM;
}

@:native("gui")
@:enum extern abstract GuiOuterBounds({}) {
    var BOUNDS_RECTANGLE;
    var BOUNDS_ELLIPSE;
}

@:native("gui")
@:enum extern abstract GuiKeyboardType({}) {
    var KEYBOARD_TYPE_DEFAULT;
    var KEYBOARD_TYPE_EMAIL;
    var KEYBOARD_TYPE_NUMBER_PAD;
    var KEYBOARD_TYPE_PASSWORD;
}

@:native("gui")
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
