package defold.support;

class Script<T:{}> {
    function new() {}
    function init(self:T) {}
    function final(self:T) {}
    function update(self:T, dt:Float) {}
    function on_message<TMessage>(self:T, message_id:Message<TMessage>, message:TMessage, sender:Url):Void {}
    function on_input(self:T, action_id:Hash, action:InputAction):Bool return false;
    function on_reload(self:T) {}
}
