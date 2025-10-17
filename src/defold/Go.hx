package defold;

import haxe.extern.EitherType;
import defold.types.*;
import defold.types.util.LuaArray;

/**
	Functions, core hooks, messages and constants for manipulation of
	game objects. The "go" namespace is accessible from game object script
	files.

	See `GoProperties` for related properties.
	See `GoMessages` for related messages.
**/
@:native("_G.go")
extern final class Go {
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
		@param completeFunction function with parameters (url, property) to call when the animation has completed
	**/
	static inline function animate<T>(url:HashOrStringOrUrl, property:Property<T>, playback:GoPlayback, to:T, easing:EitherType<GoEasing, Vector>,
			duration:Float, delay:Float = 0, ?completeFunction:(Url, Property<T>) -> Void):Void {
		// 1. hide the reall callback parameter which expects a function with a "self" argument
		// 2. ensure that the global self reference is present for the callback
		animate_(url, cast property, playback, cast to, easing, duration, delay, completeFunction == null ? null : (self, url, property) -> {
			untyped __lua__('_G._hxdefold_self_ = {0}', self);
			completeFunction(url, property);
			untyped __lua__('_G._hxdefold_self_ = nil');
		});
	}

	@:native('animate') private static function animate_(url:HashOrStringOrUrl, property:HashOrString, playback:GoPlayback, to:GoAnimatedProperty,
		easing:EitherType<GoEasing, Vector>, duration:Float, ?delay:Float, ?completeFunction:(Any, Url, Hash) -> Void):Void;

	/**
		Cancels all animations of the named property of the specified game object or component.

		By calling this function, all or specified stored property animations of the game object or component will be canceled.
		See the [properties guide](https://defold.com/manuals/properties/) for which properties can be animated and
		the [animation guide](https://defold.com/manuals/animation/) for how to animate them..

		@param url url of the game object or component having the property
		@param property optional id of the property to cancel
	**/
	@:native('cancel_animations')
	@:overload(function(url:HashOrStringOrUrl, ?property:HashOrString):Void {})
	static function cancelAnimations<T>(url:HashOrStringOrUrl, ?property:Property<T>):Void;

	/**
		Delete one or more game objects identified by id. Deletion is asynchronous meaning that
		the game object(s) are scheduled for deletion which will happen at the end of the current
		frame. Note that game objects scheduled for deletion will be counted against
		`max_instances` in "game.project" until they are actually removed.

		@param id optional id or table of id's of the instance(s) to delete, the instance of the calling script is deleted by default
		@param recursive optional boolean, set to true to recursively delete child hiearchy in child to parent order
	**/
	@:overload(function(?ids:LuaArray<Hash>, ?recursive:Bool):Void {})
	static function delete(?id:HashOrStringOrUrl, ?recursive:Bool):Void;

	/**
		Check if the specified game object exists.

		@param url url of the game object to check
		@return `true` if the game object exists
	**/
	@:pure
	static function exists(url:HashOrStringOrUrl):Bool;

	/**
		Gets a named property of the specified game object or component.

		@param url url of the game object or component having the property
		@param id id of the property to retrieve
		@param options (optional) options table - index integer index into array property (1 based) - key hash name of internal property
		@return the value of the specified property
	**/
	@:pure
	@:overload(function(url:HashOrStringOrUrl, id:HashOrString, ?options:lua.Table.AnyTable):GoProperty {})
	static function get<T>(url:HashOrStringOrUrl, id:Property<T>, ?options:lua.Table.AnyTable):T;

	/**
		Returns or constructs an instance identifier. The instance id is a hash
		of the absolute path to the instance.

		If `path` is specified, it can either be absolute or relative to the instance of the calling script.
		If `path` is not specified, the id of the game object instance the script is attached to will be returned.

		@param path path of the instance for which to return the id
		@return instance id
	**/
	@:pure
	@:native('get_id')
	static function getId(?path:String):Hash;

	/**
		Gets the position of a game object instance.

		The position is relative the parent (if any).
		Use `Go.get_world_position` to retrieve the global world position.

		@param id optional id of the game object instance to get the position for, by default the instance of the calling script
		@return instance position
	**/
	@:pure
	@:native('get_position')
	static function getPosition(?id:HashOrStringOrUrl):Vector3;

	/**
		Gets the rotation of the game object instance.

		The rotation is relative to the parent (if any).
		Use `Go.get_world_rotation` to retrieve the global world position.

		@param id optional id of the game object instance to get the rotation for, by default the instance of the calling script
		@return instance rotation
	**/
	@:pure
	@:native('get_rotation')
	static function getRotation(?id:HashOrStringOrUrl):Quaternion;

	/**
		Gets the 3D scale factor of the game object instance.

		The scale is relative the parent (if any).
		Use `Go.get_world_scale` to retrieve the global world 3D scale factor.

		@param id optional id of the game object instance to get the scale for, by default the instance of the calling script
		@return instance scale factor
	**/
	@:pure
	@:native('get_scale')
	static function getScale(?id:HashOrStringOrUrl):Vector3;

	/**
		Gets the uniform scale factor of the game object instance.

		The uniform scale is relative the parent (if any).
		If the underlying scale vector is non-uniform the min element of the vector is returned as the uniform scale factor.

		@param id optional id of the game object instance to get the uniform scale for, by default the instance of the calling script
		@return uniform instance scale factor
	**/
	@:pure
	@:native('get_scale_uniform')
	static function getScaleUniform(?id:HashOrStringOrUrl):Float;

	/**
		Get the parent for a game object instance.

		@param id optional id of the game object instance to get parent for, defaults to the instance containing the calling script
		@param parent instance or nil
	**/
	@:pure
	@:native('get_parent')
	static function getParent(?id:HashOrStringOrUrl):Hash;

	/**
		Gets the game object instance world position.

		Use `Go.get_position` to retrieve the position relative to the parent.

		@param id optional id of the game object instance to get the world position for, by default the instance of the calling script
		@return instance world position
	**/
	@:pure
	@:native('get_world_position')
	static function getWorldPosition(?id:HashOrStringOrUrl):Vector3;

	/**
		Gets the game object instance world rotation.

		Use `Go.get_rotation` to retrieve the rotation relative to the parent.

		@param id optional id of the game object instance to get the world rotation for, by default the instance of the calling script
		@return instance world rotation
	**/
	@:pure
	@:native('get_world_rotation')
	static function getWorldRotation(?id:HashOrStringOrUrl):Quaternion;

	/**
		Gets the game object instance world 3D scale factor.

		Use `Go.get_scale` to retrieve the 3D scale factor relative to the parent.
		This vector is derived by decomposing the transformation matrix and should be used with care.
		For most cases it should be fine to use `Go.get_world_scale_uniform` instead.

		@param id optional id of the game object instance to get the world scale for, by default the instance of the calling script
		@return uniform instance world scale factor
	**/
	@:pure
	@:native('get_world_scale')
	static function getWorldScale(?id:HashOrStringOrUrl):Vector3;

	/**
		Gets the uniform game object instance world scale factor.

		Use `go.get_scale_uniform` to retrieve the scale factor relative to the parent.

		@param id optional id of the game object instance to get the world scale for, by default the instance of the calling script
		@return instance world scale factor
	**/
	@:pure
	@:native('get_world_scale_uniform')
	static function getWorldScaleUniform(?id:HashOrStringOrUrl):Float;

	/**
		Gets the world transform of a game object instance.

		@param id optional id of the game object instance to get the world transform for, by default the instance of the calling script
		@return instance world transform
	**/
	@:pure
	@:native('get_world_transform')
	static function getWorldTransform(?id:HashOrStringOrUrl):Matrix4;

	/**
		Sets a named property of the specified game object or component.

		@param url url of the game object or component having the property
		@param id id of the property to set
		@param options (optional) options table - index integer index into array property (1 based) - key hash name of internal property
		@param value the value to set
	**/
	@:overload(function(url:HashOrStringOrUrl, id:HashOrString, value:GoProperty, ?options:lua.Table.AnyTable):Void {})
	static function set<T>(url:HashOrStringOrUrl, id:Property<T>, value:T, ?options:lua.Table.AnyTable):Void;

	/**
		Sets the parent for a game object instance. This means that the instance will exist in the geometrical space of its parent,
		like a basic transformation hierarchy or scene graph. If no parent is specified, the instance will be detached from any parent and exist in world space.

		@param id optional id of the game object instance to set parent for, defaults to the instance containing the calling script
		@param parent_id optional id of the new parent game object, defaults to detaching game object from its parent
		@param keepWorldTransform optional boolean, set to true to maintain the world transform when changing spaces. Defaults to false.
	**/
	@:native('set_parent')
	static function setParent(?id:HashOrStringOrUrl, ?parent_id:HashOrStringOrUrl, ?keepWorldTransform:Bool):Void;

	/**
		Sets the position of the game object instance.

		The position is relative to the parent (if any).
		The global world position cannot be manually set.

		@param position position to set
		@param id optional id of the game object instance to set the position for, by default the instance of the calling script
	**/
	@:native('set_position')
	static function setPosition(position:Vector3, ?id:HashOrStringOrUrl):Void;

	/**
		Sets the rotation of the game object instance.

		The rotation is relative to the parent (if any).
		The global world rotation cannot be manually set.

		@param rotation rotation to set
		@param id optional id of the game object instance to get the rotation for, by default the instance of the calling script
	**/
	@:native('set_rotation')
	static function setRotation(rotation:Quaternion, ?id:HashOrStringOrUrl):Void;

	/**
		Sets the scale factor of the game object instance.

		The scale factor is relative to the parent (if any). The global world scale factor cannot be manually set.

		*NOTE!* Physics are currently not affected when setting scale from this function.

		@param scale vector or uniform scale factor, must be greater than 0
		@param id optional id of the game object instance to get the scale for, by default the instance of the calling script
	**/
	@:native('set_scale')
	static function setScale(scale:EitherType<Float, Vector3>, ?id:HashOrStringOrUrl):Void;

	/**
		Sets the XY scale factor of the game object instance without affecting Z.

		Use this function when you want to scale in 2D while leaving the Z scale unchanged.

		@param scale uniform or vector scale where x/y are applied; z is preserved
		@param id optional id of the game object instance to set the scale for, defaults to the caller
	 */
	@:native('set_scale_xy')
	static function setScaleXY(scale:EitherType<Float, Vector3>, ?id:HashOrStringOrUrl):Void;
}

