package defold.support;

typedef InputAction = {
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
    var touch:lua.Table<Int,InputTouch>;
}

typedef InputTouch = {
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
