package defold;

/**
    Functions to control the camera and focus.

    This module currently has no functions.

    See `CameraMessages` for camera-related messages.
**/
extern class Camera {}

/**
    Messages related to camera components.
**/
@:publicFields
class CameraMessages {
    /**
        Makes the receiving camera become the active camera.

        Post this message to a camera-component to activate it.

        Several cameras can be active at the same time, but only the camera that was last activated will be used for rendering.
        When the camera is deactivated (see `ReleaseCameraFocus`), the previously activated camera will again be used for rendering automatically.

        The reason it is called "camera focus" is the similarity to how acquiring input focus works (see `GoMessages.AcquireInputFocus`).
    **/
    static var AcquireCameraFocus(default,never) = new Message<Void>("acquire_camera_focus");

    /**
        Deactivates the receiving camera.

        Post this message to a camera-component to deactivate it.
        The camera is then removed from the active cameras.

        See `AcquireCameraFocus` for more information how the active cameras are used in rendering.
    **/
    static var ReleaseCameraFocus(default,never) = new Message<Void>("release_camera_focus");

    /**
        Sets camera properties.

        Post this message to a camera-component to set its properties at run-time.
    **/
    static var SetCamera(default,never) = new Message<CameraMessageSetCamera>("set_camera");
}

/**
    Data for the `CameraMessages.SetCamera` message.
**/
typedef CameraMessageSetCamera = {
    /**
        Aspect ratio of the screen (width divided by height).
    **/
    var aspect_ratio:Float;

    /**
        Field of view of the lens, measured as the angle between the right and left edge (radians).
    **/
    var fov:Float;

    /**
        Position of the near clipping plane (distance from camera along relative z).
    **/
    var near_z:Float;

    /**
        Position of the far clipping plane (distance from camera along relative z).
    **/
    var far_z:Float;
}
