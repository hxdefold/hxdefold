package defold;

import defold.types.PhysicsShape.PhysicsShapeWrapper;
import defold.types.PhysicsShape.PhysicsShapeData;
import defold.types.*;
import haxe.extern.EitherType;
import defold.types.util.LuaArray;

/**
    Functions and messages for collision object physics interaction
    with other objects (collisions and ray-casting) and control of
    physical behaviors.

    See `PhysicsProperties` for related properties.
    See `PhysicsMessages` for related messages.
**/
@:native("_G.physics")
extern final class Physics
{
    /**
        Requests a ray cast to be performed.

        Ray casts are used to test for intersections against collision objects in the physics world.
        Collision objects of types kinematic, dynamic and static are tested against. Trigger objects
        do not intersect with ray casts.
        Which collision objects to hit is filtered by their collision groups and can be configured
        through `groups`.
        The actual ray cast will be performed during the physics-update.

        @param from the world position of the start of the ray
        @param to the world position of the end of the ray
        @param groups a lua table containing the hashed groups for which to test collisions against
        @param options a lua table containing options for the raycast
    **/
    @:pure
    static function raycast(from:Vector3, to:Vector3, groups:LuaArray<Hash>, ?options:PhysicsRaycastOptions):LuaArray<PhysicsMessageRayCastResponse>;

    /**
        Requests a ray cast to be performed.

        Ray casts are used to test for intersections against collision objects in the physics world.
        Collision objects of types kinematic, dynamic and static are tested against. Trigger objects
        do not intersect with ray casts.
        Which collision objects to hit is filtered by their collision groups and can be configured through `groups`.
        The actual ray cast will be performed during the physics-update.

         * If an object is hit, the result will be reported via a `ray_cast_response` message.
         * If there is no object hit, the result will be reported via a `ray_cast_missed` message.

        @param from the world position of the start of the ray
        @param to the world position of the end of the ray
        @param groups a lua table containing the hashed groups for which to test collisions against
        @param request_id a number between [0,-255]. It will be sent back in the response for identification, 0 by default
    **/
    @:native('raycast_async')
    static function raycastAsync(from:Vector3, to:Vector3, groups:LuaArray<Hash>, ?request_id:Int):Void;

    /**
        Get the gravity in runtime. The gravity returned is not global,
        it will return the gravity for the collection that the function is called from.

        Note: For 2D physics the z component will always be zero.
    **/
    @:pure
    @:native('get_gravity')
    static function getGravity():Vector3;

    /**
        physics.set_gravity(gravity)

        Set the gravity in runtime. The gravity change is not global,
        it will only affect the collection that the function is called from.

        Note: For 2D physics the z component of the gravity vector will be ignored.
        @param gravity the new gravity vector
    **/
    @:native('set_gravity')
    static function setGravity(gravity:Vector3):Void;

    /**
        Flips the collision shapes horizontally for a collision object

        @param url the collision object that should flip its shapes
        @param flip `true` if the collision object should flip its shapes, `false` if not
    **/
    @:native('set_hflip')
    static function setHflip(url:HashOrStringOrUrl, flip:Bool):Void;

    /**
        Flips the collision shapes vertically for a collision object

        @param url the collision object that should flip its shapes
        @param flip `true` if the collision object should flip its shapes, `false` if not
    **/
    @:native('set_vflip')
    static function setVflip(url:HashOrStringOrUrl, flip:Bool):Void;

    /**
        Collision objects tend to fall asleep when inactive for a small period of time for efficiency reasons. This function wakes them up.

        @param url the collision object that should wake up
    **/
    static function wakeup(url:HashOrStringOrUrl):Void;

    /**
        Updates the group property of a collision object to the specified string value.
        The group name should exist i.e. have been used in a collision object in the editor.

        @param url the collision object affected
        @param group the new group name to be assigned
    **/
    @:native('set_group')
    static function setGroup(url:HashOrStringOrUrl, group: String):Void;

    /**
        Returns the group name of a collision object as a hash.

        @param url the collision object to return the group of
        @return hash value of the group
    **/
    @:native('get_group')
    static function getGroup(url:HashOrStringOrUrl):Hash;

    /**
        Sets or clears the masking of a group (maskbit) in a collision object.

        @param url the collision object to change the mask of
        @param group the name of the group (maskbit) to modify in the mask
        @param maskbit boolean value of the new maskbit. `true` to enable, `false` to disable
    **/
    @:native('set_maskbit')
    static function setMaskbit(url:HashOrStringOrUrl, group:String, maskbit:Bool):Void;

    /**
        Returns `true` if the specified group is set in the mask of a collision object, `false` otherwise

        @param url the collision object to check the mask of
        @param group the name of the group to check for
        @return boolean value of the maskbit. `true` if present, `false` otherwise
    **/
    @:pure
    @:native('get_maskbit')
    static function getMaskbit(url:HashOrString, group:String):Bool;

    /**
        Create a physics joint between two collision object components.

        Note: Currently only supported in 2D physics.
        @param joint_type the joint type
        @param collisionobjectA first collision object
        @param jointId id of the joint
        @param positionA local position where to attach the joint on the first collision object
        @param collisionobjectB second collision object
        @param positionB local position where to attach the joint on the second collision object
        @param properties optional joint specific properties table See each joint type for possible properties field.
    **/
    @:native('create_joint')
    @:overload(function(joint_type:PhysicsJointType, collisionobjectA:HashOrStringOrUrl, jointId:HashOrString,
        position_A:Vector3, collisionobjectB:HashOrStringOrUrl, position_B:Vector3, ?properties:PhysicsHingeJoint):Void {})
    @:overload(function(joint_type:PhysicsJointType, collisionobjectA:HashOrStringOrUrl, jointId:HashOrString,
        position_A:Vector3, collisionobjectB:HashOrStringOrUrl, position_B:Vector3, ?properties:PhysicsSliderJoint):Void {})
    @:overload(function(joint_type:PhysicsJointType, collisionobjectA:HashOrStringOrUrl, jointId:HashOrString,
        position_A:Vector3, collisionobjectB:HashOrStringOrUrl, position_B:Vector3, ?properties:PhysicsSpringJoint):Void {})
    static function createJoint(joint_type:PhysicsJointType, collisionobjectA:HashOrStringOrUrl, jointId:HashOrString,
        position_A:Vector3, collisionobjectB:HashOrStringOrUrl, position_B:Vector3, ?properties:PhysicsFixedJoint):Void;

    /**
        Destroy an already physics joint. The joint has to be created before a destroy can be issued.

        Note: Currently only supported in 2D physics.
        @param collisionobject collision object where the joint exist
        @param jointId id of the joint
    **/
    @:native('destroy_joint')
    static function destroyJoint(collisionobject:HashOrStringOrUrl, jointId:HashOrString):Void;

    /**
        Get a table for properties for a connected joint. The joint has to be created before properties can be retrieved.

        Note: Currently only supported in 2D physics.
        @param collisionobject collision object where the joint exist
        @param jointId id of the joint
        @return properties table. See the joint types for what fields are available
    **/
    @:pure
    @:native('get_joint_properties')
    static function getJointProperties(collisionobject:HashOrStringOrUrl, jointId:HashOrString):EitherType<PhysicsFixedJoint,
        EitherType<PhysicsHingeJoint, EitherType<PhysicsSliderJoint, PhysicsSpringJoint>>>;

    /**
        Get the reaction force for a joint. The joint has to be created before the reaction force can be calculated.

        Note: Currently only supported in 2D physics.
        @param collisionobject collision object where the joint exist
        @param jointId id of the joint
        @return reaction force for the joint
    **/
    @:pure
    @:native('get_joint_reaction_force')
    static function getJointReactionForce(collisionobject:HashOrStringOrUrl, jointId:HashOrString):Vector3;

    /**
        Get the reaction torque for a joint. The joint has to be created before the reaction torque can be calculated.

        Note: Currently only supported in 2D physics.
        @param collisionobject collision object where the joint exist
        @param jointId id of the joint
        @return the reaction torque on bodyB in N*m.
    **/
    @:pure
    @:native('get_joint_reaction_torque')
    static function getJointReactionTorque(collisionobject:HashOrStringOrUrl, jointId:HashOrString):Float;

    /**
        Updates the properties for an already connected joint. The joint has to be created before properties can be changed.

        Note: Currently only supported in 2D physics.
        @param collisionobject collision object where the joint exist
        @param jointId id of the joint
        @param properties joint specific properties table
        Note: The collide_connected field cannot be updated/changed after a connection has been made.
    **/
    @:native('set_joint_properties')
    @:overload(function(collisionobject:HashOrStringOrUrl, jointId:HashOrString, properties:PhysicsHingeJoint):Void {})
    @:overload(function(collisionobject:HashOrStringOrUrl, jointId:HashOrString, properties:PhysicsSliderJoint):Void {})
    @:overload(function(collisionobject:HashOrStringOrUrl, jointId:HashOrString, properties:PhysicsSpringJoint):Void {})
    static function setJointProperties(collisionobject:HashOrStringOrUrl, jointId:HashOrString, properties:PhysicsFixedJoint):Void;

    /**
        Gets collision shape data from a collision object

        @param url the collision object
        @param shapeName the name of the shape to get data for
        @return the physics shape
    **/
    @:pure
    static inline function getShape(url:HashOrString, shapeName:HashOrString):PhysicsShape
    {
        return getShape_(url, shapeName).toPhysicsShape();
    }
    @:native('get_shape') static private function getShape_(url:HashOrString, shapeName:HashOrString):PhysicsShapeWrapper;

    /**
        Gets collision shape data from a collision object

        @param url the collision object
        @param shapeName the name of the shape to get data for
        @param shape the physics shape
    **/
    static inline function setShape(url:HashOrString, shapeName:HashOrString, shape:PhysicsShape)
    {
        setShape_(url, shapeName, PhysicsShapeWrapper.fromPhysicsShape(shape));
    }
    @:native('set_shape') static private function setShape_(url:HashOrString, shapeName:HashOrString, shape:PhysicsShapeData):Void;

    /**
     * The function recalculates the density of each shape based on the total area of all shapes and the specified mass, then updates the mass of the body accordingly.
     * Note: Currently only supported in 2D physics.
     *
     * @param collisionobject the collision object whose mass needs to be updated
     * @param mass the new mass value to set for the collision object
     */
    @:native('update_mass')
    static function updateMass(collisionobject:HashOrStringOrUrl, mass:Float):Void;
    
    static inline function setListener<Tdata>(callback:(event:PhysicsEvent<Tdata>, data:Tdata)->Void):Void
        {
            setListener_((self, event:PhysicsEvent<Tdata>, data:Tdata) ->
            {
                // Properly casting the event from Hash to PhysicsEvent<Tdata>
                // var physicsEvent:PhysicsEvent<Tdata> = cast event;
        
                // Assuming that the data needs to be cast as well
                // var eventData:Tdata = cast data;
        
                untyped __lua__('_G._hxdefold_self_ = {0}', self);
                callback(event, data);
                untyped __lua__('_G._hxdefold_self_ = nil');
            });
        }
            
    @:native('set_listener') 
    private static function setListener_<Tdata>(callback:(Any, PhysicsEvent<Tdata>, Tdata)->Void):Void;
}

