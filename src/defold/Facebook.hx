package defold;

import haxe.extern.EitherType;

/**
    Functions for interacting with Facebook APIs.
**/
@:native("_G.facebook")
extern class Facebook {
    /**
        Get the current Facebook access token.

        @return the access token
    **/
    static function access_token():String;

    /**
        Disable event usage with Facebook Analytics.

        This function will disable event usage for Facebook Analytics which means
        that Facebook won't be able to use event data for ad-tracking. Events will
        still be sent to Facebook for insights.

        *NOTE!* Event usage cannot be controlled and is always enabled for the
        Facebook Canvas platform, therefore this function has no effect on Facebook
        Canvas.
    **/
    static function disable_event_usage():Void;

    /**
        Enable event usage with Facebook Analytics.

        This function will enable event usage for Facebook Analytics which means
        that Facebook will be able to use event data for ad-tracking.

        *NOTE!* Event usage cannot be controlled and is always enabled for the
        Facebook Canvas platform, therefore this function has no effect on Facebook
        Canvas.
    **/
    static function enable_event_usage():Void;

    /**
        Login to Facebook and request a set of publish permissions. The user is
        prompted to authorize the application using the login dialog of the specific
        platform. Even if the user is already logged in to Facebook this function
        can still be used to request additional publish permissions.

        *NOTE* that this function cannot be used to request read permissions.
        If the application requires both publish and read permissions, individual
        calls to both login_with_publish_permissions and login_with_read_permissions
        has to be made.

        A comprehensive list of permissions can be found in the <a href="https://developers.facebook.com/docs/facebook-login/permissions">Facebook documentation</a>,
        as well as a <a href="https://developers.facebook.com/docs/facebook-login/best-practices">guide to best practises for login management</a>.

        @param permissions Table with the requested publish permission strings.
        @param audience The audience that should be able to see the publications.
        @param callback Callback function that takes the arguments (self, data), the callback is executed when the permission request dialog is closed.
    **/
    static function login_with_publish_permissions<T>(permissions:lua.Table<Int,String>, audience:FacebookAudience, callback:T->FacebookLoginData->Void):Void;

    /**
        Login to Facebook and request a set of read permissions. The user is
        prompted to authorize the application using the login dialog of the specific
        platform. Even if the user is already logged in to Facebook this function
        can still be used to request additional read permissions.

        *NOTE* that this function cannot be used to request publish permissions.
        If the application requires both read and publish permissions, individual
        calls to both login_with_read_permissions and login_with_publish_permissions
        has to be made.

        A comprehensive list of permissions can be found in the <a href="https://developers.facebook.com/docs/facebook-login/permissions">Facebook documentation</a>,
        as well as a <a href="https://developers.facebook.com/docs/facebook-login/best-practices">guide to best practises for login management</a>.

        @param permissions Table with the requested read permission strings.
        @param callback (function) Callback function that takes the arguments (self, data), the callback is executed when the permission request dialog is closed.
    **/
    static function login_with_read_permissions<T>(permissions:lua.Table<Int,String>, callback:T->FacebookLoginData->Void):Void;

    /**
        Logout from Facebook.
    **/
    static function logout():Void;

    /**
        Get the currently granted permissions.

        This function returns a table with all the currently granted permission strings.

        @return the permissions
    **/
    static function permissions():lua.Table<Int,String>;

    /**
        Post an event to Facebook Analytics.

        This function will post an event to Facebook Analytics where it can be used
        in the Facebook Insights system.

        @param event An event can either be one of the predefined
        constants below or a text which can be used to define a custom event that is
        registered with Facebook Analytics.
        @param value_to_sum A numeric value for the event. This should
        represent the value of the event, such as the level achieved, price for an
        item or number of orcs killed.
        @param params A table with parameters and their values. A key in the
        table can either be one of the predefined constants below or a text which
        can be used to define a custom parameter. Optional argument.
    **/
    static function post_event(event:EitherType<String,FacebookEvent>, value_to_sum:Int, ?params:lua.Table<EitherType<FacebookParam,String>,Dynamic>):Void;

    /**
        Show facebook web dialog.

        Display a Facebook web dialog of the type specified in the `dialog` parameter.
        The `param` table should be set up according to the requirements of each dialog
        type. Note that some parameters are mandatory. Below is the list of available dialogs and
        where to find Facebook's developer documentation on parameters and response data.

        @param dialog dialog to show. "apprequests", "feed" or "appinvite"
        @param param table with dialog parameters
        @param callback callback function with parameters (self, result, error) that is called when the dialog is closed.
    **/
    static function show_dialog<T,TParam,TResult>(dialog:FacebookDialogType<TParam,TResult>, param:TParam, callback:T->TResult->Bool->Void):Void; // TODO: callback types
}

