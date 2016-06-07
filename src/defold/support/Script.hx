package defold.support;

class Script<T:{}> {
    function new() {}
    function init(self:T) {}
    function final(self:T) {}
    function update(self:T, dt:Float) {}
    function on_message<TMessage>(self:T, message_id:Message<TMessage>, message:TMessage, sender:Url):Void {}
    function on_input(self:T, action_id:Hash, action:ScriptOnInputAction):Bool return false;
    function on_reload(self:T) {}
}

typedef ScriptOnInputAction = {
    var value:Float;
    var pressed:Bool;
    var released:Bool;
    var repeated:Bool;
    var x:Float;
    var y:Float;
    var screen_x:Float;
    var screen_y:Float;
    var dx:Float;
    var dy:Float;
    var touch:lua.Table<Int,ScriptOnInputActionTouch>;
}

typedef ScriptOnInputActionTouch = {
    var pressed:Bool;
    var released:Bool;
    var tap_count:Int;
    var x:Float;
    var y:Float;
    var dx:Float;
    var dy:Float;
    var acc_x:Float;
    var acc_y:Float;
    var acc_z:Float;
}