enum abstract PhysicsEvent<T>(Hash) {
    @:pure
    public inline function new(s:String) this = Defold.hash(s);
    // public static var triggerEvent:PhysicsEvent<TriggerEventData> = new PhysicsEvent("trigger_event");
    public static var contactPointEvent(default, never) = new PhysicsEvent<ContactPointData>("contact_point_event");
    public static var collisionEvent(default, never) = new PhysicsEvent<CollisionData>("collision_event");
    public static var triggerEvent(default, never) = new PhysicsEvent<TriggerEventData>("trigger_event");
    public static var rayCastResponse(default, never) = new PhysicsEvent<RayCastResponseData>("ray_cast_response");
    public static var rayCastMissed(default, never) = new PhysicsEvent<RayCastMissedData>("ray_cast_missed");
}

typedef ContactPointData = {
    var distance:Float;
    var applied_impulse:Float;
    var a:ObjectData;
    var b:ObjectData;
};

typedef CollisionData = {
    var a:ObjectData;
    var b:ObjectData;
};

typedef ObjectData = {
    var position:Vector3;
    var relative_velocity:Vector3;
    var mass:Float;
    var group:Hash;
    var id:Hash;
    var normal:Vector3;
};

typedef TriggerEventData = {
    var enter:Bool;
    var a:ObjectData;
    var b:ObjectData;
};

