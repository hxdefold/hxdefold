package defold;

/**
    Functions and messages for collision object physics interaction with other objects (collisions and ray-casting)
    and control of physical behaviors.

    See `PhysicsMessages` for physics-related messages.
**/
@:native("_G.physics")
extern class Physics {
    /**
        Requests a ray cast to be performed.

        Ray casts are used to test for intersections against collision objects in the physics world.
        Which collision objects to hit is filtered by their collision groups and can be configured through groups.

        The actual ray cast will be performed during the physics-update.

        If an object is hit, the result will be reported via a `PhysicsMessages.PhysicsMessageRayCastResponse` message.
    **/
    static function ray_cast(from:Vector3, to:Vector3, groups:lua.Table<Int,Hash>, ?request_id:Int):Void;
}

/**
    Messages related to collision object component.
**/
@:publicFields
class PhysicsMessages {
    /**
        Applies a force on a collision object.

        Post this message to a collision-object-component to apply the specified force on the collision object.
        The collision object must be dynamic.
    **/
    static var ApplyForce(default,never) = new Message<{force:Vector3, position:Vector3}>("apply_force");

    /**
        Reports a collision between two collision objects.

        This message is broadcasted to every component of an instance that has a collision object,
        when the collision object collides with another collision object.
        For a script to take action when such a collision happens, it should check for this message in its `on_message` callback function.

        This message only reports that a collision actually happened and will only be sent once per colliding pair and frame.
        To retrieve more detailed information, check for the `ContactPointResponse` instead.
    **/
    static var CollisionResponse(default,never) = new Message<{other_id:Hash, other_position:Vector3, group:Hash}>("collision_response");

    /**
        Reports a contact point between two collision objects.

        This message is broadcasted to every component of an instance that has a collision object,
        when the collision object has contact points with respect to another collision object.
        For a script to take action when such contact points occur, it should check for this message in its `on_message` callback function.

        Since multiple contact points can occur for two colliding objects, this message can be sent multiple times in the same frame for the same two colliding objects.
        To only be notified once when the collision occurs, check for the `CollisionResponse` message instead.
    **/
    static var ContactPointResponse(default,never) = new Message<PhysicsMessageContactPointResponse>("contact_point_response");

    /**
        Requests the velocity of a collision object.

        DEPRECATED! Read properties `linear_velocity` and `angular_velocity` with `Go.get` instead.

        Post this message to a collision-object-component to retrieve its velocity.
    **/
    @:deprecated("Read properties `linear_velocity` and `angular_velocity` with `Go.get` instead")
    static var RequestVelocity(default,never) = new Message<{linear_velocity:Vector3, angular_velocity:Vector3}>("request_velocity");

    /**
        Reports a ray cast hit.

        This message is sent back to the sender of a `Physics.ray_cast`, if the ray hit a collision object.
    **/
    static var RayCastResponse(default,never) = new Message<PhysicsMessageRayCastResponse>("ray_cast_response");

    /**
        Reports interaction (enter/exit) between a trigger collision object and another collision object.
    **/
    static var TriggerResponse(default,never) = new Message<{other_id:Hash, enter:Bool, group:Hash}>("trigger_response");

    /**
        Reports the velocity of a collision object.

        DEPRECATED! Read properties `linear_velocity` and `angular_velocity` with `Go.get` instead.

        This message is sent back to the sender of a `RequestVelocity` message.
    **/
    @:deprecated("Read properties `linear_velocity` and `angular_velocity` with `Go.get` instead")
    static var VelocityResponse(default,never) = new Message<PhysicsMessageContactPointResponse>("velocity_response");
}

/**
    Data for the `PhysicsMessages.ContactPointResponse` message.
**/
typedef PhysicsMessageContactPointResponse = {
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
        Life time of the contact (not currently used).
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
    var group:Hash;
}

/**
    Data for the `PhysicsMessages.RayCastResponse` message.
**/
typedef PhysicsMessageRayCastResponse = {
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
