package defold;

import defold.types.util.LuaArray;

/**
    Functions and constants for interacting with local, as well as
    Apple's and Google's push notification services.
**/
@:native("_G.push")
extern class Push {
    /**
        Cancel a scheduled local push notification.

        Use this function to cancel a previously scheduled local push notification. The
        notification is identified by a numeric id as returned by `Push.schedule`.

        @param id the numeric id of the local push notification
    **/
    static function cancel(id:Int):Void;

    /**
        Retrieve data on all scheduled local push notifications.

        Returns a table with all data associated with all scheduled local push notifications.
        The table contains key, value pairs where the key is the push notification id and the
        value is a table with the notification data, corresponding to the data given by
        `Push.get_scheduled`.

        @return data table with all data associated with all scheduled notifications
    **/
    static function get_all_scheduled():LuaArray<PushData>;

    /**
        Retrieve data on a scheduled local push notification.

        Returns a table with all data associated with a specified local push notification.
        The notification is identified by a numeric id as returned by `Push.schedule`.

        @param id the numeric id of the local push notification
        @return data table with all data associated with the notification
    **/
    static function get_scheduled(id:Int):PushData;

    /**
        Register for push notifications.

        Send a request for push notifications. Note that the notifications table parameter
        is iOS only and will be ignored on Android.

        @param notifications the types of notifications to listen to. (iOS only)
        @param callback register callback function (function)
    **/
    static function register<T>(notifications:Null<LuaArray<PushNotificationType>>, callback:T->String->{error:String}->Void):Void;

    /**
        Schedule a local push notification to be triggered at a specific time in the future.

        Local push notifications are scheduled with this function.
        The returned `id` value is uniquely identifying the scheduled notification
        and can be stored for later reference.

        @param time number of seconds into the future until the notification should be triggered
        @param title localized title to be displayed to the user if the application is not running
        @param alert localized body message of the notification to be displayed to the user if the application is not running
        @param payload JSON string to be passed to the registered listener function
        @param notification_settings table with notification and platform specific fields
    **/
    static function schedule(time:Float, title:String, alert:String, payload:String, notification_settings:PushNotificationSettings):PushScheduleResult;

    /**
        Set the badge count for application icon.
        NOTE: This function is only available on iOS.

        @param count badge count
    **/
    static function set_badge_count(count:Int):Void;

    /**
        Set push listener.

        The listener callback has the following signature: function(self, payload, origin, activated) where payload is a table
        with the push payload, origin is either ORIGIN_LOCAL or ORIGIN_REMOTE, and activated is either true or false depending
        on if the application was activated via the notification.

        @param listener listener callback function
    **/
    static function set_listener<T>(listener:T->lua.Table<String,Dynamic>->PushOrigin->Bool->Void):Void;
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
@:enum extern abstract PushNotificationType(Int) {
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
    @:optional var priority:PushPriority;
}

/**
    A type for returning multiple values from the `Push.schedule` method.
**/
@:multiReturn extern class PushScheduleResult {
    /**
        Unique id that can be used to cancel or inspect the notification.
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
@:enum extern abstract PushOrigin(Int) {
    /**
        Local push origin.
    **/
    var ORIGIN_LOCAL;

    /**
        Remote push origin.
    **/
    var ORIGIN_REMOTE;
}

/**
    Push priority used in `PushNotificationSettings.priority` field (Android only).
**/
@:native("_G.push")
@:enum extern abstract PushPriority(Int) from Int to Int {
    /**
        The default notification priority.
        Only available on Android.
    **/
    var PRIORITY_DEFAULT;

    /**
        Priority for more important notifications or alerts.
        Only available on Android.
    **/
    var PRIORITY_HIGH;

    /**
        Priority for items that are less important.
        Only available on Android.
    **/
    var PRIORITY_LOW;

    /**
        Set this priority for your application's most important items that require the user's prompt attention or input.
        Only available on Android.
    **/
    var PRIORITY_MAX;

    /**
        This priority is for items might not be shown to the user except under special circumstances, such as detailed notification logs.
        Only available on Android.
    **/
    var PRIORITY_MIN;
}