typedef RayCastResponseData = {
    var group:Hash;
    var request_id:Int;
    var position:Vector3;
    var fraction:Float;
    var normal:Vector3;
    var id:Hash;
};

typedef RayCastMissedData = {
    var request_id:Int;
};

/**
    Properties related to the `Physics` module.
**/
@:publicFields
class PhysicsProperties
{
    /**
        collision object angular damping.

        The angular damping value for the collision object. Setting this value alters the damping of
        angular motion of the object (rotation). Valid values are between 0 (no damping) and 1 (full damping).
    **/
    static var angular_damping(default, never) = new Property<Float>("angular_damping");

    /**
        collision object angular velocity.

        (READ ONLY) Returns the current angular velocity of the collision object component as a `Vector3`.
        The velocity is measured as a rotation around the vector with a speed equivalent to the vector length
        in radians/s.
    **/
    static var angular_velocity(default, never) = new Property<Vector3>("angular_velocity");

    /**
        The linear damping value for the collision object. Setting this value alters the damping of
        linear motion of the object. Valid values are between 0 (no damping) and 1 (full damping).
    **/
    static var linear_damping(default, never) = new Property<Float>("linear_damping");

    /**
        collision object linear velocity.

        (READ ONLY) Returns the current linear velocity of the collision object component as a vector3.
        The velocity is measured in units/s (pixels/s).
    **/
    static var linear_velocity(default, never) = new Property<Vector3>("linear_velocity");

