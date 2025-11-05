package defold;

import defold.types.Hash;
import defold.types.HashOrStringOrUrl;
import defold.types.Vector3;

/** *
 * Functions for interacting with Box2D.
**/
@:native("_G.b2d")
extern class B2d {
	/**
	 * Get the Box2D body from a collision object
	 *
	 * @param url The url to the game object collision component.
	 * @return The body if successful. Otherwise `Null`.
	**/
	@:native('get_body')
	static function getBody(url:HashOrStringOrUrl):B2Body;

	/**
	 *	Get the Box2D world from the current collection.
	 *
	 *  @return The world if successful. Otherwise `Null`.
	**/
	@:native('get_world')
	static function getWorld():B2World;
}

/** *
 * Box2D world object
**/
extern abstract B2World(Hash) {}

/** *
 * Box2D body types
**/
@:native("_G.b2d.body")
extern enum abstract B2BodyType(Int) {
	/**
	 * Static bodies do not move
	**/
	@:native('BODY_TYPE_STATIC')
	var Static;

	/**
	 * Kinematic bodies are not subject to forces but can move with a linear velocity
	**/
	@:native('BODY_TYPE_KINEMATIC')
	var Kinematic;

	/**
	 * Dynamic bodies are fully simulated
	**/
	@:native('BODY_TYPE_DYNAMIC')
	var Dynamic;
}

