package defold.support;

import defold.types.*;

/**
    Base class for all scripts.

    Subclasses of this class will be available as .script files in the Defold project.
    See `ScriptMacro` for more details.
**/
@:autoBuild(defold.support.ScriptBuilder.build())
abstract class Script
{
    final function new() {}

    /**
        Called when a script component is initialized.

        This is a callback-function, which is called by the engine when a script component is initialized. It can be used
        to set the initial state of the script.
    **/
    @:dox(show) function init():Void {}

    /**
        Called when a script component is finalized.

        This is a callback-function, which is called by the engine when a script component is finalized (destroyed). It can
        be used to e.g. take some last action, report the finalization to other game object instances, delete spawned objects
        or release user input focus (see `release_input_focus`).
    **/
    @:dox(show) function final_():Void  {}

    /**
        Called every frame to update the script component.

        This is a callback-function, which is called by the engine every frame to update the state of a script component.
        It can be used to perform any kind of game related tasks, e.g. moving the game object instance.

        @param dt the time-step of the frame update
    **/
    @:dox(show) function update(dt:Float):Void {}

    /**
        Called every frame to update the script component.

        Frame-rate independent update. dt contains the delta time since the last update.
        Useful when you wish to manipulate physics objects at regular intervals to achieve a stable physics simulation.
        Requires that `physics.use_fixed_timestep` is enabled in game.project.

        @param dt the time-step of the frame update
    **/
    @:dox(show) function fixedUpdate(dt:Float):Void {}

    /**
        Called when a message has been sent to the script component.

        This is a callback-function, which is called by the engine whenever a message has been sent to the script component.
        It can be used to take action on the message, e.g. send a response back to the sender of the message.

        The `message` parameter is a table containing the message data. If the message is sent from the engine, the
        documentation of the message specifies which data is supplied.

        @param messageId id of the received message
        @param message a table containing the message data
        @param sender address of the sender
    **/
    @:dox(show) function onMessage<TMessage>(messageId:Message<TMessage>, message:TMessage, sender:Url):Void {}

    /**
        Called when user input is received.

        This is a callback-function, which is called by the engine when user input is sent to the game object instance of the script.
        It can be used to take action on the input, e.g. move the instance according to the input.

        For an instance to obtain user input, it must first acquire input focuse through the message `acquire_input_focus`.
        See the documentation of that message for more information.

        The `action` parameter is a table containing data about the input mapped to the `action_id`.
        For mapped actions it specifies the value of the input and if it was just pressed or released.
        Actions are mapped to input in an input_binding-file.

        Mouse movement is specifically handled and uses `nil` as its `action_id`.
        The `action` only contains positional parameters in this case, such as x and y of the pointer.

        @param actionId id of the received input action, as mapped in the input_binding-file
        @param action a table containing the input data, see above for a description
        @return optional boolean to signal if the input should be consumed (not passed on to others) or not, default is false
    **/
    @:dox(show) function onInput(actionId:Hash, action:ScriptOnInputAction):Bool return false;

    /**
        Called when the script component is reloaded.

        This is a callback-function, which is called by the engine when the script component is reloaded, e.g. from the editor.
        It can be used for live development, e.g. to tweak constants or set up the state properly for the instance.
    **/
    @:dox(show) function onReload():Void {}
}