    /**
        collision object mass.

        (READ ONLY) Returns the defined physical mass of the collision object component as a number.
    **/
    static var mass(default, never) = new Property<Float>("mass");
}

/**
    Messages related to the `Physics` module.
**/
@:publicFields
final class PhysicsMessages
{
    /**
        Applies a force on a collision object.

        Post this message to a collision-object-component to apply the specified force on the collision object.
        The collision object must be dynamic.
    **/
    static var apply_force(default, never) = new Message<PhysicsMessageApplyForce>("apply_force");

    /**
        Reports a collision between two collision objects.

        This message is broadcasted to every component of an instance that has a collision object, when the collision
        object collides with another collision object. For a script to take action when such a collision happens, it
        should check for this message in its `on_message` callback function.

        This message only reports that a collision actually happened and will only be sent once per colliding pair and frame.
        To retrieve more detailed information, check for the `contact_point_response` instead.
    **/
    static var collision_response(default, never) = new Message<PhysicsMessageCollisionResponse>("collision_response");

    /**
        Reports a contact point between two collision objects.

        This message is broadcasted to every component of an instance that has a collision object, when the collision
        object has contact points with respect to another collision object. For a script to take action when
        such contact points occur, it should check for this message in its `on_message` callback function.

        Since multiple contact points can occur for two colliding objects, this message can be sent multiple times in
        the same frame for the same two colliding objects. To only be notified once when the collision occurs, check
        for the `collision_response` message instead.
    **/
    static var contact_point_response(default, never) = new Message<PhysicsMessageContactPointResponse>("contact_point_response");

    /**
        Reports a ray cast miss.

        This message is sent back to the sender of a `ray_cast_request`, if the ray didn't hit any
        collision object. See `Physics.raycast_async` for examples of how to use it.
    **/
    static var ray_cast_missed(default, never) = new Message<PhysicsMessageRayCastMissed>("ray_cast_missed");

    /**
        Reports a ray cast hit.

        This message is sent back to the sender of a `ray_cast_request`, if the ray hit a collision object.
        See `Physics.raycast_async` for examples of how to use it.
    **/
    static var ray_cast_response(default, never) = new Message<PhysicsMessageRayCastResponse>("ray_cast_response");

    /**
        (DEPRECATED) requests the velocity of a collision object.

        Post this message to a collision-object-component to retrieve its velocity.
    **/
    @:deprecated("Read properties `linear_velocity` and `angular_velocity` with `Go.get` instead.")
    static var request_velocity(default, never) = new Message<Void>("request_velocity");

    /**
        Reports interaction (enter/exit) between a trigger collision object and another collision object.

        This message is broadcasted to every component of an instance that has a collision object, when the collision
        object interacts with another collision object and one of them is a trigger.
        For a script to take action when such an interaction happens, it
        should check for this message in its `on_message` callback function.

        This message only reports that an interaction actually happened and will only be sent once per colliding pair and frame.
        To retrieve more detailed information, check for the `contact_point_response` instead.
    **/
    static var trigger_response(default, never) = new Message<PhysicsMessageTriggerResponse>("trigger_response");

