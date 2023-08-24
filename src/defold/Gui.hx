package defold;

import defold.Image.ImageType;
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
extern final class Gui
{
    /**
        Animates a node property.

        This starts an animation of a node property according to the specified parameters. If the node property is already being
        animated, that animation will be canceled and replaced by the new one. Note however that several different node properties
        can be animated simultaneously. Use `gui.cancel_animation` to stop the animation before it has completed.

        Composite properties of type vector3, vector4 or quaternion also expose their sub-components (x, y, z and w).
        You can address the components individually by suffixing the name with a dot '.' and the name of the component.
        For instance, "position.x" (the position x coordinate) or "color.w" (the color alpha value).

        If a `completeFunction` is specified, that function will be called when the animation has completed.
        By starting a new animation in that function, several animations can be sequenced together. See the examples for more information.

        @param node node to animate
        @param property property to animate (one of PROP_* constant)
        @param to target property value
        @param easing easing to use during animation.
        @param duration duration of the animation in seconds.
        @param delay delay before the animation starts in seconds.
        @param completeFunction function to call when the animation has completed
        @param playback playback mode
    **/
    static inline function animate(node:GuiNode, property:GuiAnimateProprty, to:GoAnimatedProperty, easing:EitherType<GuiEasing,Vector>, duration:Float, ?delay:Float, ?completeFunction:GuiNode->Void, ?playback:GuiPlayback):Void
    {
        // 1. hide the reall callback parameter which expects a function with a "self" argument
        // 2. ensure that the global self reference is present for the callback
        animate_(node, property, to, easing, duration, delay, completeFunction == null ? null : (self, node) ->
        {
            untyped __lua__('_G._hxdefold_self_ = {0}', self);
            completeFunction(node);
            untyped __lua__('_G._hxdefold_self_ = nil');
        }, playback);
    }
    @:native('animate') private static function animate_(node:GuiNode, property:GuiAnimateProprty, to:GoAnimatedProperty, easing:EitherType<GuiEasing,Vector>, duration:Float, ?delay:Float, ?completeFunction:(Any, GuiNode)->Void, ?playback:GuiPlayback):Void;

    /**
        Cancels an ongoing animation.

        If an animation of the specified node is currently running (started by `gui.animate`), it will immediately be canceled.

        @param node node that should have its animation canceled
        @param property property for which the animation should be canceled
    **/
    @:native('cancel_animation')
    static function cancelAnimation(node:GuiNode, property:String):Void;

    /**
        Cancel a node flipbook animation.

        Cancels any running flipbook animation on the specified node.

        @param node node cancel flipbook animation for
    **/
    @:native('cancel_flipbook')
    static function cancelFlipbook(node:GuiNode):Void;

    /**
        Cancel a spine animation.

        @param node spine node that should cancel its animation
    **/
    @:native('cancel_spine')
    static function cancelSpine(node:GuiNode):Void;

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
    @:native('clone_tree')
    static function cloneTree(node:GuiNode):lua.Table<Hash,GuiNode>;

    /**
        Get a node and all its children as a Lua table.

        @param node root node to get node tree from
        @return a table mapping node ids to the corresponding nodes
    **/
    @:pure
    @:native('get_tree')
    static function getTree(node:GuiNode):lua.Table<Hash,GuiNode>;

    /**
        Deletes a node.

        Deletes the specified node. Any child nodes of the specified node will be
        recursively deleted.

        @param node node to delete
    **/
    @:native('delete_node')
    static function deleteNode(node:GuiNode):Void;

    /**
        Delete a dynamically created texture.

        @param texture texture id
    **/
    @:native('delete_texture')
    static function deleteTexture(texture:HashOrString):Void;

    /**
        Returns true if a node is visible and false if it's not. Invisible nodes are not rendered.

        @param node node to query
        @return whether the node is visible
    **/
    @:pure
    @:native('get_visible')
    static function getVisible(node:GuiNode):Bool;

    /**
        Set if a node should be visible or not. Only visible nodes are rendered.

        @param node node to be visible or no
        @param visible whether the node should be visible or not
    **/
    @:native('set_visible')
    static function setVisible(node:GuiNode, visible:Bool):Void;

    /**
        Gets the node adjust mode.

        Adjust mode defines how the node will adjust itself to a screen resolution which differs from the project settings.

        @param node node from which to get the adjust mode
        @return node adjust mode
    **/
    @:pure
    @:native('get_adjust_mode')
    static function getAdjustMode(node:GuiNode):GuiAdjustMode;

    /**
        Gets the node blend mode.

        Blend mode defines how the node will be blended with the background.

        @param node node from which to get the blend mode
        @return node blend mode
    **/
    @:pure
    @:native('get_blend_mode')
    static function getBlendMode(node:GuiNode):GuiBlendMode;

    /**
        Gets node clipping inverted state.

        If node is set as an inverted clipping node, it will clip anything inside as opposed to outside.

        @param node node from which to get the clipping inverted state
        @return true or false
    **/
    @:pure
    @:native('get_clipping_inverted')
    static function getClippingInverted(node:GuiNode):Bool;

    /**
        Gets the node clipping mode.

        Clipping mode defines how the node will clipping it's children nodes

        @param node node from which to get the clipping mode
        @return node clipping mode
    **/
    @:pure
    @:native('get_clipping_mode')
    static function getClippingMode(node:GuiNode):GuiClippingMode;

    /**
        Gets node clipping visibility state.

        If node is set as visible clipping node, it will be shown as well as clipping. Otherwise, it will only clip but not show visually.

        @param node node from which to get the clipping visibility state
        @return true or false
    **/
    @:pure
    @:native('get_clipping_visible')
    static function getClippingVisible(node:GuiNode):Bool;

    /**
        Gets the node color.

        @param node node to get the color from
        @return node color
    **/
    @:pure
    @:native('get_color')
    static function getColor(node:GuiNode):Vector4;

    /**
        Gets the angle for the filled pie sector.

        @param node node from which to get the fill angle
        @return sector angle
    **/
    @:pure
    @:native('get_fill_angle')
    static function getFillAngle(node:GuiNode):Float;

    /**
        Get node flipbook animation.

        @param node node to get flipbook animation from
        @return animation animation id
    **/
    @:pure
    @:native('get_flipbook')
    static function getFlipbook(node:GuiNode):Hash;

    /**
        Gets the normalized cursor of the animation on a node with flipbook animation.

        This is only useful nodes with flipbook animations. Gets the normalized cursor of the flipbook animation on a node.

        @param node node to get the cursor for
        @return cursor value
    **/
    @:pure
    @:native('get_flipbook_cursor')
    static function getFlipbookCursor(node:GuiNode):Float;

    /**
        Gets the playback rate of the flipbook animation on a node.

        This is only useful nodes with flipbook animations. Gets the playback rate of the flipbook animation on a node.

        @param node node to set the cursor for
        @return playback rate
    **/
    @:pure
    @:native('get_flipbook_playback_rate')
    static function getFlipbookPlaybackRate(node:GuiNode):Float;

    /**
        Gets the node font.

        This is only useful for text nodes. The font must be mapped to the gui scene in the gui editor.

        @param node node from which to get the font
        @return font id
    **/
    @:pure
    @:native('get_font')
    static function getFont(node:GuiNode):Hash;

    /**
        This is only useful for text nodes. The font must be mapped to the gui scene in the gui editor.

        @param fontName font of which to get the path hash
        @return path hash to resource
    **/
    @:pure
    @:native('get_font_resource')
    static function getFontResource(fontName:HashOrString):Hash;

    /**
        Gets the scene height.

        @return scene height
    **/
    @:pure
    @:native('get_height')
    static function getHeight():Float;

    /**
        Gets the id of the specified node.

        @param node node to retrieve the id from
        @return id of the node
    **/
    @:pure
    @:native('get_id')
    static function getId(node:GuiNode):Hash;

    /**
        Gets the node inherit alpha state.

        @param node node from which to get the inherit alpha state
    **/
    @:pure
    @:native('get_inherit_alpha')
    static function getInheritAlpha(node:GuiNode):Bool;

    /**
        Gets the index of the specified node.

        The index defines the order in which a node appear in a GUI scene.
        Higher index means the node is drawn on top of lower indexed nodes.

        @param node node to retrieve the id from
        @return id of the node
    **/
    @:pure
    @:native('get_index')
    static function getIndex(node:GuiNode):Float;

    /**
        Gets the node alpha.

        @param node node from which to get alpha
        @return 0..1 alpha color
    **/
    @:pure
    @:native('get_alpha')
    static function getAlpha(node:GuiNode):Float;

    /**
        Sets the node alpha.

        @param node node on which to set alpha
        @param alpha 0..1 alpha color
    **/
    @:native('set_alpha')
    static function setAlpha(node:GuiNode, alpha:Float):Void;

    /**
        Gets the pie inner radius (defined along the x dimension).

        @param node node from where to get the inner radius
        @return inner radius
    **/
    @:pure
    @:native('get_inner_radius')
    static function getInnerRadius(node:GuiNode):Float;

    /**
        Gets the node layer.

        The layer must be mapped to the gui scene in the gui editor.

        @param node node from which to get the layer
        @return layer id
    **/
    @:pure
    @:native('get_layer')
    static function getLayer(node:GuiNode):Hash;

    /**
        Gets the scene current layout.

        @return layout id
    **/
    @:pure
    @:native('get_layout')
    static function getLayout():Hash;

    /**
        Gets the leading of the text node.

        @param node node from where to get the leading
        @return scaling number (default=1)
    **/
    @:pure
    @:native('get_leading')
    static function getLeading(node:GuiNode):Float;

    /**
        Get line-break mode..

        This is only useful for text nodes.

        @param node node from which to get the line-break for
        @return line_break
    **/
    @:pure
    @:native('get_line_break')
    static function getLineBreak(node:GuiNode):Bool;

    /**
        Gets the node with the specified id.

        @param id id of the node to retrieve
        @return node instance
    **/
    @:pure
    @:native('get_node')
    static function getNode(id:HashOrString):GuiNode;

    /**
        Gets the pie outer bounds mode.

        @param node node from where to get the outer bounds mode (node)
        @return PIEBOUNDS_RECTANGLE or PIEBOUNDS_ELLIPSE
    **/
    @:pure
    @:native('get_outer_bounds')
    static function getOuterBounds(node:GuiNode):GuiPieBounds;

    /**
        Gets the node outline color.

        @param node node to get the outline color from
        @return node outline color
    **/
    @:pure
    @:native('get_outline')
    static function getOutline(node:GuiNode):Vector4;

    /**
        Gets the parent of the specified node.

        If the specified node does not have a parent, null is returned.

        @param node the node from which to retrieve its parent
        @return parent instance
    **/
    @:pure
    @:native('get_parent')
    static function getParent(node:GuiNode):Null<GuiNode>;

    /**
        Get the paricle fx for a gui node

        @param node node to get particle fx for
        @return particle fx id
    **/
    @:pure
    @:native('get_particlefx')
    static function getParticlefx(node:GuiNode):Hash;

    /**
        Gets the number of generated vertices around the perimeter.

        @return vertex count
    **/
    @:pure
    @:native('get_perimeter_vertices')
    static function getPerimeterVertices():Int;

    /**
        Gets the pivot of a node.

        The pivot specifies how the node is drawn and rotated from its position.

        @param node node to get pivot from
        @return pivot constant
    **/
    @:pure
    @:native('get_pivot')
    static function getPivot(node:GuiNode):GuiPivot;

    /**
        Gets the node position.

        @param node node to get the position from
        @return node position
    **/
    @:pure
    @:native('get_position')
    static function getPosition(node:GuiNode):Vector3;

    /**
        Gets the node rotation.

        @param node node to get the rotation from
        @return node rotation
    **/
    @:pure
    @:native('get_rotation')
    static function getRotation(node:GuiNode):Vector3;

    /**
        Gets the node scale.

        @param node node to get the scale from
        @return node scale
    **/
    @:pure
    @:native('get_scale')
    static function getScale(node:GuiNode):Vector3;

    /**
        Returns the screen position of the supplied node. This function returns the
        calculated transformed position of the node, taking into account any parent node
        transforms.

        @param node node to get the screen position from
        @return node screen position
    **/
    @:pure
    @:native('get_screen_position')
    static function getScreenPosition(node:GuiNode):Vector3;

    /**
        Set the screen position to the supplied node.

        @param node node to set the screen position to
        @param screenPosition the screen position to set
    **/
    @:pure
    @:native('set_screen_position')
    static function setScreenPosition(node:GuiNode, screenPosition:Vector3):Void;

    /**
        Convert the screen position to the local position of supplied node.

        @param node node used for getting local transformation matrix
        @param screenPosition screen position
        @return local position
    **/
    @:pure
    @:native('screen_to_local')
    static function screenToLocal(node:GuiNode, screenPosition:Vector3):Vector3;

    /**
        Gets the node shadow color.

        @param node node to get the shadow color from
        @return node shadow color
    **/
    @:pure
    @:native('get_shadow')
    static function getShadow(node:GuiNode):Vector4;

    /**
        Gets the node size.

        @param node node to get the size from
        @return node size
    **/
    @:pure
    @:native('get_size')
    static function getSize(node:GuiNode):Vector3;

    /**
        Gets the node size mode.

        Size mode defines how the node will adjust itself in size according to mode.

        @param node node from which to get the size mode
        @return node size mode
    **/
    @:pure
    @:native('get_size_mode')
    static function getSizeMode(node:GuiNode):GuiSizeMode;

    /**
        Get the slice9 values for the node.

        @param node node to manipulate
        @return configuration values
    **/
    @:pure
    @:native('get_slice9')
    static function getSlice9(node:GuiNode):Vector4;

    /**
        Gets the node text.

        This is only useful for text nodes.

        @param node node from which to get the text
        @return text value
    **/
    @:pure
    @:native('get_text')
    static function getText(node:GuiNode):String;

    /**
        Gets the node texture.

        This is currently only useful for box or pie nodes. The texture must be mapped to the gui scene in the gui editor.

        @param node node to get texture from
        @return texture id
    **/
    @:pure
    @:native('get_texture')
    static function getTexture(node:GuiNode):Hash;

    /**
        Gets the tracking of the text node.

        @param node node from where to get the tracking
        @return scaling number (default=0)
    **/
    @:pure
    @:native('get_tracking')
    static function getTracking(node:GuiNode):Float;

    /**
        Gets the scene width.

        @return scene width
    **/
    @:pure
    @:native('get_width')
    static function getWidth():Float;

    /**
        Gets the x-anchor of a node.

        The x-anchor specifies how the node is moved when the game is run in a different resolution.

        @param node node to get x-anchor from
        @return anchor anchor constant
    **/
    @:pure
    @:native('get_xanchor')
    static function getAnchorX(node:GuiNode):GuiAnchor;

    /**
        Gets the y-anchor of a node.

        The y-anchor specifies how the node is moved when the game is run in a different resolution.

        @param node node to get y-anchor from
        @return anchor anchor constant
    **/
    @:pure
    @:native('get_yanchor')
    static function getAnchorY(node:GuiNode):GuiAnchor;

    /**
        Hide the on-display keyboard on the device.
    **/
    @:native('hide_keyboard')
    static function hideKeyboard():Void;

    /**
        Retrieves if a node is enabled or not.

        Disabled nodes are not rendered and animations acting on them are not evaluated.

        @param node node to query
        @return whether the node is enabled or not
    **/
    @:pure
    @:native('is_enabled')
    static function isEnabled(node:GuiNode):Bool;

    /**
        Moves the first node above the second.

        Supply null as the second argument to move the first node to the top.

        @param node to move
        @param ref reference node above which the first node should be moved
    **/
    @:native('move_above')
    static function moveAbove(node:GuiNode, ref:Null<GuiNode>):Void;

    /**
        Moves the first node below the second.

        Supply null as the second argument to move the first node to the bottom.

        @param node to move
        @param ref reference node below which the first node should be moved
    **/
    @:native('move_below')
    static function moveBelow(node:GuiNode, ref:Null<GuiNode>):Void;

    /**
        Creates a new box node.

        @param pos node position
        @param size node size
        @return new box node
    **/
    @:native('new_box_node')
    static function newBoxNode(pos:EitherType<Vector3,Vector4>, size:Vector3):GuiNode;

    /**
        Dynamically create a particle fx node.

        @param pos node position
        @param particlefx particle fx resource name
        @return new particle fx node
    **/
    @:native('new_particlefx_node')
    static function newParticlefxNode(pos:EitherType<Vector4,Vector3>, particlefx:HashOrString):GuiNode;

    /**
        Creates a new pie node.

        @param pos node position
        @param size node size
        @return new box node
    **/
    @:native('new_pie_node')
    static function newPieNode(pos:EitherType<Vector3,Vector4>, size:Vector3):GuiNode;

    /**
        Creates a new spine node.

        @param pos node position
        @param spineScene spine scene id
        @return new spine node
    **/
    @:native('new_spine_node')
    static function newSpineNode(pos:EitherType<Vector3,Vector4>, spineScene:HashOrString):GuiNode;

    /**
        Creates a new text node.

        @param pos node position
        @param text node text
        @return new text node
    **/
    @:native('new_text_node')
    static function newTextNode(pos:EitherType<Vector3,Vector4>, text:String):GuiNode;

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
    @:native('new_texture')
    static function newTexture(texture:HashOrString, width:Float, height:Float, type:ImageType, buffer:BufferData, ?flip:Bool):GuiNewTextureResult;

    /**
        Determines if the node is pickable by the supplied coordinates.

        @param node node to be tested for picking
        @param x x-coordinate
        @param y y-coordinate
        @return pick result
    **/
    @:pure
    @:native('pick_node')
    static function pickNode(node:GuiNode, x:Float, y:Float):Bool;

    /**
        Play node flipbook animation.

        Play flipbook animation on a box or pie node. The current node texture must contain the animation.

        @param node node to set animation for
        @param animation animation id
        @param completeFunction function to call when the animation has completed
        @param playProperties optional table with properties
    **/
    @:native('play_flipbook')
    static function playFlipbook(node:GuiNode, animation:HashOrString, ?completeFunction:Void->Void, ?playProperties:GuiPlayFlipbookProperties):Void;

    /**
        Plays the paricle fx for a gui node

        @param node node to play particle fx for
        @param emitterStateFunction optional callback function that will be called when an emitter attached to this particlefx changes state.
                                      callback arguments:
                                       * self The current object
                                       * id The id of the particle fx component
                                       * emitter The id of the emitter
                                       * state the new state of the emitter
    **/
    static inline function playParticlefx(node:GuiNode, ?emitterStateFunction:(Hash, Hash, ParticlefxEmitterState)->Void):Void
    {
        // 1. hide the reall callback parameter which expects a function with a "self" argument
        // 2. ensure that the global self reference is present for the callback
        playParticlefx_(node, emitterStateFunction == null ? null : (self, hash, hash, state) ->
        {
            untyped __lua__('_G._hxdefold_self_ = {0}', self);
            emitterStateFunction(hash, hash, state);
            untyped __lua__('_G._hxdefold_self_ = nil');
        });
    }
    @:native('play_particlefx') private static function playParticlefx_(node:GuiNode, ?emitterStateFunction:(Any, Hash, Hash, ParticlefxEmitterState)->Void):Void;

    /**
        Play a spine animation.

        @param node spine node that should play the animation
        @param animationId id of the animation to play
        @param playback playback mode
        @param playProperties optional table with properties
        @param completeFunction function to call when the animation has completed
    **/
        @:native('play_spine_anim')
    static function playSpineAnim(node:GuiNode, animationId:HashOrString, playback:GuiPlayback, ?playProperties:GuiPlaySpineProperties, ?completeFunction:Void->Void):Void;

    /**
        Reset on-display keyboard if available.

        Reset input context of keyboard. This will clear marked text.
    **/
    @:native('reset_keyboard')
    static function resetKeyboard():Void;

    /**
        Reset all nodes to initial state.

        reset only applies to static node loaded from the scene. Nodes created dynamically from script are not affected
    **/
    @:native('reset_nodes')
    static function resetNodes():Void;

    /**
        Sets node adjust mode.

        Adjust mode defines how the node will adjust itself to a screen resolution which differs from the project settings.

        @param node node to set adjust mode for
        @param adjustMode adjust mode to set
    **/
    @:native('set_adjust_mode')
    static function setAdjustMode(node:GuiNode, adjustMode:GuiAdjustMode):Void;

    /**
        Sets node blend mode.

        Blend mode defines how the node will be blended with the background.

        @param node node to set blend mode for
        @param blendMode blend mode to set
    **/
    @:native('set_blend_mode')
    static function setBlendMode(node:GuiNode, blendMode:GuiBlendMode):Void;

    /**
        Sets node clipping visibility.

        If node is set as an inverted clipping node, it will clip anything inside as opposed to outside.

        @param node node to set clipping inverted state for
        @param visible true or false
    **/
    @:native('set_clipping_inverted')
    static function setClippingInverted(node:GuiNode, visible:Bool):Void;

    /**
        Sets node clipping mode state.

        Clipping mode defines how the node will clipping it's children nodes

        @param node node to set clipping mode for
        @param clippingMode clipping mode to set
    **/
    @:native('set_clipping_mode')
    static function setClippingMode(node:GuiNode, clippingMode:GuiClippingMode):Void;

    /**
        Sets node clipping visibility.

        If node is set as an visible clipping node, it will be shown as well as clipping. Otherwise, it will only clip but not show visually.

        @param node node to set clipping visibility for
        @param visible true or false
    **/
    @:native('set_clipping_visible')
    static function setClippingVisible(node:GuiNode, visible:Bool):Void;

    /**
        Sets the node color.

        @param node node to set the color for
        @param color new color
    **/
    @:native('set_color')
    static function setColor(node:GuiNode, color:EitherType<Vector3,Vector4>):Void;

    /**
        Enables/disables a node.

        Disabled nodes are not rendered and animations acting on them are not evaluated.

        @param node node to be enabled/disabled
        @param enabled whether the node should be enabled or not
    **/
    @:native('set_enabled')
    static function setEnabled(node:GuiNode, enabled:Bool):Void;

    /**
        Sets the angle for the filled pie sector.

        @param node node to set the fill angle for
        @param sector angle
    **/
    @:native('set_fill_angle')
    static function setFillAngle(node:GuiNode, angle:Float):Void;

    /**
        Sets the normalized cursor of the animation on a node with flipbook animation.

        This is only useful nodes with flipbook animations. The cursor is normalized.

        @param node node to set the cursor for
        @param cursor cursor value
    **/
    @:native('set_flipbook_cursor')
    static function setFlipbookCursor(node:GuiNode, cursor:Float):Void;

    /**
        Sets the playback rate of the flipbook animation on a node.

        This is only useful nodes with flipbook animations. Sets the playback rate of the flipbook animation on a node. Must be positive.

        @param node node to set the cursor for
        @param playback_rate playback rate
    **/
    @:native('set_flipbook_playback_rate')
    static function setFlipbookPlaybackRate(node:GuiNode, playback_rate:Float):Void;

    /**
        Sets the node font.

        This is only useful for text nodes. The font must be mapped to the gui scene in the gui editor.

        @param node node for which to set the font
        @param font font id
    **/
    @:native('set_font')
    static function setFont(node:GuiNode, font:HashOrString):Void;

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
    @:native('set_id')
    static function setId(node:GuiNode, id:HashOrString):Void;

    /**
        Sets the node inherit alpha state.

        @param node node from which to set the inherit alpha state
        @param inherit_alpha true or false
    **/
    @:native('set_inherit_alpha')
    static function setInheritAlpha(node:GuiNode, inherit_alpha:Bool):Void;

    /**
        Sets the pie inner radius (defined along the x dimension).

        @param node node to set the inner radius for
        @param inner radius
    **/
    @:native('set_inner_radius')
    static function setInnerRadius(node:GuiNode, inner:Float):Void;

    /**
        Sets the node layer.

        The layer must be mapped to the gui scene in the gui editor.

        @param node node for which to set the layer
        @param layer layer id
    **/
    @:native('set_layer')
    static function setLayer(node:GuiNode, layer:HashOrString):Void;

    /**
        Sets the leading of the text node.

        @param node node for which to set the leading
        @param leading a scaling number for the line spacing (default=1)
    **/
    @:native('set_leading')
    static function setLeading(node:GuiNode, leading:Float):Void;

    /**
        Set line-break mode.

        This is only useful for text nodes.

        @param node node to set line-break for
        @param line_break true or false
    **/
    @:native('set_line_break')
    static function setLineBreak(node:GuiNode, line_break:Bool):Void;

    /**
        Sets the pie outer bounds mode.

        @param node node for which to set the outer bounds mode
        @param bounds PIEBOUNDS_RECTANGLE or PIEBOUNDS_ELLIPSE
    **/
    @:native('set_outer_bounds')
    static function setOuterBounds(node:GuiNode, bounds:GuiPieBounds):Void;

    /**
        Sets the node outline color.

        @param node node to set the outline color for
        @param color new outline color
    **/
    @:native('set_outline')
    static function setOutline(node:GuiNode, color:EitherType<Vector3,Vector4>):Void;

    /**
        Set the parent of the node.

        @param node node for which to set its parent
        @param parent parent node to set
        @param keep_scene_transform optional flag to make the scene position being perserved
    **/
    @:native('set_parent')
    static function setParent(node:GuiNode, parent:GuiNode, ?keep_scene_transform:Bool):Void;

    /**
        Set the paricle fx for a gui node

        @param node node to set particle fx for
        @param particlefx particle fx id
    **/
    @:native('set_particlefx')
    static function setParticlefx(node:GuiNode, particlefx:HashOrString):Void;

    /**
        Sets the number of generarted vertices around the perimeter.

        @param vertex count
    **/
    @:native('set_perimeter_vertices')
    static function setPerimeterVertices(vertex:Int):Void;

    /**
        Sets the pivot of a node.

        The pivot specifies how the node is drawn and rotated from its position.

        @param node node to set pivot for
        @param pivot pivot constant
    **/
    @:native('set_pivot')
    static function setPivot(node:GuiNode, pivot:GuiPivot):Void;

    /**
        Sets the node position.

        @param node node to set the position for
        @param position new position
    **/
    @:native('set_position')
    static function setPosition(node:GuiNode, position:EitherType<Vector3,Vector4>):Void;

    /**
        Set the order number for the current GUI scene. The number dictates the sorting of the "gui" render predicate, in other words
        in which order the scene will be rendered in relation to other currently rendered GUI scenes.

        The number must be in the range 0 to 15.

        @param order rendering order
    **/
    @:native('set_render_order')
    static function setRenderOrder(order:Int):Void;

    /**
        Sets the node rotation.

        @param node node to set the rotation for
        @param rotation new rotation
    **/
    @:native('set_rotation')
    static function setRotation(node:GuiNode, rotation:EitherType<Vector3,Vector4>):Void;

    /**
        Sets the node scale.

        @param node node to set the scale for
        @param scale new scale
    **/
    @:native('set_scale')
    static function setScale(node:GuiNode, scale:EitherType<Vector3,Vector4>):Void;

    /**
        Sets the node shadow color.

        @param node node to set the shadow color for
        @param color new shadow color
    **/
    @:native('set_shadow')
    static function setShadow(node:GuiNode, color:EitherType<Vector3,Vector4>):Void;

    /**
        Sets the node size.

        *NOTE!* You can only set size on nodes with size mode set to SIZE_MODE_MANUAL

        @param node node to set the size for
        @param size new size
    **/
    @:native('set_size')
    static function setSize(node:GuiNode, size:EitherType<Vector3,Vector4>):Void;

    /**
        Sets node size mode.

        Size mode defines how the node will adjust itself in size according to mode.

        @param node node to set size mode for
        @param size_mode size mode to set
    **/
    @:native('set_size_mode')
    static function setSizeMode(node:GuiNode, size_mode:GuiSizeMode):Void;

    /**
        Set the slice9 configuration for the node.

        @param node node to manipulate
        @param params new value
    **/
    @:native('set_slice9')
    static function setSlice9(node:GuiNode, params:Vector4):Void;

    /**
        Sets the normalized cursor of the animation on a spine node.

        This is only useful for spine nodes. The cursor is normalized.

        @param node spine node to set the cursor for (node)
        @param cursor cursor value (number)
    **/
    @:native('set_spine_cursor')
    static function setSpineCursor(node:GuiNode, cursor:Float):Void;

    /**
        Sets the playback rate of the animation on a spine node.

        This is only useful for spine nodes. Sets the playback rate of the animation on a spine node. Must be positive.

        @param node spine node to set the cursor for
        @param playback_rate playback rate
    **/
    @:native('set_spine_playback_rate')
    static function setSpinePlaybackRate(node:GuiNode, playback_rate:Float):Void;

    /**
        Sets the spine scene of a node.

        Set the spine scene on a spine node. The spine scene must be mapped to the gui scene in the gui editor.

        @param node node to set spine scene for
        @param spine_scene spine scene id
    **/
    @:native('set_spine_scene')
    static function setSpineScene(node:GuiNode, spine_scene:HashOrString):Void;

    /**
        Sets the spine skin on a spine node.

        @param node node to set the spine skin on
        @param spine_skin spine skin id
        @param spine_slot optional slot id to only change a specific slot
    **/
    @:native('set_spine_skin')
    static function setSpineSkin(node:GuiNode, spine_skin:HashOrString, ?spine_slot:HashOrString):Void;

    /**
        Sets the node text.

        This is only useful for text nodes.

        @param node node to set text for
        @param text text to set
    **/
    @:native('set_text')
    static function setText(node:GuiNode, text:String):Void;

    /**
        Sets the node texture.

        Set the texture on a box or pie node. The texture must be mapped to the gui scene in the gui editor.

        @param node node to set texture for
        @param texture texture id
    **/
    @:native('set_texture')
    static function setTexture(node:GuiNode, texture:HashOrString):Void;

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
    @:native('set_texture_data')
    static function setTextureData(texture:HashOrString, width:Float, height:Float, type:ImageType, buffer:BufferData, ?flip:Bool):Bool;

    /**
        Sets the tracking of the text node.

        @param node node for which to set the tracking
        @param tracking a scaling number for the letter spacing (default=0)
    **/
    @:native('set_tracking')
    static function setTracking(node:GuiNode, tracking:Float):Void;

    /**
        Sets the x-anchor of a node.

        The x-anchor specifies how the node is moved when the game is run in a different resolution.

        @param node node to set x-anchor for
        @param anchor anchor constant
    **/
    @:native('set_xanchor')
    static function setXanchor(node:GuiNode, anchor:GuiAnchor):Void;

    /**
        Sets the y-anchor of a node.

        The y-anchor specifies how the node is moved when the game is run in a different resolution.

        @param node node to set y-anchor for
        @param anchor anchor constant
    **/
    @:native('set_yanchor')
    static function setYanchor(node:GuiNode, anchor:GuiAnchor):Void;

    /**
        Shows the on-display keyboard if available.

        The specified type of keyboard is displayed, if it is available on
        the device.

        This function is only available on iOS and Android.

        @param type keyboard type
        @param autoclose close keyboard automatically when clicking outside
    **/
    @:native('show_keyboard')
    static function showKeyboard(type:GuiKeyboardType, autoclose:Bool):Void;

    /**
        Stops the particle fx for a gui node

        @param node node to stop particle fx for
    **/
    @:native('stop_particlefx')
    static function stopParticlefx(node:GuiNode):Void;
}