// these are most probably messed up...
@:enum abstract FacebookDialogType<TParam,TResult>(String) {
    /**
        Shows a Game Request dialog. Game Requests allows players to invite their friends to play a game.

        Details for each parameter: <a href='https://developers.facebook.com/docs/games/services/gamerequests/v2.6#dialogparameters'>https://developers.facebook.com/docs/games/services/gamerequests/v2.6#dialogparameters</a>
    **/
    var apprequests:FacebookDialogType<FacebookDialogParamApprequests,FacebookDialogResultApprequests> = "apprequests";

    /**
        The Feed Dialog allows people to publish individual stories to their timeline.

        Details for each parameter: <a href='https://developers.facebook.com/docs/sharing/reference/feed-dialog/v2.6#params'>https://developers.facebook.com/docs/sharing/reference/feed-dialog/v2.6#params</a>
    **/
    var feed:FacebookDialogType<FacebookDialogParamFeed,FacebookDialogResultFeed> = "feed";

    /**
        The App Invite dialog is available only on iOS and Android. Note that the `url` parameter
        corresponds to the appLinkURL (iOS) and setAppLinkUrl (Android) properties.

        Details for each parameter: <a href='https://developers.facebook.com/docs/reference/ios/current/class/FBSDKAppInviteContent/'>https://developers.facebook.com/docs/reference/ios/current/class/FBSDKAppInviteContent/</a>
    **/
    var appinvite:FacebookDialogType<FacebookDialogParamAppinvite,FacebookDialogResultAppinvite> = "appinvite";
}

typedef FacebookDialogParamApprequests = {
    var title:String;
    var message:String;
    var action_type:FacebookApprequestActionType;
    var filters:FacebookApprequestFilter;
    var data:String;
    var object_id:String;
    var suggestions:lua.Table.AnyTable;
    var recipients:lua.Table.AnyTable;
    var to:String;
}

typedef FacebookDialogResultApprequests = {
    var request_id:String;
    var to:lua.Table.AnyTable;
}

typedef FacebookDialogParamFeed = {
    var caption:String;
    var description:String;
    var picture:String;
    var link:String;
    var people_ids:lua.Table.AnyTable;
    var place_id:String;
    var ref:String;
}

typedef FacebookDialogResultFeed = {
    var post_id:String;
}


typedef FacebookDialogParamAppinvite = {
    var url:String;
    var preview_image:String;
}

typedef FacebookDialogResultAppinvite = {}

/**
    Data for the `Facebook.login_with_publish_permissions` and `Facebook.login_with_read_permissions` callback argument.
**/
typedef FacebookLoginData = {
    var status:FacebookLoginState;
    var error:Null<Dynamic>;
}

/**
    State of the facebook login, used in `FacebookLoginData`.
**/
@:native("_G.facebook")
@:enum extern abstract FacebookLoginState(Int) {
    /**
        The Facebook login session is open.
    **/
    var STATE_OPEN;

    /**
        The Facebook login session has closed because login failed.
    **/
    var STATE_CLOSED_LOGIN_FAILED;
}

/**
    Prefefined events for `Facebook.post_event`.
**/
@:native("_G.facebook")
@:enum extern abstract FacebookEvent(String) {
    /**
        Log this event when the user has entered their payment info..
    **/
    var EVENT_ADDED_PAYMENT_INFO;

    /**
        Log this event when the user has added an item to their cart. The.

        value_to_sum passed to facebook.post_event should be the item's price.
    **/
    var EVENT_ADDED_TO_CART;

    /**
        Log this event when the user has added an item to their wishlist. The.

        value_to_sum passed to facebook.post_event should be the item's price.
    **/
    var EVENT_ADDED_TO_WISHLIST;

    /**
        Log this event when a user has completed registration with the app..
    **/
    var EVENT_COMPLETED_REGISTRATION;

    /**
        Log this event when the user has completed a tutorial in the app..
    **/
    var EVENT_COMPLETED_TUTORIAL;

    /**
        Log this event when the user has entered the checkout process. The.

        value_to_sum passed to facebook.post_event should be the total price in
        the cart.
    **/
    var EVENT_INITIATED_CHECKOUT;

    /**
        Log this event when the user has completed a purchase..
    **/
    var EVENT_PURCHASED;

    /**
        Log this event when the user has rated an item in the app. The.

        value_to_sum  passed to facebook.post_event should be the numeric rating.
    **/
    var EVENT_RATED;

    /**
        Log this event when a user has performed a search within the app..
    **/
    var EVENT_SEARCHED;

    /**
        Log this event when the user has spent app credits. The value_to_sum.

        passed to facebook.post_event should be the number of credits spent.

        *NOTE!* This event is currently an undocumented event in the Facebook
        SDK.
    **/
    var EVENT_SPENT_CREDITS;

    /**
        Log this event when measuring the time between user sessions..
    **/
    var EVENT_TIME_BETWEEN_SESSIONS;

    /**
        Log this event when the user has unlocked an achievement in the app..
    **/
    var EVENT_UNLOCKED_ACHIEVEMENT;

    /**
        Log this event when a user has viewed a form of content in the app..
    **/
    var EVENT_VIEWED_CONTENT;

    // these are mentioned but undocumented in the Defold API
    var EVENT_ACHIEVED_LEVEL;
    var EVENT_ACTIVATED_APP;
    var EVENT_DEACTIVATED_APP;
    var EVENT_SESSION_INTERRUPTIONS;
}

