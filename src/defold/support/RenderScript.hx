package defold.support;

import defold.types.*;

/** *
 * Base class for all render-scripts.
 *
 * Subclasses of this class will be available as .render_script files in the Defold project.
 * See `ScriptMacro` for more details.
* */
@:autoBuild(defold.support.ScriptBuilder.build())
abstract class RenderScript
{
    final function new() {}

    /**     *
     * Called when a script component is initialized.
     *
     * This is a callback-function, which is called by the engine when a script component is initialized. It can be used
     * to set the initial state of the script.
    * */
    @:dox(show) function init() {}

    /**     *
     * Called every frame to update the script component.
     *
     * This is a callback-function, which is called by the engine every frame to update the state of a script component.
     * It can be used to perform any kind of game related tasks, e.g. moving the game object instance.
     *
     * @param dt the time-step of the frame update
    * */
    @:dox(show) function update(dt:Float) {}

    /**     *
     * Called when a message has been sent to the script component.
     *
     * This is a callback-function, which is called by the engine whenever a message has been sent to the script component.
     * It can be used to take action on the message, e.g. send a response back to the sender of the message.
     *
     * The `message` parameter is a table containing the message data. If the message is sent from the engine, the
     * documentation of the message specifies which data is supplied.
     *
     * @param messageId id of the received message
     * @param message a table containing the message data
     * @param sender address of the sender
    * */
    @:dox(show) function onMessage<TMessage>(messageId:Message<TMessage>, message:TMessage, sender:Url):Void {}
}
