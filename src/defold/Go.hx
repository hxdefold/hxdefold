package defold;

import haxe.extern.EitherType;
import defold.support.*;

/**
    Manipulation of game objects and core hooks for Lua script logic.

    See `GoMessages` for standard game object messages.
**/
@:native("_G.go")
extern class Go {
    /**
        Animates a named property of the specified game object or component.

        This is only supported for numerical properties.
        If the node property is already being animated, that animation will be canceled and replaced by the new one.
    **/
    // TODO: easing is actually not a Vector3 but any vector created by Vmath.vector and we don't have a type for it right now.
    static function animate(url:HashOrStringOrUrl, property:HashOrString, playback:GoPlayback, to:EitherType<Vector3,EitherType<Quaternion,Float>>, easing:EitherType<GoEasing,Vector3>, duration:Float, ?delay:Float, ?complete_function:Void->Void):Void;

    /**
        Cancels all animations of the named property of the specified game object or component.

        By calling this function, all stored animations of the given property will be canceled.
    **/
    static function cancel_animations(url:HashOrStringOrUrl, property:HashOrString):Void;

    /**
        Deletes a game object instance.

        If the `id` of the instance to delete is not specified, the instance of the calling script is deleted.
    **/
    static function delete(?id:HashOrStringOrUrl):Void;

    /**
        Deletes a set of game object instance.

        Delete all game objects simultaneously as listed in table.
        The table values (not keys) should be game object ids (hashes).
    **/
    static function delete_all(?ids:lua.Table<Int,Hash>):Void;

    /**
        Gets a named property of the specified game object or component.
    **/
    static function get(url:HashOrStringOrUrl, id:HashOrString):GoProperty;

    /**
        Gets the id of an instance.

        The instance id is a hash of the absolute path.
        If path is specified, it can either be absolute or relative to the instance of the calling script.
        If path is not specified, the id of the instance of the calling script will be returned.
    **/
    static function get_id(?path:String):Hash;

    /**
        Gets the position of the instance.

        The position is relative the parent (if any).
        Use `Go.get_world_position` to retrieve the global world position.
    **/
    static function get_position(?id:HashOrStringOrUrl):Vector3;

    /**
        Gets the rotation of the instance.

        The rotation is relative to the parent (if any).
        Use `Go.get_world_rotation` to retrieve the global world position.
    **/
    static function get_rotation(?id:HashOrStringOrUrl):Quaternion;

    /**
        Gets the uniform scale factor of the instance.

        The uniform scale is relative the parent (if any).
        Use `Go.get_world_scale` to retrieve the global world scale factor.
    **/
    static function get_scale(?id:HashOrStringOrUrl):Float;

    /**
        Gets the 3D scale factor of the instance.

        The scale is relative the parent (if any).
        Use `Go.get_world_scale` to retrieve the global world scale factor.
    **/
    static function get_scale_vector(?id:HashOrStringOrUrl):Vector3;

    /**
        Gets the instance world position.

        Use `Go.get_position` to retrieve the position relative to the parent.
    **/
    static function get_world_position(?id:HashOrStringOrUrl):Vector3;

    /**
        Gets the instance world rotation.

        Use `Go.get_rotation` to retrieve the rotation relative to the parent.
    **/
    static function get_world_rotation(?id:HashOrStringOrUrl):Quaternion;

    /**
        Gets the instance world scale factor.

        Use `Go.get_scale` to retrieve the scale factor relative to the parent.
    **/
    static function get_world_scale(?id:HashOrStringOrUrl):Float;

    /**
        Define a property to be used throughout the script.

        This function defines a property which can then be used in the script through the self-reference.
        The properties defined this way are automatically exposed in the editor in game objects and collections which use the script.
        Note that you can only use this function outside any callback-functions like init and update.
    **/
    // calling this function has no effect when called from inside a module,
    // so there's no reason to expose this API, since it won't work
    // as an alternative, ScriptMacro will generate `go.property` calls for script data fields
    // having the `@property` meta
    // static function property(name:String, def:GoProperty):Void;

    /**
        Sets a named property of the specified game object or component.
    **/
    static function set(url:HashOrStringOrUrl, id:HashOrString, value:GoProperty):Void;

    /**
        Sets the position of the instance.

        The position is relative to the parent (if any).
        The global world position cannot be manually set.
    **/
    static function set_position(position:Vector3, ?id:HashOrStringOrUrl):Void;

    /**
        Sets the rotation of the instance.

        The rotation is relative to the parent (if any).
        The global world rotation cannot be manually set.
    **/
    static function set_rotation(rotation:Quaternion, ?id:HashOrStringOrUrl):Void;

    /**
        Sets the scale factor of the instance.

        The scale factor is relative to the parent (if any).
        The global world scale factor cannot be manually set.
        NOTE! Physics are currently not affected when setting scale from this function.
    **/
    static function set_scale(rotation:EitherType<Float,Vector3>, ?id:HashOrStringOrUrl):Void;
}

