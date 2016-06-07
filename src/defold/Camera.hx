package defold;

@:publicFields
class CameraMessages {
    static var AcquireCameraFocus(default,never) = new Message<Void>("acquire_camera_focus");
    static var ReleaseCameraFocus(default,never) = new Message<Void>("release_camera_focus");
    static var SetCamera(default,never) = new Message<CameraMessageSetCamera>("set_camera");
}

typedef CameraMessageSetCamera = {
    aspect_ratio:Float,
    fov:Float,
    near_z:Float,
    far_z:Float,
}
