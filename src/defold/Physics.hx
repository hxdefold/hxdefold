package defold;

@:native("_G.physics")
extern class Physics {
    static function ray_cast(from:Vector3, to:Vector3, groups:lua.Table<Int,Hash>, ?request_id:Int):Void;
}

@:publicFields
class PhysicsMessages {
    static var ApplyForce(default,never) = new Message<{force:Vector3, position:Vector3}>("apply_force");
    static var CollisionResponse(default,never) = new Message<{other_id:Hash, other_position:Vector3, group:Hash}>("collision_response");
    static var ContactPointResponse(default,never) = new Message<PhysicsMessageContactPointResponse>("contact_point_response");
    static var RayCastResponse(default,never) = new Message<PhysicsMessageRayCastResponse>("ray_cast_response");
    static var TriggerResponse(default,never) = new Message<{other_id:Hash, enter:Bool, group:Hash}>("trigger_response");
}

typedef PhysicsMessageContactPointResponse = {
    position:Vector3,
    normal:Vector3,
    relative_velocity:Vector3,
    distance:Float,
    applied_impulse:Float,
    life_time:Float,
    mass:Float,
    other_mass:Float,
    other_id:Hash,
    other_position:Vector3,
    group:Hash,
}

typedef PhysicsMessageRayCastResponse = {
    fraction:Float,
    position:Vector3,
    normal:Vector3,
    id:Hash,
    group:Hash,
    request_id:Int,
}
