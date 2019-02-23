package defold.support;

import defold.types.*;

/**
    Base class for all render-scripts.

    Subclasses of this class will be available as .render_script files in the Defold project.
    See `ScriptMacro` for more details.
**/
@:autoBuild(defold.support.ScriptMacro.build())
class RenderScript<T:{}> {
    function new() {}

    /**
        Called when a script component is initialized.

        This is a callback-function, which is called by the engine when a script component is initialized. It can be used
        to set the initial state of the script.

        @param self reference to the script state to be used for storing data
    **/
    @:dox(show) function init(self:T) {}

    /**
        Called every frame to update the script component.

        This is a callback-function, which is called by the engine every frame to update the state of a script component.
        It can be used to perform any kind of game related tasks, e.g. moving the game object instance.

        @param self reference to the script state to be used for storing data
        @param dt the time-step of the frame update
    **/
    @:dox(show) function update(self:T, dt:Float) {}

    /**
        Called when a message has been sent to the script component.

        This is a callback-function, which is called by the engine whenever a message has been sent to the script component.
        It can be used to take action on the message, e.g. send a response back to the sender of the message.

        The `message` parameter is a table containing the message data. If the message is sent from the engine, the
        documentation of the message specifies which data is supplied.

        @param self reference to the script state to be used for storing data
        @param message_id id of the received message
        @param message a table containing the message data
        @param sender address of the sender
    **/
    @:dox(show) function on_message<TMessage>(self:T, message_id:Message<TMessage>, message:TMessage, sender:Url):Void {}
}
