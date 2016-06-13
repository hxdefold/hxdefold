package defold.support;

import defold.types.*;

/**
    Base class for all render-scripts.

    Subclasses of this class will be available as .render_script files in the Defold project.
    See `ScriptMacro` for more details.
**/
class RenderScript<T:{}> {
    function new() {}

    /**
        Called when a script component is initialized.

        This is a callback-function, which is called by the engine when a render-script component is finalized (destroyed).
        It can be used to e.g. take some last action, report the finalization to other game object instances,
        delete spawned objects or release user input focus.
    **/
    function init(self:T) {}

    /**
        Called every frame to update the render-script component.

        This is a callback-function, which is called by the engine every frame to update the state of a render-script component.
        It can be used to perform any kind of game related tasks, e.g. moving the game object instance.
    **/
    function update(self:T, dt:Float) {}

    /**
        Called when a message has been sent to the render-script component.

        This is a callback-function, which is called by the engine whenever a message has been sent to the render-script component.
        It can be used to take action on the message, e.g. send a response back to the sender of the message.
    **/
    function on_message<TMessage>(self:T, message_id:Message<TMessage>, message:TMessage, sender:Url):Void {}
}