/**
	Properties related to the `Go` module.
**/
@:publicFields
class GoProperties {
	/**
		The rotation of the game object expressed in Euler angles.
		Euler angles are specified in degrees in the interval (-360, 360).
	**/
	static var euler(default, never) = new Property<Vector3>("euler");

	/**
		The rotation of the game object around the x-axis expressed in Eulrer angles.
		Euler angles are specified in degrees in the interval (-360, 360).
	**/
	static var eulerX(default, never) = new Property<Float>("euler.x");

	/**
		The rotation of the game object around the y-axis expressed in Eulrer angles.
		Euler angles are specified in degrees in the interval (-360, 360).
	**/
	static var eulerY(default, never) = new Property<Float>("euler.y");

	/**
		The rotation of the game object around the z-axis expressed in Eulrer angles.
		Euler angles are specified in degrees in the interval (-360, 360).
	**/
	static var eulerZ(default, never) = new Property<Float>("euler.z");

	/**
		The position of the game object.
	**/
	static var position(default, never) = new Property<Vector3>("position");

	/**
		The position of the game object on the x-axis.
	**/
	static var positionX(default, never) = new Property<Float>("position.x");

	/**
		The position of the game object on the y-axis.
	**/
	static var positionY(default, never) = new Property<Float>("position.y");