/**
    Prefefined params for `Facebook.post_event`.
**/
@:native("_G.facebook")
@:enum extern abstract FacebookParam(String) {
    /**
        Parameter key used to specify an ID for the specific piece of content.

        being logged about. Could be an EAN, article identifier, etc., depending
         on the nature of the app.
    **/
    var PARAM_CONTENT_ID;

    /**
        Parameter key used to specify a generic content type/family for the logged.

        event, e.g. "music", "photo", "video". Options to use will vary based upon
         what the app is all about.
    **/
    var PARAM_CONTENT_TYPE;

    /**
        Parameter key used to specify currency used with logged event. E.g. "USD",.

        "EUR", "GBP". See ISO-4217 for specific values.
    **/
    var PARAM_CURRENCY;

    /**
        Parameter key used to specify a description appropriate to the event being.

        logged. E.g., the name of the achievement unlocked in the
         facebook.EVENT_UNLOCKED_ACHIEVEMENT event.
    **/
    var PARAM_DESCRIPTION;

    /**
        Parameter key used to specify the level achieved..
    **/
    var PARAM_LEVEL;

    /**
        Parameter key used to specify the maximum rating available for the.

        facebook.EVENT_RATED event. E.g., "5" or "10".
    **/
    var PARAM_MAX_RATING_VALUE;

    /**
        Parameter key used to specify how many items are being processed for an.

        facebook.EVENT_INITIATED_CHECKOUT or facebook.EVENT_PURCHASED event.
    **/
    var PARAM_NUM_ITEMS;

    /**
        Parameter key used to specify whether payment info is available for the.

        facebook.EVENT_INITIATED_CHECKOUT event.
    **/
    var PARAM_PAYMENT_INFO_AVAILABLE;

    /**
        Parameter key used to specify method user has used to register for the.

        app, e.g., "Facebook", "email", "Twitter", etc.
    **/
    var PARAM_REGISTRATION_METHOD;

    /**
        Parameter key used to specify the string provided by the user for a search.

        operation.
    **/
    var PARAM_SEARCH_STRING;

    /**
        Parameter key used to specify source application package..
    **/
    var PARAM_SOURCE_APPLICATION;

    /**
        Parameter key used to specify whether the activity being logged about was.

        successful or not.
    **/
    var PARAM_SUCCESS;
}

/**
    Facebook audience permissions used by `Facebook.login_with_publish_permissions`.
**/
@:native("_G.facebook")
@:enum extern abstract FacebookAudience(Int) {
    /**
        Publish permission to reach everyone..
    **/
    var AUDIENCE_EVERYONE;

    /**
        Publish permission to reach user friends..
    **/
    var AUDIENCE_FRIENDS;

    /**
        Publish permission to reach no audience..
    **/
    var AUDIENCE_NONE;

    /**
        Publish permission to reach only me (private to current user)..
    **/
    var AUDIENCE_ONLYME;
}


@:native("_G.facebook")
@:enum extern abstract FacebookApprequestActionType(String) {
    /**
        Game Request action type "askfor" for "apprequests" dialog.
    **/
    var GAMEREQUEST_ACTIONTYPE_ASKFOR;

    /**
        Game Request action type "none" for "apprequests" dialog.
    **/
    var GAMEREQUEST_ACTIONTYPE_NONE;

    /**
        Game Request action type "send" for "apprequests" dialog.
    **/
    var GAMEREQUEST_ACTIONTYPE_SEND;

    /**
        Game Request action type "turn" for "apprequests" dialog.
    **/
    var GAMEREQUEST_ACTIONTYPE_TURN;
}

@:native("_G.facebook")
@:enum extern abstract FacebookApprequestFilter(Int) {
    /**
        Gamerequest filter type "app_non_users" for "apprequests" dialog.
    **/
    var GAMEREQUEST_FILTER_APPNONUSERS;

    /**
        Gamerequest filter type "app_users" for "apprequests" dialog.
    **/
    var GAMEREQUEST_FILTER_APPUSERS;

    /**
        Gamerequest filter type "none" for "apprequests" dialog.
    **/
    var GAMEREQUEST_FILTER_NONE;
}
