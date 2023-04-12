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
    @:optional var value:Float;

    /**
        If the input was pressed this frame.
        This is not present for mouse movement.
    **/
    @:optional var pressed:Bool;

    /**
        If the input was released this frame.
        This is not present for mouse movement.
    **/
    @:optional var released:Bool;

    /**
        If the input was repeated this frame.
        This is similar to how a key on a keyboard is repeated when you hold it down.
        This is not present for mouse movement.
    **/
    @:optional var repeated:Bool;

    /**
        The x value of a pointer device, if present.
    **/
    @:optional var x:Float;

    /**
        The y value of a pointer device, if present.
    **/
    @:optional var y:Float;

    /**
        The screen space x value of a pointer device, if present.
    **/
    @:optional var screen_x:Float;

    /**
        The screen space y value of a pointer device, if present.
    **/
    @:optional var screen_y:Float;

    /**
        The change in x value of a pointer device, if present.
    **/
    @:optional var dx:Float;

    /**
        The change in y value of a pointer device, if present.
    **/
    @:optional var dy:Float;

    /**
        The change in screen space x value of a pointer device, if present.
    **/
    @:optional var screen_dx:Float;

    /**
        The change in screen space y value of a pointer device, if present.
    **/
    @:optional var screen_dy:Float;

    /**
        List of touch input, one element per finger, if present.
    **/
    @:optional var touch:LuaArray<ScriptOnInputActionTouch>;

    /**
        The index of the gamepad device that provided the input.
    **/
    @:optional var gamepad:Int;

    /**
        The name of the gamepad that was connected.
        Available on the `gamepad_connected` input event.
    **/
    @:optional var gamepad_name:String;
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
    @:optional var acc_x:Float;

    /**
        Accelerometer y value (if present).
    **/
    @:optional var acc_y:Float;

    /**
        Accelerometer z value (if present).
    **/
    @:optional var acc_z:Float;
}
