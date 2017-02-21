package defold;

import haxe.extern.EitherType;
import defold.types.*;

/**
    Functions, core hooks, messages and constants for manipulation of
    game objects. The "go" namespace is accessible from game object script
    files.

    See `GoProperties` for related properties.
    See `GoMessages` for related messages.
**/
@:native("_G.go")
extern class Go {
    /**
        Animates a named property of the specified game object or component.

        This is only supported for numerical properties. If the node property is already being
        animated, that animation will be canceled and replaced by the new one.

        If a `complete_function` (lua function) is specified, that function will be called when the animation has completed.
        By starting a new animation in that function, several animations can be sequenced together. See the examples for more information.

        *NOTE!* If you call `go.animate()` from a game object's `final()` function, any passed
        `complete_function` will be ignored and never called upon animation completion.

        See the <a href="/doc/properties">properties guide</a> for which properties can be animated and how.

        @param url url of the game object or component having the property
        @param property name of the property to animate
        @param playback playback mode of the animation
        @param to target property value
        @param easing easing to use during animation. Either specify a constant, see the <a href="/doc/properties">properties guide</a> for a complete list, or a vmath.vector with a curve.
        @param duration duration of the animation in seconds
        @param delay delay before the animation starts in seconds
        @param complete_function function with parameters (self, url, property) to call when the animation has completed
    **/
    // TODO: easing is actually not a Vector3 but any vector created by Vmath.vector and we don't have a type for it right now.
    static function animate<T>(url:HashOrStringOrUrl, property:HashOrString, playback:GoPlayback, to:GoAnimatedProperty, easing:EitherType<GoEasing,Vector3>, duration:Float, ?delay:Float, ?complete_function:T->Url->GoAnimatedProperty->Void):Void;

    /**
        Cancels all animations of the named property of the specified game object or component.

        By calling this function, all stored animations of the given property will be canceled.

        See the <a href="/doc/properties">properties guide</a> for which properties can be animated and how.

        @param url url of the game object or component having the property
        @param property name of the property to animate
    **/
    static function cancel_animations(url:HashOrStringOrUrl, property:HashOrString):Void;

    /**
        Deletes a game object instance.

        <div>Delete a game object identified by its id.</div>

        @param id optional id of the instance to delete, the instance of the calling script is deleted by default
    **/
    static function delete(?id:HashOrStringOrUrl):Void;

    /**
        Deletes a set of game object instance.

        <div>Delete all game objects simultaneously as listed in table.
        The table values (not keys) should be game object ids (hashes).</div>

        @param ids table with values of instance ids (hashes) to be deleted
    **/
    @:overload(function(?ids:lua.Table<Hash,Hash>):Void {})
    static function delete_all(?ids:lua.Table<Int,Hash>):Void;

    /**
        Gets a named property of the specified game object or component.

        @param url url of the game object or component having the property
        @param id id of the property to retrieve
        @return the value of the specified property
    **/
    static function get(url:HashOrStringOrUrl, id:HashOrString):GoProperty;

    /**
        Gets the id of an instance.

        The instance id is a hash of the absolute path.
        If `path` is specified, it can either be absolute or relative to the instance of the calling script.
        If `path` is not specified, the id of the instance of the calling script will be returned. See the examples below for more information.

        @param path path of the instance for which to return the id
        @return instance id
    **/
    static function get_id(?path:String):Hash;

    /**
        Gets the position of the instance.

        The position is relative the parent (if any).
        Use `Go.get_world_position` to retrieve the global world position.

        @param id optional id of the instance to get the position for, by default the instance of the calling script
        @return instance position
    **/
    static function get_position(?id:HashOrStringOrUrl):Vector3;

    /**
        Gets the rotation of the instance.

        The rotation is relative to the parent (if any).
        Use `Go.get_world_rotation` to retrieve the global world position.

        @param id optional id of the instance to get the rotation for, by default the instance of the calling script
        @return instance rotation
    **/
    static function get_rotation(?id:HashOrStringOrUrl):Quaternion;

    /**
        Gets the uniform scale factor of the instance.

        The uniform scale is relative the parent (if any).
        Use `Go.get_world_scale` to retrieve the global world scale factor.

        @param id optional id of the instance to get the scale for, by default the instance of the calling script
        @return uniform instance scale factor
    **/
    static function get_scale(?id:HashOrStringOrUrl):Float;

    /**
        Gets the 3D scale factor of the instance.

        The scale is relative the parent (if any).
        Use `Go.get_world_scale` to retrieve the global world scale factor.

        @param id optional id of the instance to get the scale for, by default the instance of the calling script
        @return scale factor
    **/
    static function get_scale_vector(?id:HashOrStringOrUrl):Vector3;

    /**
        Gets the instance world position.

        Use `Go.get_position` to retrieve the position relative to the parent.

        @param id optional id of the instance to get the world position for, by default the instance of the calling script
        @return instance world position
    **/
    static function get_world_position(?id:HashOrStringOrUrl):Vector3;

    /**
        Gets the instance world rotation.

        Use `Go.get_rotation` to retrieve the rotation relative to the parent.

        @param id optional id of the instance to get the world rotation for, by default the instance of the calling script
        @return instance world rotation
    **/
    static function get_world_rotation(?id:HashOrStringOrUrl):Quaternion;

    /**
        Gets the instance world scale factor.

        Use `Go.get_scale` to retrieve the scale factor relative to the parent.

        @param id optional id of the instance to get the world scale for, by default the instance of the calling script
        @return uniform instance world scale factor
    **/
    static function get_world_scale(?id:HashOrStringOrUrl):Float;

    /**
        Sets a named property of the specified game object or component.

        @param url url of the game object or component having the property
        @param id id of the property to set
        @param value the value to set
    **/
    static function set(url:HashOrStringOrUrl, id:HashOrString, value:GoProperty):Void;

    /**
        Sets the position of the instance.

        The position is relative to the parent (if any).
        The global world position cannot be manually set.

        @param position position to set
        @param id optional id of the instance to set the position for, by default the instance of the calling script
    **/
    static function set_position(position:Vector3, ?id:HashOrStringOrUrl):Void;

    /**
        Sets the rotation of the instance.

        The rotation is relative to the parent (if any).
        The global world rotation cannot be manually set.

        @param rotation rotation to set
        @param id optional id of the instance to get the rotation for, by default the instance of the calling script
    **/
    static function set_rotation(rotation:Quaternion, ?id:HashOrStringOrUrl):Void;

    /**
        Sets the scale factor of the instance.

        The scale factor is relative to the parent (if any). The global world scale factor cannot be manually set.

        *NOTE!* Physics are currently not affected when setting scale from this function.

        @param scale vector or uniform scale factor, must be greater than 0
        @param id optional id of the instance to get the scale for, by default the instance of the calling script
    **/
    static function set_scale(scale:EitherType<Float,Vector3>, ?id:HashOrStringOrUrl):Void;
}

