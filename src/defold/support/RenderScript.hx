package defold.support;

import defold.types.*;

class RenderScript<T:{}> {
    function new() {}
    function init(self:T) {}
    function update(self:T, dt:Float) {}
    function on_message<TMessage>(self:T, message_id:Message<TMessage>, message:TMessage, sender:Url):Void {}
}