    /**
        (DEPRECATED) reports the velocity of a collision object.

        See `request_velocity` for examples on how to use it.

        This message is sent back to the sender of a `request_velocity` message.
    **/
    @:deprecated("Read properties `linear_velocity` and `angular_velocity` with `Go.get` instead.")
    static var velocity_response(default, never) = new Message<PhysicsMessageVelocityResponse>("velocity_response");
}

/**
    Data for the `PhysicsMessages.apply_force` message.
**/
typedef PhysicsMessageApplyForce =
{
    /**
        The force to be applied on the collision object, measured in Newton.
    **/
    var force:Vector3;

    /**
        The position where the force should be applied (vector3).
    **/
    var position:Vector3;
}

/**
    Data for the `PhysicsMessages.collision_response` message.
**/
typedef PhysicsMessageCollisionResponse =
{
    /**
        The id of the instance the collision object collided with.
    **/
    var other_id:Hash;

    /**
        The world position of the instance the collision object collided with.
    **/
    var other_position:Vector3;

    /**
        The collision group of the other collision object.
    **/
    var other_group:Hash;

    /**
        The collision group of the own collision object.
    **/
    var own_group:Hash;
}

/**
    Data for the `PhysicsMessages.contact_point_response` message.
**/
typedef PhysicsMessageContactPointResponse =
{
    /**
        World position of the contact point.
    **/
    var position:Vector3;

    /**
        Normal in world space of the contact point, which points from the other object towards the current object.
    **/
    var normal:Vector3;

    /**
        The relative velocity of the collision object as observed from the other object.
    **/
    var relative_velocity:Vector3;

    /**
        The penetration distance between the objects, which is always positive.
    **/
    var distance:Float;

    /**
        The impulse the contact resulted in.
    **/
    var applied_impulse:Float;

    /**
        Life time of the contact, *not currently used*
    **/
    var life_time:Float;

    /**
        The mass of the current collision object in kg.
    **/
    var mass:Float;

    /**
        The mass of the other collision object in kg.
    **/
    var other_mass:Float;

    /**
        The id of the instance the collision object is in contact with.
    **/
    var other_id:Hash;

    /**
        The world position of the other collision object.
    **/
    var other_position:Vector3;

    /**
        The collision group of the other collision object.
    **/
    var other_group:Hash;

    /**
        The collision group of the own collision object.
    **/
    var own_group:Hash;
}

/**
    Data for the `PhysicsMessages.ray_cast_missed` message.
**/
typedef PhysicsMessageRayCastMissed =
{
    /**
        Id supplied when the ray cast was requested.
    **/
    var request_id:Float;
}

/**
    Data for the `PhysicsMessages.ray_cast_response` message.
**/
typedef PhysicsMessageRayCastResponse =
{
    /**
        The fraction of the hit measured along the ray, where 0 is the start of the ray and 1 is the end.
    **/
    var fraction:Float;

    /**
        The world position of the hit.
    **/
    var position:Vector3;

    /**
        The normal of the surface of the collision object where it was hit.
    **/
    var normal:Vector3;

    /**
        The instance id of the hit collision object.
    **/
    var id:Hash;

    /**
        The collision group of the hit collision object as a hashed name.
    **/
    var group:Hash;

    /**
        Id supplied when the ray cast was requested.
    **/
    var request_id:Int;
}

/**
    Data for the `PhysicsMessages.trigger_response` message.
**/
typedef PhysicsMessageTriggerResponse =
{
    /**
        The id of the instance the collision object collided with.
    **/
    var other_id:Hash;

    /**
        If the interaction was an entry or not (exit).
    **/
    var enter:Bool;

    /**
        The collision group of the triggering collision object.
    **/
    var other_group:Hash;

    /**
        The collision group of the own collision object.
    **/
    var own_group:Hash;
}

/**
    Data for the `PhysicsMessages.velocity_response` message.
**/
typedef PhysicsMessageVelocityResponse =
{
    /**
        The linear velocity, i.e. translation, of the collision object in units/s (pixels/s).
    **/
    var linear_velocity:Vector3;

    /**
        The angular velocity, i.e. rotation, of the collision object in radians/s.
        The velocity is measured as a rotation around the vector with a speed equivalent to the vector length.
    **/
    var angular_velocity:Vector3;
}