/**
    Messages related to the `Go` module.
**/
@:publicFields
class GoMessages {
    /**
        Acquires the user input focus.

        Post this message to a game object instance to make that instance acquire the user input focus.

        User input is distributed by the engine to every instance that has requested it. The last instance
        to request focus will receive it first. This means that the scripts in the instance will have
        first-hand-chance at reacting on user input, possibly consuming it so that no other instances
        can react on it. The most common case is for a script to send this message to itself when it needs to
        respond to user input.

        A script belonging to an instance which has the user input focus will receive the input actions
        in its `on_input` callback function. See `on_input` for more information on
        how user input can be handled.
    **/
    static var acquire_input_focus(default, never) = new Message<Void>("acquire_input_focus");

    /**
        Disables the receiving component.

        This message disables the receiving component. All components are enabled by default, which means they will receive input, updates
        and be a part of the simulation. A component is disabled when it receives the `disable` message.

        *Note!* Components that currently supports this message are:

           * Collection Proxy
           * Collision Object
           * Gui
           * Label
           * Spine Model
           * Sprite
           * Tile Grid
    **/
    static var disable(default, never) = new Message<Void>("disable");

    /**
        Enables the receiving component.

        This message enables the receiving component. All components are enabled by default, which means they will receive input, updates
        and be a part of the simulation. A component is disabled when it receives the `disable` message.

        *Note!* Components that currently supports this message are:

           * Collection Proxy
           * Collision Object
           * Gui
           * Spine Model
           * Sprite
           * Tile Grid
    **/
    static var enable(default, never) = new Message<Void>("enable");

    /**
        Releases the user input focus.

        Post this message to an instance to make that instance release the user input focus.
        See `acquire_input_focus` for more information on how the user input handling
        works.
    **/
    static var release_input_focus(default, never) = new Message<Void>("release_input_focus");

    /**
        Sets the parent of the receiving instance.

        When this message is sent to an instance, it sets the parent of that instance. This means that the instance will exist
        in the geometrical space of its parent, like a basic transformation hierarchy or scene graph. If no parent is specified,
        the instance will be detached from any parent and exist in world space. A script can send this message to itself to set
        the parent of its instance.
    **/
    static var set_parent(default, never) = new Message<GoMessageSetParent>("set_parent");
}

