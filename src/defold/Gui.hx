package defold;

import haxe.extern.EitherType;
import defold.types.*;
import defold.Go.GoAnimatedProperty;
import defold.Particlefx.ParticlefxEmitterState;

/**
    GUI core hooks, functions, messages, properties and constants for
    creation and manipulation of GUI nodes. The "gui" namespace is
    accessible only from gui scripts.

    See `GuiMessages` for related messages.
**/
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

    /**
        Animates a node property.

        This starts an animation of a node property according to the specified parameters. If the node property is already being
        animated, that animation will be canceled and replaced by the new one. Note however that several different node properties
        can be animated simultaneously. Use `gui.cancel_animation` to stop the animation before it has completed.

        Composite properties of type vector3, vector4 or quaternion also expose their sub-components (x, y, z and w).
        You can address the components individually by suffixing the name with a dot '.' and the name of the component.
        For instance, "position.x" (the position x coordinate) or "color.w" (the color alpha value).

        If a `complete_function` is specified, that function will be called when the animation has completed.
        By starting a new animation in that function, several animations can be sequenced together. See the examples for more information.

        @param node node to animate
        @param property property to animate (one of PROP_* constant)
        @param to target property value
        @param easing easing to use during animation.
        @param duration duration of the animation in seconds.
        @param delay delay before the animation starts in seconds.
        @param complete_function function to call when the animation has completed
        @param playback playback mode
    **/
    static function animate<T>(node:GuiNode, property:String, to:GoAnimatedProperty, easing:EitherType<GuiEasing,EitherType<Vector3,Vector4>>, duration:Float, ?delay:Float, ?complete_function:T->GuiNode->Void, ?playback:GuiPlayback):Void;

    /**
        Cancels an ongoing animation.

        If an animation of the specified node is currently running (started by `gui.animate`), it will immediately be canceled.

        @param node node that should have its animation canceled
        @param property property for which the animation should be canceled
    **/
    static function cancel_animation(node:GuiNode, property:String):Void;

    /**
        Cancel a node flipbook animation.

        Cancels any running flipbook animation on the specified node.

        @param node node cancel flipbook animation for
    **/
    static function cancel_flipbook(node:GuiNode):Void;

    /**
        Cancel a spine animation.

        @param node spine node that should cancel its animation
    **/
    static function cancel_spine(node:GuiNode):Void;

    /**
        Clone a node.

        This does not include its children. Use `Gui.clone_tree` for that purpose.

        @param node node to clone
        @return the cloned node
    **/
    static function clone(node:GuiNode):GuiNode;

    /**
        Clone a node including its children.

        Use `Gui.clone` to clone a node excluding its children.

        @param node root node to clone
        @return a table mapping node ids to the corresponding cloned nodes
    **/
    static function clone_tree(node:GuiNode):lua.Table<Hash,GuiNode>;

    /**
        Deletes a node.

        Deletes the specified node. Any child nodes of the specified node will be
        recursively deleted.

        @param node node to delete
    **/
    static function delete_node(node:GuiNode):Void;

    /**
        Delete a dynamically created texture.

        @param texture texture id
    **/
    static function delete_texture(texture:HashOrString):Void;

    /**
        Gets the node adjust mode.

        Adjust mode defines how the node will adjust itself to a screen resolution which differs from the project settings.

        @param node node from which to get the adjust mode
        @return node adjust mode
    **/
    static function get_adjust_mode(node:GuiNode):GuiAdjustMode;

    /**
        Gets the node blend mode.

        Blend mode defines how the node will be blended with the background.

        @param node node from which to get the blend mode
        @return node blend mode
    **/
    static function get_blend_mode(node:GuiNode):GuiBlendMode;

    /**
        Gets node clipping inverted state.

        If node is set as an inverted clipping node, it will clip anything inside as opposed to outside.

        @param node node from which to get the clipping inverted state
        @return true or false
    **/
    static function get_clipping_inverted(node:GuiNode):Bool;

    /**
        Gets the node clipping mode.

        Clipping mode defines how the node will clipping it's children nodes

        @param node node from which to get the clipping mode
        @return node clipping mode
    **/
    static function get_clipping_mode(node:GuiNode):GuiClippingMode;

    /**
        Gets node clipping visibility state.

        If node is set as visible clipping node, it will be shown as well as clipping. Otherwise, it will only clip but not show visually.

        @param node node from which to get the clipping visibility state
        @return true or false
    **/
    static function get_clipping_visible(node:GuiNode):Bool;

    /**
        Gets the node color.

        @param node node to get the color from
        @return node color
    **/
    static function get_color(node:GuiNode):Vector4;

    /**
        Gets the angle for the filled pie sector.

        @param node node from which to get the fill angle
        @return sector angle
    **/
    static function get_fill_angle(node:GuiNode):Float;

    /**
        Get node flipbook animation.

        @param node node to get flipbook animation from
        @return animation animation id
    **/
    static function get_flipbook(node:GuiNode):Hash;

    /**
        Gets the normalized cursor of the animation on a node with flipbook animation.

        This is only useful nodes with flipbook animations. Gets the normalized cursor of the flipbook animation on a node.

        @param node node to get the cursor for
        @return cursor value
    **/
    static function get_flipbook_cursor(node:GuiNode):Float;

    /**
        Gets the playback rate of the flipbook animation on a node.

        This is only useful nodes with flipbook animations. Gets the playback rate of the flipbook animation on a node.

        @param node node to set the cursor for
        @return playback rate
    **/
    static function get_flipbook_playback_rate(node:GuiNode):Float;

    /**
        Gets the node font.

        This is only useful for text nodes. The font must be mapped to the gui scene in the gui editor.

        @param node node from which to get the font
        @return font id
    **/
    static function get_font(node:GuiNode):Hash;

    /**
        Gets the scene height.

        @return scene height
    **/
    static function get_height():Float;

    /**
        Gets the id of the specified node.

        @param node node to retrieve the id from
        @return id of the node
    **/
    static function get_id(node:GuiNode):Hash;

    /**
        Gets the node inherit alpha state.

        @param node node from which to get the inherit alpha state
    **/
    static function get_inherit_alpha(node:GuiNode):Bool;

    /**
        Gets the index of the specified node.

        The index defines the order in which a node appear in a GUI scene.
        Higher index means the node is drawn on top of lower indexed nodes.

        @param node node to retrieve the id from
        @return id of the node
    **/
    static function get_index(node:GuiNode):Float;

    /**
        Gets the node alpha.

        @param node node from which to get alpha
        @return 0..1 alpha color
    **/
    static function get_alpha(node:GuiNode):Float;

    /**
        Sets the node alpha.

        @param node node on which to set alpha
        @param alpha 0..1 alpha color
    **/
    static function set_alpha(node:GuiNode, alpha:Float):Void;

    /**
        Gets the pie inner radius (defined along the x dimension).

        @param node node from where to get the inner radius
        @return inner radius
    **/
    static function get_inner_radius(node:GuiNode):Float;

    /**
        Gets the node layer.

        The layer must be mapped to the gui scene in the gui editor.

        @param node node from which to get the layer
        @return layer id
    **/
    static function get_layer(node:GuiNode):Hash;

    /**
        Gets the scene current layout.

        @return layout id
    **/
    static function get_layout():Hash;

    /**
        Gets the leading of the text node.

        @param node node from where to get the leading
        @return scaling number (default=1)
    **/
    static function get_leading(node:GuiNode):Float;

    /**
        Get line-break mode..

        This is only useful for text nodes.

        @param node node from which to get the line-break for
        @return line_break
    **/
    static function get_line_break(node:GuiNode):Bool;

    /**
        Gets the node with the specified id.

        @param id id of the node to retrieve
        @return node instance
    **/
    static function get_node(id:HashOrString):GuiNode;

    /**
        Gets the pie outer bounds mode.

        @param node node from where to get the outer bounds mode (node)
        @return PIEBOUNDS_RECTANGLE or PIEBOUNDS_ELLIPSE
    **/
    static function get_outer_bounds(node:GuiNode):GuiPieBounds;

    /**
        Gets the node outline color.

        @param node node to get the outline color from
        @return node outline color
    **/
    static function get_outline(node:GuiNode):Vector4;

    /**
        Gets the parent of the specified node.

        If the specified node does not have a parent, null is returned.

        @param node the node from which to retrieve its parent
        @return parent instance
    **/
    static function get_parent(node:GuiNode):Null<GuiNode>;

    /**
        Get the paricle fx for a gui node

        @param node node to get particle fx for
        @return particle fx id
    **/
    static function get_particlefx(node:GuiNode):Hash;

    /**
        Gets the number of generated vertices around the perimeter.

        @return vertex count
    **/
    static function get_perimeter_vertices():Int;

    /**
        Gets the pivot of a node.

        The pivot specifies how the node is drawn and rotated from its position.

        @param node node to get pivot from
        @return pivot constant
    **/
    static function get_pivot(node:GuiNode):GuiPivot;

    /**
        Gets the node position.

        @param node node to get the position from
        @return node position
    **/
    static function get_position(node:GuiNode):Vector3;

    /**
        Gets the node rotation.

        @param node node to get the rotation from
        @return node rotation
    **/
    static function get_rotation(node:GuiNode):Vector3;

    /**
        Gets the node scale.

        @param node node to get the scale from
        @return node scale
    **/
    static function get_scale(node:GuiNode):Vector3;

    /**
        Returns the screen position of the supplied node. This function returns the
        calculated transformed position of the node, taking into account any parent node
        transforms.

        @param node node to get the screen position from
        @return node screen position
    **/
    static function get_screen_position(node:GuiNode):Vector3;

    /**
        Set the screen position to the supplied node.

        @param node node to set the screen position to
        @return screen position
    **/
    static function set_screen_position(node:GuiNode, screen_position:Vector3):Void;

    /**
        Convert the screen position to the local position of supplied node.

        @param node node used for getting local transformation matrix
        @param screen_position screen position
        @return local position
    **/
    static function screen_to_local(node:GuiNode, screen_position:Vector3):Vector3;

    /**
        Gets the node shadow color.

        @param node node to get the shadow color from
        @return node shadow color
    **/
    static function get_shadow(node:GuiNode):Vector4;

    /**
        Gets the node size.

        @param node node to get the size from
        @return node size
    **/
    static function get_size(node:GuiNode):Vector3;

    /**
        Gets the node size mode.

        Size mode defines how the node will adjust itself in size according to mode.

        @param node node from which to get the size mode
        @return node size mode
    **/
    static function get_size_mode(node:GuiNode):GuiSizeMode;

    /**
        Get the slice9 values for the node.

        @param node node to manipulate
        @return configuration values
    **/
    static function get_slice9(node:GuiNode):Vector4;

    /**
        Gets the node text.

        This is only useful for text nodes.

        @param node node from which to get the text
        @return text value
    **/
    static function get_text(node:GuiNode):String;

    /**
        Get text metrics

        @param font font id
        @param text text to measure
        @param width max-width. use for line-breaks (default=FLT_MAX)
        @param line_break true to break lines accordingly to width (default=false)
        @param leading scale value for line spacing (default=1)
        @param tracking scale value for letter spacing (default=0)
    **/
    static function get_text_metrics(font:HashOrString, text:String, ?width:Float, ?line_break:Bool, ?leading:Float, ?tracking:Float):GuiTextMetrics;

    /**
        Get text metrics from node.

        @param node text node to measure text from
    **/
    static function get_text_metrics_from_node(node:GuiNode):GuiTextMetrics;

    /**
        Gets the node texture.

        This is currently only useful for box or pie nodes. The texture must be mapped to the gui scene in the gui editor.

        @param node node to get texture from
        @return texture id
    **/
    static function get_texture(node:GuiNode):Hash;

    /**
        Gets the tracking of the text node.

        @param node node from where to get the tracking
        @return scaling number (default=0)
    **/
    static function get_tracking(node:GuiNode):Float;

    /**
        Gets the scene width.

        @return scene width
    **/
    static function get_width():Float;

    /**
        Gets the x-anchor of a node.

        The x-anchor specifies how the node is moved when the game is run in a different resolution.

        @param node node to get x-anchor from
        @return anchor anchor constant
    **/
    static function get_xanchor(node:GuiNode):GuiXAnchor;

    /**
        Gets the y-anchor of a node.

        The y-anchor specifies how the node is moved when the game is run in a different resolution.

        @param node node to get y-anchor from
        @return anchor anchor constant
    **/
    static function get_yanchor(node:GuiNode):GuiYAnchor;

    /**
        Hide the on-display keyboard on the device.
    **/
    static function hide_keyboard():Void;

    /**
        Retrieves if a node is enabled or not.

        Disabled nodes are not rendered and animations acting on them are not evaluated.

        @param node node to query
        @return whether the node is enabled or not
    **/
    static function is_enabled(node:GuiNode):Bool;

    /**
        Moves the first node above the second.

        Supply null as the second argument to move the first node to the top.

        @param node to move
        @param ref reference node above which the first node should be moved
    **/
    static function move_above(node:GuiNode, ref:Null<GuiNode>):Void;

    /**
        Moves the first node below the second.

        Supply null as the second argument to move the first node to the bottom.

        @param node to move
        @param ref reference node below which the first node should be moved
    **/
    static function move_below(node:GuiNode, ref:Null<GuiNode>):Void;

    /**
        Creates a new box node.

        @param pos node position
        @param size node size
        @return new box node
    **/
    static function new_box_node(pos:EitherType<Vector3,Vector4>, size:Vector3):GuiNode;

    /**
        Dynamically create a particle fx node.

        @param pos node position
        @param particlefx particle fx resource name
        @return new particle fx node
    **/
    static function new_particlefx_node(pos:EitherType<Vector4,Vector3>, particlefx:HashOrString):GuiNode;

    /**
        Creates a new pie node.

        @param pos node position
        @param size node size
        @return new box node
    **/
    static function new_pie_node(pos:EitherType<Vector3,Vector4>, size:Vector3):GuiNode;

    /**
        Creates a new spine node.

        @param pos node position
        @param spine_scene spine scene id
        @return new spine node
    **/
    static function new_spine_node(pos:EitherType<Vector3,Vector4>, spine_scene:HashOrString):GuiNode;

    /**
        Creates a new text node.

        @param pos node position
        @param text node text
        @return new text node
    **/
    static function new_text_node(pos:EitherType<Vector3,Vector4>, text:String):GuiNode;

    /**
        Create new texture.

        Dynamically create a new texture.

        @param texture texture id
        @param width texture width
        @param height texture height
        @param type texture type
           * `"rgb"` - RGB
           * `"rgba"` - RGBA
           * `"l"` - LUMINANCE
        @param buffer texture data
        @param flip flip texture vertically
        @return texture creation was successful
    **/
    static function new_texture(texture:HashOrString, width:Float, height:Float, type:String, buffer:String, ?flip:Bool):GuiNewTextureResult;

    /**
        Determines if the node is pickable by the supplied coordinates.

        @param node node to be tested for picking
        @param x x-coordinate
        @param y y-coordinate
        @return pick result
    **/
    static function pick_node(node:GuiNode, x:Float, y:Float):Bool;

    /**
        Play node flipbook animation.

        Play flipbook animation on a box or pie node. The current node texture must contain the animation.

        @param node node to set animation for
        @param animation animation id
        @param complete_function function to call when the animation has completed
        @param play_properties optional table with properties
    **/
    static function play_flipbook(node:GuiNode, animation:HashOrString, ?complete_function:Void->Void, ?play_properties:GuiPlayFlipbookProperties):Void;

    /**
        Plays the paricle fx for a gui node

        @param node node to play particle fx for
        @param emitter_state_function optional callback function that will be called when an emitter attached to this particlefx changes state.
                                      callback arguments:
                                       * self The current object
                                       * id The id of the particle fx component
                                       * emitter The id of the emitter
                                       * state the new state of the emitter
    **/
    static function play_particlefx<T>(node:GuiNode, ?emitter_state_function:T->Hash->Hash->ParticlefxEmitterState->Void):Void;

    /**
        Play a spine animation.

        @param node spine node that should play the animation
        @param animation_id id of the animation to play
        @param playback playback mode
        @param play_properties optional table with properties
        @param complete_function function to call when the animation has completed
    **/
    static function play_spine_anim(node:GuiNode, animation_id:HashOrString, playback:GuiPlayback, ?play_properties:GuiPlaySpineProperties, ?complete_function:Void->Void):Void;

    /**
        Reset on-display keyboard if available.

        Reset input context of keyboard. This will clear marked text.
    **/
    static function reset_keyboard():Void;

    /**
        Reset all nodes to initial state.

        reset only applies to static node loaded from the scene. Nodes created dynamically from script are not affected
    **/
    static function reset_nodes():Void;

    /**
        Sets node adjust mode.

        Adjust mode defines how the node will adjust itself to a screen resolution which differs from the project settings.

        @param node node to set adjust mode for
        @param adjust_mode adjust mode to set
    **/
    static function set_adjust_mode(node:GuiNode, adjust_mode:GuiAdjustMode):Void;

    /**
        Sets node blend mode.

        Blend mode defines how the node will be blended with the background.

        @param node node to set blend mode for
        @param blend_mode blend mode to set
    **/
    static function set_blend_mode(node:GuiNode, blend_mode:GuiBlendMode):Void;

    /**
        Sets node clipping visibility.

        If node is set as an inverted clipping node, it will clip anything inside as opposed to outside.

        @param node node to set clipping inverted state for
        @param visible true or false
    **/
    static function set_clipping_inverted(node:GuiNode, visible:Bool):Void;

    /**
        Sets node clipping mode state.

        Clipping mode defines how the node will clipping it's children nodes

        @param node node to set clipping mode for
        @param clipping_mode clipping mode to set
    **/
    static function set_clipping_mode(node:GuiNode, clipping_mode:GuiClippingMode):Void;

    /**
        Sets node clipping visibility.

        If node is set as an visible clipping node, it will be shown as well as clipping. Otherwise, it will only clip but not show visually.

        @param node node to set clipping visibility for
        @param visible true or false
    **/
    static function set_clipping_visible(node:GuiNode, visible:Bool):Void;

    /**
        Sets the node color.

        @param node node to set the color for
        @param color new color
    **/
    static function set_color(node:GuiNode, color:EitherType<Vector3,Vector4>):Void;

    /**
        Enables/disables a node.

        Disabled nodes are not rendered and animations acting on them are not evaluated.

        @param node node to be enabled/disabled
        @param enabled whether the node should be enabled or not
    **/
    static function set_enabled(node:GuiNode, enabled:Bool):Void;

    /**
        Sets the angle for the filled pie sector.

        @param node node to set the fill angle for
        @param sector angle
    **/
    static function set_fill_angle(node:GuiNode, angle:Float):Void;

    /**
        Sets the normalized cursor of the animation on a node with flipbook animation.

        This is only useful nodes with flipbook animations. The cursor is normalized.

        @param node node to set the cursor for
        @param cursor cursor value
    **/
    static function set_flipbook_cursor(node:GuiNode, cursor:Float):Void;

    /**
        Sets the playback rate of the flipbook animation on a node.

        This is only useful nodes with flipbook animations. Sets the playback rate of the flipbook animation on a node. Must be positive.

        @param node node to set the cursor for
        @param playback_rate playback rate
    **/
    static function set_flipbook_playback_rate(node:GuiNode, playback_rate:Float):Void;

    /**
        Sets the node font.

        This is only useful for text nodes. The font must be mapped to the gui scene in the gui editor.

        @param node node for which to set the font
        @param font font id
    **/
    static function set_font(node:GuiNode, font:HashOrString):Void;

    /**
        Sets the id of the specified node.

        Nodes created with the `Gui.new_*_node()` functions get
        an empty id. This function allows you to give dynamically
        created nodes an id.

        No checking is done on the uniqueness of supplied ids.
        It is up to you to make sure you use unique ids.

        @param node node to set the id for
        @param id id to set
    **/
    static function set_id(node:GuiNode, id:HashOrString):Void;

    /**
        Sets the node inherit alpha state.

        @param node node from which to set the inherit alpha state
        @param inherit_alpha true or false
    **/
    static function set_inherit_alpha(node:GuiNode, inherit_alpha:Bool):Void;

    /**
        Sets the pie inner radius (defined along the x dimension).

        @param node node to set the inner radius for
        @param inner radius
    **/
    static function set_inner_radius(node:GuiNode, inner:Float):Void;

    /**
        Sets the node layer.

        The layer must be mapped to the gui scene in the gui editor.

        @param node node for which to set the layer
        @param layer layer id
    **/
    static function set_layer(node:GuiNode, layer:HashOrString):Void;

    /**
        Sets the leading of the text node.

        @param node node for which to set the leading
        @param leading a scaling number for the line spacing (default=1)
    **/
    static function set_leading(node:GuiNode, leading:Float):Void;

    /**
        Set line-break mode.

        This is only useful for text nodes.

        @param node node to set line-break for
        @param line_break true or false
    **/
    static function set_line_break(node:GuiNode, line_break:Bool):Void;

    /**
        Sets the pie outer bounds mode.

        @param node node for which to set the outer bounds mode
        @param bounds PIEBOUNDS_RECTANGLE or PIEBOUNDS_ELLIPSE
    **/
    static function set_outer_bounds(node:GuiNode, bounds:GuiPieBounds):Void;

    /**
        Sets the node outline color.

        @param node node to set the outline color for
        @param color new outline color
    **/
    static function set_outline(node:GuiNode, color:EitherType<Vector3,Vector4>):Void;

    /**
        Set the parent of the node.

        @param node node for which to set its parent
        @param parent parent node to set
        @param keep_scene_transform optional flag to make the scene position being perserved
    **/
    static function set_parent(node:GuiNode, parent:GuiNode, ?keep_scene_transform:Bool):Void;

    /**
        Set the paricle fx for a gui node

        @param node node to set particle fx for
        @param particlefx particle fx id
    **/
    static function set_particlefx(node:GuiNode, particlefx:HashOrString):Void;

    /**
        Sets the number of generarted vertices around the perimeter.

        @param vertex count
    **/
    static function set_perimeter_vertices(vertex:Int):Void;

    /**
        Sets the pivot of a node.

        The pivot specifies how the node is drawn and rotated from its position.

        @param node node to set pivot for
        @param pivot pivot constant
    **/
    static function set_pivot(node:GuiNode, pivot:GuiPivot):Void;

    /**
        Sets the node position.

        @param node node to set the position for
        @param position new position
    **/
    static function set_position(node:GuiNode, position:EitherType<Vector3,Vector4>):Void;

    /**
        Set the order number for the current GUI scene. The number dictates the sorting of the "gui" render predicate, in other words
        in which order the scene will be rendered in relation to other currently rendered GUI scenes.

        The number must be in the range 0 to 15.

        @param order rendering order
    **/
    static function set_render_order(order:Int):Void;

    /**
        Sets the node rotation.

        @param node node to set the rotation for
        @param rotation new rotation
    **/
    static function set_rotation(node:GuiNode, rotation:EitherType<Vector3,Vector4>):Void;

    /**
        Sets the node scale.

        @param node node to set the scale for
        @param scale new scale
    **/
    static function set_scale(node:GuiNode, scale:EitherType<Vector3,Vector4>):Void;

    /**
        Sets the node shadow color.

        @param node node to set the shadow color for
        @param color new shadow color
    **/
    static function set_shadow(node:GuiNode, color:EitherType<Vector3,Vector4>):Void;

    /**
        Sets the node size.

        *NOTE!* You can only set size on nodes with size mode set to SIZE_MODE_MANUAL

        @param node node to set the size for
        @param size new size
    **/
    static function set_size(node:GuiNode, size:EitherType<Vector3,Vector4>):Void;

    /**
        Sets node size mode.

        Size mode defines how the node will adjust itself in size according to mode.

        @param node node to set size mode for
        @param size_mode size mode to set
    **/
    static function set_size_mode(node:GuiNode, size_mode:GuiSizeMode):Void;

    /**
        Set the slice9 configuration for the node.

        @param node node to manipulate
        @param params new value
    **/
    static function set_slice9(node:GuiNode, params:Vector4):Void;

    /**
        Sets the normalized cursor of the animation on a spine node.

        This is only useful for spine nodes. The cursor is normalized.

        @param node spine node to set the cursor for (node)
        @param cursor cursor value (number)
    **/
    static function set_spine_cursor(node:GuiNode, cursor:Float):Void;

    /**
        Sets the playback rate of the animation on a spine node.

        This is only useful for spine nodes. Sets the playback rate of the animation on a spine node. Must be positive.

        @param node spine node to set the cursor for
        @param playback_rate playback rate
    **/
    static function set_spine_playback_rate(node:GuiNode, playback_rate:Float):Void;

    /**
        Sets the spine scene of a node.

        Set the spine scene on a spine node. The spine scene must be mapped to the gui scene in the gui editor.

        @param node node to set spine scene for
        @param spine_scene spine scene id
    **/
    static function set_spine_scene(node:GuiNode, spine_scene:HashOrString):Void;

    /**
        Sets the spine skin on a spine node.

        @param node node to set the spine skin on
        @param spine_skin spine skin id
        @param spine_slot optional slot id to only change a specific slot
    **/
    static function set_spine_skin(node:GuiNode, spine_skin:HashOrString, ?spine_slot:HashOrString):Void;

    /**
        Sets the node text.

        This is only useful for text nodes.

        @param node node to set text for
        @param text text to set
    **/
    static function set_text(node:GuiNode, text:String):Void;

    /**
        Sets the node texture.

        Set the texture on a box or pie node. The texture must be mapped to the gui scene in the gui editor.

        @param node node to set texture for
        @param texture texture id
    **/
    static function set_texture(node:GuiNode, texture:HashOrString):Void;

    /**
        Set the buffer data for a texture.

        Set the texture buffer data for a dynamically created texture.

        @param texture texture id
        @param width texture width
        @param height texture height
        @param type texture type
           * `"rgb"` - RGB
           * `"rgba"` - RGBA
           * `"l"` - LUMINANCE
        @param buffer texture data
        @param flip flip texture vertically
        @return setting the data was successful
    **/
    static function set_texture_data(texture:HashOrString, width:Float, height:Float, type:String, buffer:String, ?flip:Bool):Bool;

    /**
        Sets the tracking of the text node.

        @param node node for which to set the tracking
        @param tracking a scaling number for the letter spacing (default=0)
    **/
    static function set_tracking(node:GuiNode, tracking:Float):Void;

    /**
        Sets the x-anchor of a node.

        The x-anchor specifies how the node is moved when the game is run in a different resolution.

        @param node node to set x-anchor for
        @param anchor anchor constant
    **/
    static function set_xanchor(node:GuiNode, anchor:GuiXAnchor):Void;

    /**
        Sets the y-anchor of a node.

        The y-anchor specifies how the node is moved when the game is run in a different resolution.

        @param node node to set y-anchor for
        @param anchor anchor constant
    **/
    static function set_yanchor(node:GuiNode, anchor:GuiYAnchor):Void;

    /**
        Shows the on-display keyboard if available.

        The specified type of keyboard is displayed, if it is available on
        the device.

        This function is only available on iOS and Android.

        @param type keyboard type
        @param autoclose close keyboard automatically when clicking outside
    **/
    static function show_keyboard(type:GuiKeyboardType, autoclose:Bool):Void;

    /**
        Stops the particle fx for a gui node

        @param node node to stop particle fx for
    **/
    static function stop_particlefx(node:GuiNode):Void;
}

