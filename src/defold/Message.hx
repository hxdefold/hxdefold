package defold;

import defold.Go.GoPlayback;

abstract Message<T>(haxe.extern.EitherType<Hash,String>) {
    public inline function new(s:String) this = Defold.hash(s);
}

// TODO: move these in per-module classes?
@:publicFields
class DefoldMessages {
    // sys
    static var Exit(default,never) = new Message<{code:Int}>("exit");
    static var Reboot(default,never) = new Message<RebootData>("reboot");
    static var SetUpdateFrequency(default,never) = new Message<{frequency:Int}>("set_update_frequency");
    static var StartRecord(default,never) = new Message<StartRecordData>("start_record");
    static var StopRecord(default,never) = new Message<Void>("stop_record");
    static var ToggleProfile(default,never) = new Message<Void>("toggle_profile");

    // go
    static var AcquireInputFocus(default,never) = new Message<Void>("acquire_input_focus");
    static var Disable(default,never) = new Message<Void>("disable");
    static var Enable(default,never) = new Message<Void>("enable");
    static var ReleaseInputFocus(default,never) = new Message<Void>("release_input_focus");
    static var SetParent(default,never) = new Message<{parent_id:Hash, ?keep_world_transform:Int}>("set_parent");

    // physics
    static var ApplyForce(default,never) = new Message<{force:Vector3, position:Vector3}>("apply_force");
    static var CollisionResponse(default,never) = new Message<{other_id:Hash, other_position:Vector3, group:Hash}>("collision_response");
    static var ContactPointResponse(default,never) = new Message<ContactPointResponseData>("contact_point_response");
    static var RayCastResponse(default,never) = new Message<RayCastResponseData>("ray_cast_response");
    static var TriggerResponse(default,never) = new Message<{other_id:Hash, enter:Bool, group:Hash}>("trigger_response");

    // spine
    static var SpineAnimationDone(default,never) = new Message<{animation_id:Hash, playback:GoPlayback}>("spine_animation_done");
    static var SpineEvent(default,never) = new Message<SpineEventData>("spine_event");

    // camera
    static var AcquireCameraFocus(default,never) = new Message<Void>("acquire_camera_focus");
    static var ReleaseCameraFocus(default,never) = new Message<Void>("release_camera_focus");
    static var SetCamera(default,never) = new Message<SetCameraData>("set_camera");

    // render
    static var ClearColor(default,never) = new Message<{color:Vector4}>("clear_color");
    static var DrawLine(default,never) = new Message<DrawLineData>("draw_line");
    static var DrawText(default,never) = new Message<DrawTextData>("draw_text");
    static var WindowResized(default,never) = new Message<{width:Int, height:Int}>("window_resized");

    // sprite
    static var AnimationDone(default,never) = new Message<{current_tile:Int, id:Hash}>("animation_done");
    static var PlayAnimation(default,never) = new Message<{id:Hash}>("play_animation");

    // sound
    static var PlaySound(default,never) = new Message<{?delay:Float, ?gain:Float}>("play_sound");
    static var SetGain(default,never) = new Message<{?gain:Float}>("set_gain");
    static var StopSound(default,never) = new Message<Void>("stop_sound");

    // tilemap
    @:deprecated
    static var SetTile(default,never) = new Message<SetTileData>("set_tile");
}

typedef RebootData = {
    ?arg1:String,
    ?arg2:String,
    ?arg3:String,
    ?arg4:String,
    ?arg5:String,
    ?arg6:String,
}

typedef StartRecordData = {
    file_name:String,
    ?frame_period:Int,
    ?fps:Int,
}

typedef ContactPointResponseData = {
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

typedef RayCastResponseData = {
    fraction:Float,
    position:Vector3,
    normal:Vector3,
    id:Hash,
    group:Hash,
    request_id:Int,
}

typedef SpineEventData = {
    event_id:Hash,
    animation_id:Hash,
    t:Float,
    blend_weight:Float,
    integer:Int,
    float:Float,
    string:Hash,
}

typedef SetCameraData = {
    aspect_ratio:Float,
    fov:Float,
    near_z:Float,
    far_z:Float,
}

typedef DrawLineData = {
    start_point:Vector3,
    end_point:Vector3,
    color:Vector4,
}

typedef DrawTextData = {
    position:Vector3,
    text:String,
}

typedef SetTileData = {
    layer_id:Hash,
    position:Vector3,
    tile:Int,
    dx:Int,
    dy:Int,
}