/**
    Data for the `GoMessages.set_parent` message.
**/
typedef GoMessageSetParent = {
    /**
        the id of the new parent
    **/
    @:optional var parent_id:Hash;

    /**
        if the world transform of the instance should be preserved when changing spaces, 0 for false and 1 for true
    **/
    @:optional var keep_world_transform:Int;
}

/**
    Possible types of a game object property.
**/
abstract GoProperty(Dynamic)
    from Float to Float
    from Hash to Hash
    from Url to Url
    from Vector3 to Vector3
    from Vector4 to Vector4
    from Quaternion to Quaternion
    from Bool to Bool
    {}

/**
    Possible types of game object property suitable for animation.
**/
abstract GoAnimatedProperty(Dynamic)
    from Vector3 to Vector3
    from Vector4 to Vector4
    from Quaternion to Quaternion
    from Float to Float
    {}

/**
    Game object easing constants.
**/
@:native("_G.go")
@:enum extern abstract GoEasing(Int) {
    /**
        In-back.
    **/
    var EASING_INBACK;

    /**
        In-bounce.
    **/
    var EASING_INBOUNCE;

    /**
        In-circlic.
    **/
    var EASING_INCIRC;

    /**
        In-cubic.
    **/
    var EASING_INCUBIC;

    /**
        In-elastic.
    **/
    var EASING_INELASTIC;

    /**
        In-exponential.
    **/
    var EASING_INEXPO;

    /**
        In-out-back.
    **/
    var EASING_INOUTBACK;

    /**
        In-out-bounce.
    **/
    var EASING_INOUTBOUNCE;

    /**
        In-out-circlic.
    **/
    var EASING_INOUTCIRC;

    /**
        In-out-cubic.
    **/
    var EASING_INOUTCUBIC;

    /**
        In-out-elastic.
    **/
    var EASING_INOUTELASTIC;

    /**
        In-out-exponential.
    **/
    var EASING_INOUTEXPO;

    /**
        In-out-quadratic.
    **/
    var EASING_INOUTQUAD;

    /**
        In-out-quartic.
    **/
    var EASING_INOUTQUART;

    /**
        In-out-quintic.
    **/
    var EASING_INOUTQUINT;

    /**
        In-out-sine.
    **/
    var EASING_INOUTSINE;

    /**
        In-quadratic.
    **/
    var EASING_INQUAD;

    /**
        In-quartic.
    **/
    var EASING_INQUART;

    /**
        In-quintic.
    **/
    var EASING_INQUINT;

    /**
        In-sine.
    **/
    var EASING_INSINE;

    /**
        Linear interpolation.
    **/
    var EASING_LINEAR;

    /**
        Out-back.
    **/
    var EASING_OUTBACK;

    /**
        Out-bounce.
    **/
    var EASING_OUTBOUNCE;

    /**
        Out-circlic.
    **/
    var EASING_OUTCIRC;

    /**
        Out-cubic.
    **/
    var EASING_OUTCUBIC;

    /**
        Out-elastic.
    **/
    var EASING_OUTELASTIC;

    /**
        Out-exponential.
    **/
    var EASING_OUTEXPO;

    /**
        Out-in-back.
    **/
    var EASING_OUTINBACK;

    /**
        Out-in-bounce.
    **/
    var EASING_OUTINBOUNCE;

    /**
        Out-in-circlic.
    **/
    var EASING_OUTINCIRC;

    /**
        Out-in-cubic.
    **/
    var EASING_OUTINCUBIC;

    /**
        Out-in-elastic.
    **/
    var EASING_OUTINELASTIC;

    /**
        Out-in-exponential.
    **/
    var EASING_OUTINEXPO;

    /**
        Out-in-quadratic.
    **/
    var EASING_OUTINQUAD;

    /**
        Out-in-quartic.
    **/
    var EASING_OUTINQUART;

    /**
        Out-in-quintic.
    **/
    var EASING_OUTINQUINT;

    /**
        Out-in-sine.
    **/
    var EASING_OUTINSINE;

    /**
        Out-quadratic.
    **/
    var EASING_OUTQUAD;

    /**
        Out-quartic.
    **/
    var EASING_OUTQUART;

    /**
        Out-quintic.
    **/
    var EASING_OUTQUINT;

    /**
        Out-sine.
    **/
    var EASING_OUTSINE;
}

/**
    Game object playback constants.
**/
@:native("_G.go")
@:enum extern abstract GoPlayback(Int) {
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
        No playback.
    **/
    var PLAYBACK_NONE;

    /**
        Once backward.
    **/
    var PLAYBACK_ONCE_BACKWARD;

    /**
        Once forward.
    **/
    var PLAYBACK_ONCE_FORWARD;

    /**
        Once ping pong.
    **/
    var PLAYBACK_ONCE_PINGPONG;
}
