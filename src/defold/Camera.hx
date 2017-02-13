package defold;

import defold.types.Message;

/**
    Messages to control camera components and camera focus.

    This module currently has no functions.

    See `CameraMessages` for related messages.
**/
extern class Camera {}

/**
    Messages related to the `Camera` module.
**/
@:publicFields
class CameraMessages {
    /**
        Makes the receiving camera become the active camera.

        Post this message to a camera-component to activate it.

        Several cameras can be active at the same time, but only the camera that was last activated will be used for rendering.
        When the camera is deactivated (see `release_camera_focus`), the previously activated camera will again be used for rendering automatically.

        The reason it is called "camera focus" is the similarity to how acquiring input focus works (see `acquire_input_focus`).
    **/
    static var acquire_camera_focus(default, never) = new Message<Void>("acquire_camera_focus");

    /**
        Deactivates the receiving camera.

        Post this message to a camera-component to deactivate it. The camera is then removed from the active cameras.
        See `acquire_camera_focus` for more information how the active cameras are used in rendering.
    **/
    static var release_camera_focus(default, never) = new Message<Void>("release_camera_focus");

    /**
        Sets camera properties.

        Post this message to a camera-component to set its properties at run-time.
    **/
    static var set_camera(default, never) = new Message<CameraMessageSetCamera>("set_camera");
}

/**
    Data for the `CameraMessages.set_camera` message.
**/
typedef CameraMessageSetCamera = {
    /**
        Aspect ratio of the screen (width divided by height)
    **/
    var aspect_ratio:Float;

    /**
        Field of view of the lens, measured as the angle in radians between the right and left edge
    **/
    var fov:Float;

    /**
        Position of the near clipping plane (distance from camera along relative z)
    **/
    var near_z:Float;

    /**
        Position of the far clipping plane (distance from camera along relative z)
    **/
    var far_z:Float;
}