/**
    Messages handled by game objects and components.
**/
@:publicFields
class GoMessages {
    /**
        Acquires the user input focus.
    **/
    static var AcquireInputFocus(default,never) = new Message<Void>("acquire_input_focus");

    /**
        Disables the receiving component.
    **/
    static var Disable(default,never) = new Message<Void>("disable");

    /**
        Enables the receiving component.
    **/
    static var Enable(default,never) = new Message<Void>("enable");

    /**
        Releases the user input focus.
    **/
    static var ReleaseInputFocus(default,never) = new Message<Void>("release_input_focus");

    /**
        Requests the transform from an instance.

        DEPRECATED! See the functions `Go.get_position`, `Go.get_rotation`, etc.
        for a simpler way to obtain the transform of another game object instance.

        Send this message to an instance to request its transform (position, rotation, scale).
        The sending script will receive the answer as a `TransformResponse` message at a later time.
    **/
    @:deprecated("See the functions Go.get_position, Go.get_rotation, etc. for a simpler way to obtain the transform of another game object instance.")
    static var RequestTransform(default,never) = new Message<Void>("request_transform");

    /**
        Sets the parent of the receiving instance.

        When this message is sent to an instance, it sets the parent of that instance.
        This means that the instance will exist in the geometrical space of its parent, like a basic transformation hierarchy or scene graph.

        If no parent is specified, the instance will be detached from any parent and exist in world space.

        A script can send this message to itself to set the parent of its instance.
    **/
    static var SetParent(default,never) = new Message<{?parent_id:Hash, ?keep_world_transform:Int}>("set_parent");

    /**
        Reports back the transform of an instance.

        DEPRECATED! See the functions `Go.get_position`, `Go.get_rotation`, etc.
        for a simpler way to obtain the transform of another game object instance.

        The response a script receives after it has requested the transform from an instance using the `RequestTransform` message.
        See the description of that message for a complete example on how to use it.
    **/
    @:deprecated("See the functions Go.get_position, Go.get_rotation, etc. for a simpler way to obtain the transform of another game object instance.")
    static var TransformResponse(default,never) = new Message<GoMessageTransformResponse>("transform_response");
}

/**
    Data for the `GoMessages.TransformResponse` message.

    DEPRECATED! See the functions `Go.get_position`, `Go.get_rotation`, etc.
    for a simpler way to obtain the transform of another game object instance.
**/
@:deprecated("See the functions Go.get_position, Go.get_rotation, etc. for a simpler way to obtain the transform of another game object instance.")
typedef GoMessageTransformResponse = {
    var position:Vector3;
    var rotation:Quaternion;
    var scale:Float;
    var world_position:Vector3;
    var world_rotation:Quaternion;
    var world_scale:Float;
}

/**
    Possible types of a game object property.
**/
typedef GoProperty = EitherType<Float,EitherType<Hash,EitherType<Url,EitherType<Vector3,EitherType<Vector4,EitherType<Quaternion,Bool>>>>>>;

/**
    Game object easing constants.
**/
@:native("_G.go")
@:enum extern abstract GoEasing({}) {
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

/**
    Game object playback constants.
**/
@:native("_G.go")
@:enum extern abstract GoPlayback({}) {
    var PLAYBACK_ONCE_FORWARD;
    var PLAYBACK_ONCE_BACKWARD;
    var PLAYBACK_ONCE_PINGPONG;
    var PLAYBACK_LOOP_FORWARD;
    var PLAYBACK_LOOP_BACKWARD;
    var PLAYBACK_LOOP_PINGPONG;
}