/**
    Physics fixed joint type.
**/
typedef PhysicsFixedJoint =
{
    /**
        Set this flag to true if the attached bodies should collide.
    **/
    var ?collide_connected:Bool;

    /**
        The maximum length of the rope.
    **/
    var ?max_length:Float;
}

/**
    Physics hinge joint type.
**/
typedef PhysicsHingeJoint =
{
    /**
        Set this flag to true if the attached bodies should collide.
    **/
    var ?collide_connected:Bool;

    /**
        The bodyB angle minus bodyA angle in the reference state (radians).
    **/
    var ?reference_angle:Float;

    /**
        The lower angle for the joint limit (radians).
    **/
    var ?lower_angle:Float;

    /**
        The upper angle for the joint limit (radians)
    **/
    var ?upper_angle:Float;

    /**
        The maximum motor torque used to achieve the desired motor speed. Usually in N-m.
    **/
    var ?max_motor_torque:Float;

    /**
        The desired motor speed. Usually in radians per second.
    **/
    var ?motor_speed:Float;

    /**
        A flag to enable joint limits
    **/
    var ?enable_limit:Bool;

    /**
         A flag to enable the joint motor.
    **/
    var ?enable_motor:Bool;

    /**
        Read only fields, available from physics.get_joint_properties().
    **/

    /**
        Current joint angle in radians
    **/
    var ?joint_angle(default, null):Float;

    /**
        Current joint angle speed in radians per second.
    **/
    var ?joint_speed(default, null):Float;
}

/**
    Physics slider joint type.
**/
typedef PhysicsSliderJoint =
{
    /**
        Set this flag to true if the attached bodies should collide.
    **/
    var ?collide_connected:Bool;

    /**
        The local translation unit axis in bodyA
    **/
    var ?local_axis_a:Vector3;

    /**
        The constrained angle between the bodies: bodyB_angle - bodyA_angle.
    **/
    var ?reference_angle:Float;

    /**
        Enable/disable the joint limit.
    **/
    var ?enable_limit:Bool;

    /**
        The lower translation limit, usually in meters.
    **/
    var ?lower_translation:Float;

    /**
        The upper translation limit, usually in meters.
    **/
    var ?upper_translation:Float;

    /**
        Enable/disable the joint motor.
    **/
    var ?enable_motor:Bool;

    /**
        The maximum motor torque, usually in N-m.
    **/
    var ?max_motor_force:Float;

    /**
        The desired motor speed in radians per second.
    **/
    var ?motor_speed:Float;

    /**
        Read only fields, available from physics.get_joint_properties().
    **/

    /**
        Current joint translation, usually in meters
    **/
    var ?joint_translation(default, null):Float;

    /**
        Current joint translation speed, usually in meters per second.
    **/
    var ?joint_speed(default, null):Float;
}

/**
    Physics spring joint type.
**/
typedef PhysicsSpringJoint =
{
    /**
        Set this flag to true if the attached bodies should collide.
    **/
    var ?collide_connected:Bool;

    /**
        The natural length between the anchor points.
    **/
    var ?length:Float;

    /**
        The mass-spring-damper frequency in Hertz. A value of 0 disables softness.
    **/
    var ?frequency:Float;

    /**
        The damping ratio. 0 = no damping, 1 = critical damping.
    **/
    var ?damping:Float;
}

/**
    A lua table containing options for the raycast.
**/
typedef PhysicsRaycastOptions =
{
    /**
        Set to `true` to return all ray cast hits. If `false`, it will only return the closest hit.
    **/
    var all:Bool;
}

/**
    Types of physics joint available.
**/
@:native("_G.physics")
extern enum abstract PhysicsJointType({})
{
    @:native('JOINT_TYPE_FIXED')
    var Fixed;

    @:native('JOINT_TYPE_HINGE')
    var Hinge;

    @:native('JOINT_TYPE_SLIDER')
    var Slider;

    @:native('JOINT_TYPE_SPRING')
    var Spring;

    @:native('JOINT_TYPE_WHEEL')
    var Wheel;
}