/**
    Messages related to the `Gui` module.
**/
@:publicFields
class GuiMessages {
    /**
        Reports a layout change.

        This message is broadcast to every GUI component when a layout change has been initiated
        on device.
    **/
    static var layout_changed(default, never) = new Message<GuiMessageLayoutChanged>("layout_changed");
}

/**
    Data for the `GuiMessages.layout_changed` message.
**/
typedef GuiMessageLayoutChanged = {
    /**
        the id of the layout the engine is changing to
    **/
    var id:Hash;

    /**
        the id of the layout the engine is changing from
    **/
    var previous_id:Hash;
}

/**
    An instance of a GUI node.
**/
extern class GuiNode {}

/**
    Possible GUI playback modes.
**/
@:native("_G.gui")
@:enum extern abstract GuiPlayback({}) {
    /**
        Loop backward.
    **/
    var PLAYBACK_LOOP_BACKWARD;

    /**
        Loop forward.
    **/
    var PLAYBACK_LOOP_FORWARD;

    /**
        Ping pong loop.
    **/
    var PLAYBACK_LOOP_PINGPONG;

    /**
        Once backward.
    **/
    var PLAYBACK_ONCE_BACKWARD;

    /**
        Once forward.
    **/
    var PLAYBACK_ONCE_FORWARD;

    /**
        Once forward and then backward.
    **/
    var PLAYBACK_ONCE_PINGPONG;
}