	/**
		The position of the game object on the z-axis.
	**/
	static var positionZ(default, never) = new Property<Float>("position.z");

	/**
		The rotation of the game object.
	**/
	static var rotation(default, never) = new Property<Quaternion>("rotation");

	/**
		The x-component of the game object's rotation quaternion.
	**/
	static var rotationX(default, never) = new Property<Float>("rotation.x");

	/**
		The y-component of the game object's rotation quaternion.
	**/
	static var rotationY(default, never) = new Property<Float>("rotation.y");

	/**
		The z-component of the game object's rotation quaternion.
	**/
	static var rotationZ(default, never) = new Property<Float>("rotation.z");

	/**
		The w-component of the game object's rotation quaternion.
	**/
	static var rotationW(default, never) = new Property<Float>("rotation.w");

	/**
		The uniform scale of the game object.
	**/
	static var scale(default, never) = new Property<Float>("scale");

	/**
		The x-component of the scale of the game object.
	**/
	static var scaleX(default, never) = new Property<Float>("scale.x");

	/**
		The y-component of the scale of the game object.
	**/
	static var scaleY(default, never) = new Property<Float>("scale.y");

	/**
		The z-component of the scale of the game object.
	**/
	static var scaleZ(default, never) = new Property<Float>("scale.z");
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
		   * Model
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
		   * Model
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
	var ?parent_id:Hash;

	/**
		if the world transform of the instance should be preserved when changing spaces, 0 for false and 1 for true. The default value is 1.
	**/
	var ?keep_world_transform:Int;
}

/**
	Possible types of a game object property.
**/
abstract GoProperty(Dynamic) from Int to Int from Float to Float from Hash to Hash from Url to Url from Vector3 to Vector3 from Vector4 to Vector4
	from Quaternion to Quaternion from Bool to Bool from AtlasResourceReference to AtlasResourceReference from FontResourceReference to FontResourceReference
	from MaterialResourceReference to MaterialResourceReference from TextureResourceReference to TextureResourceReference from TileSourceResourceReference
	to TileSourceResourceReference from BufferResourceReference to BufferResourceReference from LuaArray<Int> to LuaArray<Int> from LuaArray<Float>
	to LuaArray<Float> from LuaArray<Vector3> to LuaArray<Vector3> from LuaArray<Vector4> to LuaArray<Vector4> {}

/**
	Possible types of game object property suitable for animation.
**/
abstract GoAnimatedProperty(Dynamic) from Vector3 to Vector3 from Vector4 to Vector4 from Quaternion to Quaternion from Float to Float {}

/**
	Game object easing constants.
**/
@:native("_G.go")
extern enum abstract GoEasing(Int) {
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

/**
	Game object playback constants.
**/
@:native("_G.go")
extern enum abstract GoPlayback(Int) {
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
	var LoopPingPong;

	/**
		No playback.
	**/
	@:native('PLAYBACK_NONE')
	var None;

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
