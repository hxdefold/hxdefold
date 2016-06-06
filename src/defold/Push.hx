package defold;

@:native("_G.push")
extern class Push {
    static function cancel(id:Int):Void;
    static function get_all_scheduled():lua.Table<Int,PushData>;
    static function get_scheduled(id:Int):PushData;
    static function register<T>(notifications:Null<lua.Table<Int,PushNotification>>, callback:T->String->{error:String}->Void):Void;
    inline static function schedule(time:Float, title:String, alert:String, payload:String, notification_settings:PushNotificationSettings):PushScheduleResult {
        return untyped __lua__("{{ {0}.schedule({1}, {2}, {3}, {4}, {5}) }}", Push, time, title, alert, payload, notification_settings);
    }
    static function set_badge_count(count:Int):Void;
    static function set_listener<T>(listener:T->String->PushOrigin->Void):Void;
}

typedef PushData = {
    var payload:String;
    var title:String;
    var priority:Int;
    var seconds:Float;
    var message:String;
}

@:native("_G.push")
@:enum extern abstract PushNotification({}) {
    var NOTIFICATION_ALERT;
    var NOTIFICATION_BADGE;
    var NOTIFICATION_SOUND;
}

typedef PushNotificationSettings = {
    @:optional var action:String;
    @:optional var badge_count:Int;
    @:optional var priority:Int;
}

abstract PushScheduleResult(lua.Table<Int,Dynamic>) {
    public var id(get,never):Int;
    public var error(get,never):{error:String};
    inline function get_id() return this[1];
    inline function get_error() return this[2];
}

@:native("_G.push")
@:enum extern abstract PushOrigin({}) {
    var ORIGIN_LOCAL;
    var ORIGIN_REMOTE;
}