/**
    Enumeration of possible adjust modes of a gui node.

    Adjust mode defines how the node will adjust itself
    to a screen resolution which differs from the project settings.
**/
@:native("_G.gui")
@:enum extern abstract GuiAdjustMode(Int) {
    /**
        Fit adjust mode.

        Adjust mode is used when the screen resolution differs from the project settings.
        The fit mode ensures that the entire node is visible in the adjusted gui scene.
    **/
    var ADJUST_FIT;

    /**
        Stretch adjust mode.

        Adjust mode is used when the screen resolution differs from the project settings.
        The stretch mode ensures that the node is displayed as is in the adjusted gui scene, which might scale it non-uniformally.
    **/
    var ADJUST_STRETCH;

    /**
        Zoom adjust mode.

        Adjust mode is used when the screen resolution differs from the project settings.
        The zoom mode ensures that the node fills its entire area and might make the node exceed it.
    **/
    var ADJUST_ZOOM;
}

/**
    Enumeration of possible blend modes of a gui node.

    Blend mode defines how the node will be blended with the background.
**/
@:native("_G.gui")
@:enum extern abstract GuiBlendMode({}) {
    /**
        Alpha blending.
    **/
    var BLEND_ALPHA;

    /**
        Additive blending.
    **/
    var BLEND_ADD;

    /**
        Additive alpha blending.
    **/
    var BLEND_ADD_ALPHA;

    /**
        Multiply blending.
    **/
    var BLEND_MULT;
}