/**
    Messages related to the `Gui` module.
**/
@:publicFields
class GuiMessages
{
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
typedef GuiMessageLayoutChanged =
{
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
extern final class GuiNode {}

/**
    Possible GUI playback modes.
**/
@:native("_G.gui")
extern enum abstract GuiPlayback({})
{
    /**
        Loop backward.
    **/
    @:native('PLAYBACK_LOOP_BACKWARD')
    var LoopBackward;

    /**
        Loop forward.
    **/
    @:native('PLAYBACK_LOOP_FORWARD')
    var LoopForward;

    /**
        Ping pong loop.
    **/
    @:native('PLAYBACK_LOOP_PINGPONG')
    var LoopPingPing;

    /**
        Once backward.
    **/
    @:native('PLAYBACK_ONCE_BACKWARD')
    var OnceBackward;

    /**
        Once forward.
    **/
    @:native('PLAYBACK_ONCE_FORWARD')
    var OnceForward;

    /**
        Once ping pong.
    **/
    @:native('PLAYBACK_ONCE_PINGPONG')
    var OncePingPong;
}

/**
    Enumeration of possible adjust modes of a gui node.

    Adjust mode defines how the node will adjust itself
    to a screen resolution which differs from the project settings.
**/
@:native("_G.gui")
extern enum abstract GuiAdjustMode(Int)
{
    /**
        Fit adjust mode.

        Adjust mode is used when the screen resolution differs from the project settings.
        The fit mode ensures that the entire node is visible in the adjusted gui scene.
    **/
    @:native('ADJUST_FIT')
    var Fit;

    /**
        Stretch adjust mode.

        Adjust mode is used when the screen resolution differs from the project settings.
        The stretch mode ensures that the node is displayed as is in the adjusted gui scene, which might scale it non-uniformally.
    **/
    @:native('ADJUST_STRETCH')
    var Stretch;

    /**
        Zoom adjust mode.

        Adjust mode is used when the screen resolution differs from the project settings.
        The zoom mode ensures that the node fills its entire area and might make the node exceed it.
    **/
    @:native('ADJUST_ZOOM')
    var Zoom;
}

/**
    Enumeration of possible blend modes of a gui node.

    Blend mode defines how the node will be blended with the background.
**/
@:native("_G.gui")
extern enum abstract GuiBlendMode({})
{
    /**
        Alpha blending.
    **/
    @:native('BLEND_ALPHA')
    var Alpha;

    /**
        Additive blending.
    **/
    @:native('BLEND_ADD')
    var Add;

    /**
        Additive alpha blending.
    **/
    @:native('BLEND_ADD_ALPHA')
    var AddAlpha;

    /**
        Multiply blending.
    **/
    @:native('BLEND_MULT')
    var Mult;
}

/**
    Possible clipping modes.
    Clipping mode defines how the node will clipping it's children nodes
**/
@:native("_G.gui")
extern enum abstract GuiClippingMode(Int)
{
    /**
        Clipping mode none.
    **/
    @:native('CLIPPING_MODE_NONE')
    var None;

    /**
        Clipping mode stencil.
    **/
    @:native('CLIPPING_MODE_STENCIL')
    var Stencil;
}

/**
    Possible node pivots.
**/
@:native("_G.gui")
extern enum abstract GuiPivot(Int)
{
    /**
        Center pivor.
    **/
    @:native('PIVOT_CENTER')
    var Center;

    /**
        North pivot.
    **/
    @:native('PIVOT_N')
    var North;

    /**
        North-east pivot.
    **/
    @:native('PIVOT_NE')
    var NorthEast;

    /**
        East pivot.
    **/
    @:native('PIVOT_E')
    var East;

    /**
        South-east pivot.
    **/
    @:native('PIVOT_SE')
    var SouthEast;

    /**
        South pivot.
    **/
    @:native('PIVOT_S')
    var South;

    /**
        South-west pivot.
    **/
    @:native('PIVOT_SW')
    var SouthWest;

    /**
        West pivot.
    **/
    @:native('PIVOT_W')
    var West;

    /**
        North-west pivot.
    **/
    @:native('PIVOT_NW')
    var NorthWest;
}

/**
    Possible node size modes.
**/
@:native("_G.gui")
extern enum abstract GuiSizeMode(Int)
{
    /**
        Automatic size mode

        The size of the node is determined by the currently assigned texture.
    **/
    @:native('SIZE_MODE_AUTO')
    var Auto;

    /**
        Manual size mode

        The size of the node is determined by the size set in the editor, the constructor or by `Gui.set_size`.
    **/
    @:native('SIZE_MODE_MANUAL')
    var Manual;
}

@:native("_G.gui")
extern enum abstract GuiAnchor(Int)
{
    /**
        No anchor.
    **/
    @:native('ANCHOR_NONE')
    var None;

    /**
        Left x-anchor.
    **/
    @:native('ANCHOR_LEFT')
    var Left;

    /**
        Right x-anchor.
    **/
    @:native('ANCHOR_RIGHT')
    var Right;
}

/**
    Possible pie bounds.
**/
@:native("_G.gui")
extern enum abstract GuiPieBounds({})
{
    /**
        Elliptical pie node bounds.
    **/
    @:native('PIEBOUNDS_ELLIPSE')
    var Ellipse;

    /**
        Rectangular pie node bounds.
    **/
    @:native('PIEBOUNDS_RECTANGLE')
    var Rectangle;
}

@:native("_G.gui")
extern enum abstract GuiKeyboardType({})
{
    /**
        Default keyboard.
    **/
    @:native('KEYBOARD_TYPE_DEFAULT')
    var Default;

    /**
        Email keyboard.
    **/
    @:native('KEYBOARD_TYPE_EMAIL')
    var Email;

    /**
        Number input keyboard.
    **/
    @:native('KEYBOARD_TYPE_NUMBER_PAD')
    var NumberPad;

    /**
        Password keyboard.
    **/
    @:native('KEYBOARD_TYPE_PASSWORD')
    var Password;
}

@:native("_G.gui")
extern enum abstract GuiEasing({})
{
    /**
        In-back.
    **/
    @:native('EASING_INBACK')
    var InBack;

    /**
        In-bounce.
    **/
    @:native('EASING_INBOUNCE')
    var InBounce;

    /**
        In-circlic.
    **/
    @:native('EASING_INCIRC')
    var InCirc;

    /**
        In-cubic.
    **/
    @:native('EASING_INCUBIC')
    var InCubic;

    /**
        In-elastic.
    **/
    @:native('EASING_INELASTIC')
    var InElastic;

    /**
        In-exponential.
    **/
    @:native('EASING_INEXPO')
    var InExpo;

    /**
        In-out-back.
    **/
    @:native('EASING_INOUTBACK')
    var InOutBack;

    /**
        In-out-bounce.
    **/
    @:native('EASING_INOUTBOUNCE')
    var InOutBounce;

    /**
        In-out-circlic.
    **/
    @:native('EASING_INOUTCIRC')
    var InOutCirc;

    /**
        In-out-cubic.
    **/
    @:native('EASING_INOUTCUBIC')
    var InOutCubic;

    /**
        In-out-elastic.
    **/
    @:native('EASING_INOUTELASTIC')
    var InOutElastic;

    /**
        In-out-exponential.
    **/
    @:native('EASING_INOUTEXPO')
    var InOutExpo;

    /**
        In-out-quadratic.
    **/
    @:native('EASING_INOUTQUAD')
    var InOutQuad;

    /**
        In-out-quartic.
    **/
    @:native('EASING_INOUTQUART')
    var InOutQuart;

    /**
        In-out-quintic.
    **/
    @:native('EASING_INOUTQUINT')
    var InOutQuint;

    /**
        In-out-sine.
    **/
    @:native('EASING_INOUTSINE')
    var InOutSine;

    /**
        In-quadratic.
    **/
    @:native('EASING_INQUAD')
    var InQuad;

    /**
        In-quartic.
    **/
    @:native('EASING_INQUART')
    var InQuart;

    /**
        In-quintic.
    **/
    @:native('EASING_INQUINT')
    var InQuint;

    /**
        In-sine.
    **/
    @:native('EASING_INSINE')
    var InSine;

    /**
        Linear interpolation.
    **/
    @:native('EASING_LINEAR')
    var Linear;

    /**
        Out-back.
    **/
    @:native('EASING_OUTBACK')
    var OutBack;

    /**
        Out-bounce.
    **/
    @:native('EASING_OUTBOUNCE')
    var OutBounce;

    /**
        Out-circlic.
    **/
    @:native('EASING_OUTCIRC')
    var OutCirc;

    /**
        Out-cubic.
    **/
    @:native('EASING_OUTCUBIC')
    var OutCubic;

    /**
        Out-elastic.
    **/
    @:native('EASING_OUTELASTIC')
    var OutElastic;

    /**
        Out-exponential.
    **/
    @:native('EASING_OUTEXPO')
    var OutExpo;

    /**
        Out-in-back.
    **/
    @:native('EASING_OUTINBACK')
    var OutInBack;

    /**
        Out-in-bounce.
    **/
    @:native('EASING_OUTINBOUNCE')
    var OutInBounce;

    /**
        Out-in-circlic.
    **/
    @:native('EASING_OUTINCIRC')
    var OutInCirc;

    /**
        Out-in-cubic.
    **/
    @:native('EASING_OUTINCUBIC')
    var OutInCubic;

    /**
        Out-in-elastic.
    **/
    @:native('EASING_OUTINELASTIC')
    var OutInElastic;

    /**
        Out-in-exponential.
    **/
    @:native('EASING_OUTINEXPO')
    var OutInExpo;

    /**
        Out-in-quadratic.
    **/
    @:native('EASING_OUTINQUAD')
    var OutInQuad;

    /**
        Out-in-quartic.
    **/
    @:native('EASING_OUTINQUART')
    var OutInQuart;

    /**
        Out-in-quintic.
    **/
    @:native('EASING_OUTINQUINT')
    var OutInQuint;

    /**
        Out-in-sine.
    **/
    @:native('EASING_OUTINSINE')
    var OutInSine;

    /**
        Out-quadratic.
    **/
    @:native('EASING_OUTQUAD')
    var OutQuad;

    /**
        Out-quartic.
    **/
    @:native('EASING_OUTQUART')
    var OutQuart;

    /**
        Out-quintic.
    **/
    @:native('EASING_OUTQUINT')
    var OutQuint;

    /**
        Out-sine.
    **/
    @:native('EASING_OUTSINE')
    var OutSine;
}

@:native("_G.gui")
extern enum abstract GuiNewTextureResultCode({})
{
    /**
        The texture id already exists when trying to use `gui.new_texture()`.
    **/
    @:native('RESULT_TEXTURE_ALREADY_EXISTS')
    var TextureAlreadyExists;
    /**
        The system is out of resources, for instance when trying to create a new texture using `gui.new_texture()`.
    **/
    @:native('RESULT_OUT_OF_RESOURCES')
    var OutOfResources;
    /**
        The provided data is not in the expected format or is in some other way incorrect, for instance the image data provided to `gui.new_texture()`.
    **/
    @:native('RESULT_DATA_ERROR')
    var DataError;
}

@:native("_G.gui")
extern enum abstract GuiAnimateProprty({})
{
    /**
        position property
    **/
    @:native('PROP_POSITION')
    var Position;
    /**
        rotation property
    **/
    @:native('PROP_ROTATION')
    var Rotation;
    /**
        scale property
    **/
    @:native('PROP_SCALE')
    var Scale;
    /**
        color property
    **/
    @:native('PROP_COLOR')
    var Color;
    /**
        outline property
    **/
    @:native('PROP_OUTLINE')
    var Outline;
    /**
        shadow color property
    **/
    @:native('PROP_SHADOW')
    var Shadow;
    /**
        size property
    **/
    @:native('PROP_SIZE')
    var Size;
    /**
        fill_angle property
    **/
    @:native('PROP_FILL_ANGLE')
    var FillAngle;
    /**
        inner_radius property
    **/
    @:native('PROP_INNER_RADIUS')
    var InnerRadius;
    /**
        slice9 property
    **/
    @:native('PROP_SLICE9')
    var Slice9;
}

/**
    Data for the `play_properties` argument of `Gui.play_spine_anim` method.
**/
typedef GuiPlaySpineProperties =
{
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
typedef GuiPlayFlipbookProperties =
{
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
@:multiReturn extern final class GuiNewTextureResult
{
    /**
        texture creation was successful
    **/
    var success:Bool;

    /**
        one of the `GuiNewTextureResultCode` codes if unsuccessful
    **/
    var code:GuiNewTextureResultCode;
}
