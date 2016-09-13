package defold;

/**
    Functions for interacting with local, as well as Apple's and Google's push notification services.
**/
@:native("_G.push")
extern class Push {
    /**
        Cancel a scheduled local push notification.

        Use this function to cancel a previously scheduled local push notification.
        The notification is identified by a numeric id as returned by `Push.schedule`.
    **/
    static function cancel(id:Int):Void;

    /**
        Retrieve data on all scheduled local push notifications.

        Returns a table with all data associated with all scheduled local push notifications.
        The table contains key, value pairs where the key is the push notification id
        and the value is a table with the notification data, corresponding to the data given by `Push.get_scheduled`.
    **/
    static function get_all_scheduled():lua.Table<Int,PushData>;

    /**
        Retrieve data on a scheduled local push notification.

        Returns a table with all data associated with a specified local push notification.
        The notification is identified by a numeric id as returned by `Push.schedule`.
    **/
    static function get_scheduled(id:Int):PushData;

    /**
        Register for push notifications.

        Note that the `notifications` table parameter is iOS only and will be ignored on Android.
    **/
    static function register<T>(notifications:Null<lua.Table<Int,PushNotificationType>>, callback:T->String->{error:String}->Void):Void;

    /**
        Schedule a local push notification to be triggered at a specific time in the future.
    **/
    static function schedule(time:Float, title:String, alert:String, payload:String, notification_settings:PushNotificationSettings):PushScheduleResult;

    /**
        Set the badge count for application icon.

        NOTE: This function is only available on iOS.
    **/
    static function set_badge_count(count:Int):Void;

    /**
        Set push listener.

        The `listener` callback has the following signature: function(self, payload, origin)
        where `payload` is a table with the push payload.
    **/
    static function set_listener<T>(listener:T->String->PushOrigin->Void):Void;
}

/**
    Push notification data returned by `Push.get_all_scheduled` and `Push.get_scheduled` methods.
**/
typedef PushData = {
    var payload:String;
    var title:String;
    var priority:Int;
    var seconds:Float;
    var message:String;
}

/**
    Possible values for elements of `notifications` argument of `Push.register` method (iOS only).
**/
@:native("_G.push")
@:enum extern abstract PushNotificationType({}) {
    /**
        Alert notification type.
    **/
    var NOTIFICATION_ALERT;

    /**
        Badge notification type.
    **/
    var NOTIFICATION_BADGE;

    /**
        Sound notification type.
    **/
    var NOTIFICATION_SOUND;
}

/**
    Platform specific data used as `notification_settings` argument of the `Push.schedule` method.
**/
typedef PushNotificationSettings = {
    /**
        (iOS only) The alert action string to be used as the title of the right button
        of the alert or the value of the unlock slider, where the value replaces "unlock" in "slide to unlock" text.
    **/
    @:optional var action:String;

    /**
        (iOS only). The numeric value of the icon badge.
    **/
    @:optional var badge_count:Int;

    @:noDoc
    @:deprecated("Use `badge_count` instead.")
    @:optional var badge_number:Int;

    /**
        (Android only). The priority is a hint to the device UI about how the notification should be displayed.

        There are five priority levels, from -2 to 2 where -1 is the lowest priority and 2 the highest.
        Unless specified, a default priority level of 2 is used.
    **/
    @:optional var priority:Int;
}

/**
    A type for returning multiple values from the `Push.schedule` method.
**/
@:multiReturn extern class PushScheduleResult {
    /**
        Created push notification identifier.
    **/
    var id:Int;

    /**
        Error string if something went wrong, otherwise `null`.
    **/
    var error:Null<String>;
}

/**
    Push origin passed to the `Push.set_listener` callback.
**/
@:native("_G.push")
@:enum extern abstract PushOrigin({}) {
    /**
        Local push origin.
    **/
    var ORIGIN_LOCAL;

    /**
        Remote push origin.
    **/
    var ORIGIN_REMOTE;
}