@:native("_G.b2d.body")
extern class B2Body {
	/**
	 * Apply an angular impulse.
	 *
	 * @param body body
	 * @param impulse the angular impulse in units of `kgmm/s`
	**/
	@:native('apply_angular_impulse')
	static function applyAngularImpulse(body:B2Body, impulse:Float):Void;

	/**
	 * Apply a force at a world point. If the force is not applied at the center of mass, it will generate a torque and affect the angular velocity. This wakes up the body.
	 *
	 * @param body body
	 * @param force the world force vector, usually in Newtons (N).
	 * @param point the world position of the point of application.
	**/
	@:native('apply_force')
	static function applyForce(body:B2Body, force:Vector3, point:Vector3):Void;

	/**
	 * Apply a force to the center of mass. This wakes up the body.
	 *
	 * @param body body
	 * @param force the world force vector, usually in Newtons (N).
	**/
	@:native('apply_force_to_center')
	static function applyForceToCenter(body:B2Body, force:Vector3):Void;

	/**
	 * Apply an impulse at a point. This immediately modifies the velocity. It also modifies the angular velocity if the point of application is not at the center of mass. This wakes up the body.
	 *
	 * @param body body
	 * @param impulse the world impulse vector, usually in N-seconds or kg-m/s.
	 * @param point the world position of the point of application.
	**/
	@:native('apply_linear_impulse')
	static function applyLinearImpulse(body:B2Body, impulse:Vector3, point:Vector3):Void;

	/**
	 * Apply a torque. This affects the angular velocity without affecting the linear velocity of the center of mass. This wakes up the body.
	 *
	 * @param body body
	 * @param torque about the z-axis (out of the screen), usually in N-m.
	**/
	@:native('apply_torque')
	static function applyTorque(body:B2Body, torque:Float):Void;

	/**
	 * Get the angular damping of the body.
	 *
	 * @param body body
	 * @return the angular damping of the body.
	**/
	@:native('get_angular_damping')
	static function getAngularDamping(body:B2Body):Float;

	/**
	 * Get the angular velocity.
	 *
	 * @param body body
	 * @return the angular velocity in radians/second.
	**/
	@:native('get_angular_velocity')
	static function getAngularVelocity(body:B2Body):Float;

	/**
	 * Get the gravity scale of the body.
	 *
	 * @param body body
	 * @return the gravity scale of the body.
	**/
	@:native('get_gravity_scale')
	static function getGravityScale(body:B2Body):Float;

	/**
	 * Get the rotational inertia of the body about the local origin.
	 *
	 * @param body body
	 * @return the rotational inertia, usually in kg-m^2.
	**/
	@:native('get_inertia')
	static function getInertia(body:B2Body):Float;

	/**
	 * Get the linear damping of the body.
	 *
	 * @param body body
	 * @return the linear damping of the body.
	**/
	@:native('get_linear_damping')
	static function getLinearDamping(body:B2Body):Float;

	/**
	 * Get the linear velocity of the center of mass.
	 *
	 * @param body body
	 * @return the linear velocity of the center of mass.
	**/
	@:native('get_linear_velocity')
	static function getLinearVelocity(body:B2Body):Vector3;

	/**
	 * Get the local position of the center of mass.
	 *
	 * @param body body
	 * @return the local position of the center of mass.
	**/
	@:native('get_local_center')
	static function getLocalCenter(body:B2Body):Vector3;

	/**
	 * Gets a local point relative to the body's origin given a world point.
	 *
	 * @param body body
	 * @param world_point a point in world coordinates.
	 * @return the corresponding local point relative to the body's origin.
	**/
	@:native('get_local_point')
	static function getLocalPoint(body:B2Body, world_point:Vector3):Vector3;

	/**
	 * Gets a local vector given a world vector.
	 *
	 * @param body body
	 * @param world_vector a vector in world coordinates.
	 * @return the corresponding local vector.
	**/
	@:native('get_local_vector')
	static function getLocalVector(body:B2Body, world_vector:Vector3):Vector3;

	/**
	 * Get the total mass of the body.
	 *
	 * @param body body
	 * @return the mass, usually in kilograms (kg).
	**/
	@:native('get_mass')
	static function getMass(body:B2Body):Float;

	/**
	 * Get the world body origin position.
	 *
	 * @param body body
	 * @return the world position of the body's origin.
	**/
	@:native('get_position')
	static function getPosition(body:B2Body):Vector3;

	/**
	 * Get the body rotation.
	 *
	 * @param body body
	 * @return the current world rotation angle in radians.
	**/
	@:native('get_rotation')
	static function getRotation(body:B2Body):Float;

	/**
	 * Get the body type. A dynamic body is fully simulated. Static bodies do not move. Kinematic bodies are not subject to forces but can move with a linear velocity.
	 *
	 * @param body body
	 * @return the body type: Static, Kinematic, or Dynamic
	**/
	@:native('get_type')
	static function getType(body:B2Body):B2BodyType;

	/**
	 * Gets the Box2D world to which this body belongs.
	 *
	 * @param body body
	 * @return the world this body belongs to
	**/
	@:native('get_world')
	static function getWorld(body:B2Body):B2World;

	/**
	 * Get the world position of the center of mass.
	 *
	 * @param body body
	 * @return the world position of the center of mass.
	**/
	@:native('get_world_center')
	static function getWorldCenter(body:B2Body):Vector3;

	/**
	 * Get the world coordinates of a point given the local coordinates.
	 *
	 * @param body body
	 * @param local_point a point on the body measured relative the body's origin.
	 * @return the same point expressed in world coordinates.
	**/
	@:native('get_world_point')
	static function getWorldPoint(body:B2Body, local_point:Vector3):Vector3;

	/**
	 * Get the world coordinates of a vector given the local coordinates.
	 *
	 * @param body body
	 * @param local_vector a vector fixed in the body.
	 * @return the same vector expressed in world coordinates.
	**/
	@:native('get_world_vector')
	static function getWorldVector(body:B2Body, local_vector:Vector3):Vector3;

	/**
	 * Set the angular damping of the body.
	 *
	 * @param body body
	 * @param damping the new angular damping.
	**/
	@:native('set_angular_damping')
	static function setAngularDamping(body:B2Body, damping:Float):Void;

	/**
	 * Set the angular velocity.
	 *
	 * @param body body
	 * @param velocity the new angular velocity in radians/second.
	**/
	@:native('set_angular_velocity')
	static function setAngularVelocity(body:B2Body, velocity:Float):Void;

	/**
	 * Set the sleep state of the body. A sleeping body has very low CPU cost.
	 *
	 * @param body body
	 * @param awake set to true to wake the body, false to put it to sleep.
	**/
	@:native('set_awake')
	static function setAwake(body:B2Body, awake:Bool):Void;

	/**
	 * Set the bullet state of the body. Bullet bodies are subject to continuous collision detection with dynamic bodies.
	 *
	 * @param body body
	 * @param bullet set to true to enable continuous collision detection with dynamic bodies.
	**/
	@:native('set_bullet')
	static function setBullet(body:B2Body, bullet:Bool):Void;

	/**
	 * Set the fixed rotation state of the body. Fixed rotation bodies do not rotate.
	 *
	 * @param body body
	 * @param fixed_rotation set to true to prevent body from rotating.
	**/
	@:native('set_fixed_rotation')
	static function setFixedRotation(body:B2Body, fixed_rotation:Bool):Void;

	/**
	 * Set the gravity scale of the body.
	 *
	 * @param body body
	 * @param scale the new gravity scale.
	**/
	@:native('set_gravity_scale')
	static function setGravityScale(body:B2Body, scale:Float):Void;

	/**
	 * Set the linear damping of the body.
	 *
	 * @param body body
	 * @param damping the new linear damping.
	**/
	@:native('set_linear_damping')
	static function setLinearDamping(body:B2Body, damping:Float):Void;

	/**
	 * Set the linear velocity of the center of mass.
	 *
	 * @param body body
	 * @param velocity the new linear velocity of the center of mass.
	**/
	@:native('set_linear_velocity')
	static function setLinearVelocity(body:B2Body, velocity:Vector3):Void;

	/**
	 * Set the position of the body's origin.
	 *
	 * @param body body
	 * @param position the world position of the body's origin.
	**/
	@:native('set_position')
	static function setPosition(body:B2Body, position:Vector3):Void;

	/**
	 * Set the body rotation.
	 *
	 * @param body body
	 * @param angle the new rotation angle in radians.
	**/
	@:native('set_rotation')
	static function setRotation(body:B2Body, angle:Float):Void;

	/**
	 * Set the position and angle of the body.
	 *
	 * @param body body
	 * @param position the world position of the body's origin.
	 * @param angle the world rotation angle in radians.
	**/
	@:native('set_transform')
	static function setTransform(body:B2Body, position:Vector3, angle:Float):Void;

	/**
	 * Set the body type. A dynamic body is fully simulated. Static bodies do not move. Kinematic bodies are not subject to forces but can move with a linear velocity.
	 *
	 * @param body body
	 * @param type the body type: Static, Kinematic, or Dynamic
	**/
	@:native('set_type')
	static function setType(body:B2Body, type:B2BodyType):Void;
}
