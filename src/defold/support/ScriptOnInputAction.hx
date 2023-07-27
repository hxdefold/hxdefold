package defold.support;

import defold.types.util.LuaArray;

/**
    Type of the `action` argument of the `Script.on_input` method.
**/
typedef ScriptOnInputAction = {
    /**
        The amount of input given by the user.
        This is usually 1 for buttons and 0-1 for analogue inputs.
        This is not present for mouse movement.
    **/
    var ?value:Float;

    /**
        If the input was pressed this frame.
        This is not present for mouse movement.
    **/
    var ?pressed:Bool;

    /**
        If the input was released this frame.
        This is not present for mouse movement.
    **/
    var ?released:Bool;

    /**
        If the input was repeated this frame.
        This is similar to how a key on a keyboard is repeated when you hold it down.
        This is not present for mouse movement.
    **/
    var ?repeated:Bool;

    /**
        The x value of a pointer device, if present.
    **/
    var ?x:Float;

    /**
        The y value of a pointer device, if present.
    **/
    var ?y:Float;

    /**
        The screen space x value of a pointer device, if present.
    **/
    var ?screen_x:Float;

    /**
        The screen space y value of a pointer device, if present.
    **/
    var ?screen_y:Float;

    /**
        The change in x value of a pointer device, if present.
    **/
    var ?dx:Float;

    /**
        The change in y value of a pointer device, if present.
    **/
    var ?dy:Float;

    /**
        The change in screen space x value of a pointer device, if present.
    **/
    var ?screen_dx:Float;

    /**
        The change in screen space y value of a pointer device, if present.
    **/
    var ?screen_dy:Float;

    /**
        List of touch input, one element per finger, if present.
    **/
    var ?touch:LuaArray<ScriptOnInputActionTouch>;

    /**
        The index of the gamepad device that provided the input.
    **/
    var ?gamepad:Int;

    /**
        The name of the gamepad that was connected.
        Available on the `gamepad_connected` input event.
    **/
    var ?gamepad_name:String;

    /**
        Indicates that the connected gamepad is unidentified and will only generate raw input.
        Available on the `gamepad_connected` input event.
    **/
    var ?gamepad_unknown:Bool;
}

/**
    Type of the `ScriptOnInputAction.touch` field.
**/
typedef ScriptOnInputActionTouch = {
    /**
        A number identifying the touch input during its duration.
    **/
    var id:Int;

    /**
        True if the finger was pressed this frame.
    **/
    var pressed:Bool;

    /**
        True if the finger was released this frame.
    **/
    var released:Bool;

    /**
        Number of taps, one for single, two for double-tap, etc.
    **/
    var tap_count:Int;

    /**
        The x touch location.
    **/
    var x:Float;

    /**
        The y touch location.
    **/
    var y:Float;

    /**
        The screen space x value of a touch.
    **/
    var screen_x:Float;

    /**
        The screen space y value of a touch.
    **/
    var screen_y:Float;

    /**
        The change in x value.
    **/
    var dx:Float;

    /**
        The change in y value.
    **/
    var dy:Float;

    /**
        The change in screen space x value of a touch.
    **/
    var screen_dx:Float;

    /**
        The change in screen space y value of a touch.
    **/
    var screen_dy:Float;

    /**
        Accelerometer x value (if present).
    **/
    var ?acc_x:Float;

    /**
        Accelerometer y value (if present).
    **/
    var ?acc_y:Float;

    /**
        Accelerometer z value (if present).
    **/
    var ?acc_z:Float;
}
