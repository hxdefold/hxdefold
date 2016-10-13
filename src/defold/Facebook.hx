package defold;

import haxe.extern.EitherType;

@:native("_G.facebook")
extern class Facebook {
    /**
        Get the current Facebook access token.
    **/
    static function access_token():String;

    /**
        Disable event usage with Facebook Analytics.

        This function will disable event usage for Facebook Analytics which means
        that Facebook won't be able to use event data for ad-tracking. Events will
        still be sent to Facebook for insights.

        <b>NOTE!</b> Event usage cannot be controlled and is always enabled for the
        Facebook Canvas platform, therefore this function has no effect on Facebook
        Canvas.
    **/
    static function disable_event_usage():Void;

    /**
        Enable event usage with Facebook Analytics.

        This function will enable event usage for Facebook Analytics which means
        that Facebook will be able to use event data for ad-tracking.

        <b>NOTE!</b> Event usage cannot be controlled and is always enabled for the
        Facebook Canvas platform, therefore this function has no effect on Facebook
        Canvas.
    **/
    static function enable_event_usage():Void;

    /**
        Initiate a Facebook login.

        This function opens a Facebook login dialog allowing the user to log into Facebook
        with his/her account. This performs a login requesting read permission for:
        <ul>
          <li><code>"public_profile"</code></li>
          <li><code>"email"</code></li>
          <li><code>"user_friends"</code></li>
        </ul>
        The actual permission that the user grants can be retrieved with `permissions`.

        @param callback callback function with parameters (self, status, error), when the login attempt is done.
    **/
    static function login<T>(callback:T->FacebookState->Dynamic->Void):Void; // TODO: error type

    /**
        Logout from Facebook.
    **/
    static function logout():Void;

    /**
        Return a table with "me" user data.

        This function returns a table of user data as requested from the Facebook Graph API
        "me" path. The user data is fetched during `login`.
    **/
    static function me():FacebookUserData;

    /**
        Get the currently granted permissions.

        This function returns a table with all the currently granted permission strings.
    **/
    static function permissions():lua.Table<Int,String>;

    static function post_event(event:EitherType<String,FacebookEvent>, value_to_sum:Int, ?params:lua.Table<EitherType<FacebookParam,String>,Dynamic>):Void;
    static function request_publish_permissions<T>(permissions:lua.Table<Int,String>, audience:EitherType<Int,FacebookAudience>, callback:T->Bool->Void):Void;
    static function request_read_permissions<T>(permissions:lua.Table<Int,String>, callback:T->Bool->Void):Void;
    static function show_dialog<T>(dialog:String, param:lua.Table<String,Dynamic>, callback:T->Dynamic->Bool->Void):Void;

    //static var GAMEREQUEST_ACTIONTYPE_ASKFOR;
    //static var GAMEREQUEST_ACTIONTYPE_NONE;
    //static var GAMEREQUEST_ACTIONTYPE_SEND;
    //static var GAMEREQUEST_ACTIONTYPE_TURN;
    //static var GAMEREQUEST_FILTER_APPNONUSERS;
    //static var GAMEREQUEST_FILTER_APPUSERS;
    //static var GAMEREQUEST_FILTER_NONE;
}

@:native("_G.facebook")
@:enum extern abstract FacebookState({}) {
    var STATE_CLOSED_LOGIN_FAILED;
    var STATE_OPEN;
}

typedef FacebookUserData = {
    var name:String;
    var last_name:String;
    var first_name:String;
    var id:String;
    var email:String;
    var link:String;
    var gender:String;
    var locale:String;
    var updated_time:String;
}

@:native("_G.facebook")
@:enum extern abstract FacebookEvent({}) {
    var EVENT_ACHIEVED_LEVEL;
    var EVENT_ACTIVATED_APP;
    var EVENT_ADDED_PAYMENT_INFO;
    var EVENT_ADDED_TO_CART;
    var EVENT_ADDED_TO_WISHLIST;
    var EVENT_COMPLETED_REGISTRATION;
    var EVENT_COMPLETED_TUTORIAL;
    var EVENT_DEACTIVATED_APP;
    var EVENT_INITIATED_CHECKOUT;
    var EVENT_PURCHASED;
    var EVENT_RATED;
    var EVENT_SEARCHED;
    var EVENT_SESSION_INTERRUPTIONS;
    var EVENT_SPENT_CREDITS;
    var EVENT_TIME_BETWEEN_SESSIONS;
    var EVENT_UNLOCKED_ACHIEVEMENT;
    var EVENT_VIEWED_CONTENT;
}

@:native("_G.facebook")
@:enum extern abstract FacebookParam({}) {
    var PARAM_CONTENT_ID;
    var PARAM_CONTENT_TYPE;
    var PARAM_CURRENCY;
    var PARAM_DESCRIPTION;
    var PARAM_LEVEL;
    var PARAM_MAX_RATING_VALUE;
    var PARAM_NUM_ITEMS;
    var PARAM_PAYMENT_INFO_AVAILABLE;
    var PARAM_REGISTRATION_METHOD;
    var PARAM_SEARCH_STRING;
    var PARAM_SOURCE_APPLICATION;
    var PARAM_SUCCESS;
}

@:native("_G.facebook")
@:enum extern abstract FacebookAudience({}) {
    var AUDIENCE_NONE;
    var AUDIENCE_ONLYME;
    var AUDIENCE_FRIENDS;
    var AUDIENCE_EVERYONE;
}