/**
    Possible clipping modes.
    Clipping mode defines how the node will clipping it's children nodes
**/
@:native("_G.gui")
@:enum extern abstract GuiClippingMode(Int) {
    /**
        Clipping mode none.
    **/
    var CLIPPING_MODE_NONE;

    /**
        Clipping mode stencil.
    **/
    var CLIPPING_MODE_STENCIL;
}

/**
    Possible node pivots.
**/
@:native("_G.gui")
@:enum extern abstract GuiPivot(Int) {
    /**
        Center pivor.
    **/
    var PIVOT_CENTER;

    /**
        North pivot.
    **/
    var PIVOT_N;

    /**
        North-east pivot.
    **/
    var PIVOT_NE;

    /**
        East pivot.
    **/
    var PIVOT_E;

    /**
        South-east pivot.
    **/
    var PIVOT_SE;

    /**
        South pivot.
    **/
    var PIVOT_S;

    /**
        South-west pivot.
    **/
    var PIVOT_SW;

    /**
        West pivot.
    **/
    var PIVOT_W;

    /**
        North-west pivot.
    **/
    var PIVOT_NW;
}

/**
    Possible node size modes.
**/
@:native("_G.gui")
@:enum extern abstract GuiSizeMode(Int) {
    /**
        Automatic size mode

        The size of the node is determined by the currently assigned texture.
    **/
    var SIZE_MODE_AUTO;

    /**
        Manual size mode

        The size of the node is determined by the size set in the editor, the constructor or by `Gui.set_size`.
    **/
    var SIZE_MODE_MANUAL;
}

