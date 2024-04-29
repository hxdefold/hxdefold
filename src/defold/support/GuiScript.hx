package defold.support;

import defold.types.*;

/**
    Base class for all gui-scripts.

    Subclasses of this class will be available as .gui_script files in the Defold project.
    See `ScriptMacro` for more details.
**/
@:autoBuild(defold.support.ScriptBuilder.build())
abstract class GuiScript
{
    final function new() {}

    /**
        Called when a gui component is initialized.

        This is a callback-function, which is called by the engine when a gui component is initialized. It can be used
        to set the initial state of the script and gui scene.
    **/
    @:dox(show) function init() {}

    /**
        Called when a gui component is finalized.

        This is a callback-function, which is called by the engine when a gui component is finalized (destroyed). It can
        be used to e.g. take some last action, report the finalization to other game object instances
        or release user input focus (see `release_input_focus`). There is no use in starting any animations or similar
        from this function since the gui component is about to be destroyed.
    **/
    @:dox(show) function final_() {}

    /**
        Called every frame to update the gui component.

        This is a callback-function, which is called by the engine every frame to update the state of a gui component.
        It can be used to perform any kind of gui related tasks, e.g. animating nodes.

        @param dt the time-step of the frame update
    **/
    @:dox(show) function update(dt:Float) {}

    /**
        Called when a message has been sent to the gui component.

        This is a callback-function, which is called by the engine whenever a message has been sent to the gui component.
        It can be used to take action on the message, e.g. update the gui or send a response back to the sender of the message.

        The `message` parameter is a table containing the message data. If the message is sent from the engine, the
        documentation of the message specifies which data is supplied.

        See the `update` function for examples on how to use this callback-function.

        @param messageId id of the received message
        @param message a table containing the message data
    **/
    @:dox(show) function onMessage<TMessage>(messageId:Message<TMessage>, message:TMessage, sender:Url):Void {}

    /**
        Called when user input is received.

        This is a callback-function, which is called by the engine when user input is sent to the instance of the gui component.
        It can be used to take action on the input, e.g. modify the gui according to the input.

        For an instance to obtain user input, it must first acquire input focuse through the message `acquire_input_focus`.
        See the documentation of that message for more information.

        The `action` parameter is a table containing data about the input mapped to the `action_id`.
        For mapped actions it specifies the value of the input and if it was just pressed or released.
        Actions are mapped to input in an input_binding-file.

        Mouse movement is specifically handled and uses `null` as its `action_id`.
        The `action` only contains positional parameters in this case, such as x and y of the pointer.

        @param action_id id of the received input action, as mapped in the input_binding-file
        @param action a table containing the input data, see above for a description
    **/
    @:dox(show) function onInput(actionId:Hash, action:ScriptOnInputAction):Bool return false;

    /**
        Called when the gui script is reloaded.

        This is a callback-function, which is called by the engine when the gui script is reloaded, e.g. from the editor.
        It can be used for live development, e.g. to tweak constants or set up the state properly for the script.
    **/
    @:dox(show) function onReload() {}
}
