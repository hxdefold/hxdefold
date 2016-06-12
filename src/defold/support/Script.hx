package defold.support;

import defold.types.*;

/**
    Base class for all scripts.

    Subclasses of this class will be available as .script files in the Defold project.
    See `ScriptMacro` for more details.
**/
class Script<T:{}> {
    function new() {}

    /**
        Called when a script component is initialized.

        This is a callback-function, which is called by the engine when a script component is finalized (destroyed).
        It can be used to e.g. take some last action, report the finalization to other game object instances,
        delete spawned objects or release user input focus.
    **/
    function init(self:T):Void {}

    /**
        Called when a script component is finalized.

        This is a callback-function, which is called by the engine when a script component is initialized.
        It can be used to set the initial state of the script.
    **/
    function final(self:T):Void  {}

    /**
        Called every frame to update the script component.

        This is a callback-function, which is called by the engine every frame to update the state of a script component.
        It can be used to perform any kind of game related tasks, e.g. moving the game object instance.
    **/
    function update(self:T, dt:Float):Void {}

    /**
        Called when a message has been sent to the script component.

        This is a callback-function, which is called by the engine whenever a message has been sent to the script component.
        It can be used to take action on the message, e.g. send a response back to the sender of the message.
    **/
    function on_message<TMessage>(self:T, message_id:Message<TMessage>, message:TMessage, sender:Url):Void {}

    /**
        Called when user input is received.

        This is a callback-function, which is called by the engine when user input is sent to the game object instance of the script.
        It can be used to take action on the input, e.g. move the instance according to the input.
    **/
    function on_input(self:T, action_id:Hash, action:ScriptOnInputAction):Bool return false;

    /**
        Called when the script component is reloaded.
    **/
    function on_reload(self:T):Void {}
}

/**
    Type of the `action` argument of the `Script.on_input` method.
**/
typedef ScriptOnInputAction = {
    /**
        The amount of input given by the user.
        This is usually 1 for buttons and 0-1 for analogue inputs.
        This is not present for mouse movement.
    **/
    var value:Float;

    /**
        If the input was pressed this frame.
        This is not present for mouse movement.
    **/
    var pressed:Bool;

    /**
        If the input was released this frame.
        This is not present for mouse movement.
    **/
    var released:Bool;

    /**
        If the input was repeated this frame.
        This is similar to how a key on a keyboard is repeated when you hold it down.
        This is not present for mouse movement.
    **/
    var repeated:Bool;

    /**
        The x value of a pointer device, if present.
    **/
    var x:Float;

    /**
        The y value of a pointer device, if present.
    **/
    var y:Float;

    /**
        The screen space x value of a pointer device, if present.
    **/
    var screen_x:Float;

    /**
        The screen space y value of a pointer device, if present.
    **/
    var screen_y:Float;

    /**
        The change in x value of a pointer device, if present.
    **/
    var dx:Float;

    /**
        The change in y value of a pointer device, if present.
    **/
    var dy:Float;

    /**
        The change in screen space x value of a pointer device, if present.
    **/
    var screen_dx:Float;

    /**
        The change in screen space y value of a pointer device, if present.
    **/
    var screen_dy:Float;

    /**
        List of touch input, one element per finger, if present.
    **/
    var touch:lua.Table<Int,ScriptOnInputActionTouch>;
}

/**
    Type of the `ScriptOnInputAction.touch` field.
**/
typedef ScriptOnInputActionTouch = {
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
        The change in x value.
    **/
    var dx:Float;

    /**
        The change in y value.
    **/
    var dy:Float;

    /**
        Accelerometer x value (if present).
    **/
    var acc_x:Float;

    /**
        Accelerometer y value (if present).
    **/
    var acc_y:Float;

    /**
        Accelerometer z value (if present).
    **/
    var acc_z:Float;
}