typedef GuiTextMetrics = {
    var width:Float;
    var height:Float;
    var max_ascent:Float;
    var max_descent:Float;
}

@:native("_G.gui")
@:enum extern abstract GuiXAnchor(Int) {
    /**
        No anchor.
    **/
    var ANCHOR_NONE;

    /**
        Left x-anchor.
    **/
    var ANCHOR_LEFT;

    /**
        Right x-anchor.
    **/
    var ANCHOR_RIGHT;
}

@:native("_G.gui")
@:enum extern abstract GuiYAnchor(Int) {
    /**
        No anchor.
    **/
    var ANCHOR_NONE;

    /**
        Top y-anchor.
    **/
    var ANCHOR_TOP;

    /**
        Bottom y-anchor.
    **/
    var ANCHOR_BOTTOM;
}

/**
    Possible pie bounds.
**/
@:native("_G.gui")
@:enum extern abstract GuiPieBounds({}) {
    /**
        Elliptical pie node bounds.
    **/
    var PIEBOUNDS_ELLIPSE;

    /**
        Rectangular pie node bounds.
    **/
    var PIEBOUNDS_RECTANGLE;
}

@:native("_G.gui")
@:enum extern abstract GuiKeyboardType({}) {
    /**
        Default keyboard.
    **/
    var KEYBOARD_TYPE_DEFAULT;

    /**
        Email keyboard.
    **/
    var KEYBOARD_TYPE_EMAIL;

    /**
        Number input keyboard.
    **/
    var KEYBOARD_TYPE_NUMBER_PAD;

    /**
        Password keyboard.
    **/
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

@:native("_G.gui")
@:enum extern abstract GuiNewTextureResultCode({}) {
    /**
        The texture id already exists when trying to use `gui.new_texture()`.
    **/
    var RESULT_TEXTURE_ALREADY_EXISTS;
    /**
        The system is out of resources, for instance when trying to create a new texture using `gui.new_texture()`.
    **/
    var RESULT_OUT_OF_RESOURCES;
    /**
        The provided data is not in the expected format or is in some other way incorrect, for instance the image data provided to `gui.new_texture()`.
    **/
    var RESULT_DATA_ERROR;
}

/**
    Data for the `play_properties` argument of `Gui.play_spine_anim` method.
**/
typedef GuiPlaySpineProperties = {
    /**
        Duration of a linear blend between the current and new animation.
    **/
    var blend_duration:Float;

    /**
        The normalized initial value of the animation cursor when the animation starts playing.
    **/
    var offset:Float;

    /**
        The rate with which the animation will be played. Must be positive.
    **/
    var playback_rate:Float;
}

/**
    Data for the `play_properties` argument of `Gui.play_flipbook` method.
**/
typedef GuiPlayFlipbookProperties = {
    /**
        The normalized initial value of the animation cursor when the animation starts playing
    **/
    var offset:Float;

    /**
        The rate with which the animation will be played. Must be positive.
    **/
    var playback_rate:Float;
}

/**
    A type for returning multiple values from the `Gui.new_texture` method.
**/
@:multiReturn extern class GuiNewTextureResult {
    /**
        texture creation was successful
    **/
    var success:Bool;

    /**
        one of the `GuiNewTextureResultCode` codes if unsuccessful
    **/
    var code:GuiNewTextureResultCode;
}
