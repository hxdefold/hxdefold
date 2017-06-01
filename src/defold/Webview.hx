package defold;

/**
    Functions and for creating and controlling webviews to show html pages
    or evaluate javascript.
**/
@:native("_G.webview")
extern class Webview {
    /**
        Creates a webview instance.

        It can show HTML pages as well as evaluate Javascript.
        The view remains hidden until the first call.

        On iOS, the callback will never get a webview.CALLBACK_RESULT_EVAL_ERROR,
        due to the iOS SDK implementation.

        @param callback A callback which receives info about finished requests taking the following parameters
         * `self` - the calling script
         * `webview_id` - the webview id
         * `request_id` - the request id
         * `type` - the type of the callback
         * `data` - the callback value ''data''
        @return The id number of the webview
    **/
    static function create<T>(callback:T->WebviewId->WebviewRequestId->WebviewCallbackType->WebviewCallbackData->Void):WebviewId;

    /**
        Destroys an instance of a webview

        @param webview_id The webview id (returned by the `Webview.create` call)
    **/
    static function destroy(webview_id:WebviewId):Void;

    /**
        Evaluates javascript in a webview.

        Evaluates java script within the context of the currently loaded page (if any).
        Once the request is done, the callback (registered in `Webview.create`) is invoked.
        The callback will get the result in the data["result"] field.

        @param webview_id The webview id
        @param code The java script code to evaluate
        @return The id number of the request
    **/
    static function eval(webview_id:WebviewId, code:String):WebviewRequestId;

    /**
        Gets the visibility state of the webview.

        @param webview_idThe webview id (returned by the `Webview.create` call)
        @return Returns 0 if not visible, 1 if it is visible
    **/
    static function is_visible(webview_id:WebviewId):Int;

    /**
        Open a page using an url.

        Opens a web page in the webview, using an url.
        Once the request is done, the callback (registered in `Webview.create`) is invoked.

        @param webview_id The webview id
        @param url The url to open
        @param options Options for the request
        @return The id number of the request
    **/
    static function open(webview_id:WebviewId, url:String, options:WebviewOpenOptions):WebviewRequestId;

    /**
        Open a page using html.

        Opens a web page in the webview, using html data.
        Once the request is done, the callback (registered in `Webview.create`) is invoked.

        @param webview_id The webview id
        @param html The html data to display
        @param options Options for the request
        @return The id number of the request
    **/
    static function open_raw(webview_id:WebviewId, html:String, options:WebviewOpenOptions):WebviewRequestId;

    /**
        Shows or hides a web view.

        @param webview_id The webview id (returned by the `Webview.create` call)
        @param visible If 0, hides the webview. If non zero, shows the view.
    **/
    static function set_visible(webview_id:WebviewId, visible:Int):Void;
}

/**
    The identifier of a webview.
**/
typedef WebviewId = Int;

/**
    The identifier of a request to a webview.
**/
typedef WebviewRequestId = Int;

/**
    Type passed to the `Webview.create` callback.
**/
@:native("_G.webview")
@:enum extern abstract WebviewCallbackType(Int) {
    var CALLBACK_RESULT_URL_OK;
    var CALLBACK_RESULT_URL_ERROR;
    var CALLBACK_RESULT_EVAL_OK;
    var CALLBACK_RESULT_EVAL_ERROR;
}

/**
    Data passed to the `Webview.create` callback.
**/
typedef WebviewCallbackData = {
    /**
        The url used in the `Webview.open` call. null otherwise.
    **/
    var url:Null<String>;

    /**
        Holds the result of either: a failed url open, a successful eval request or a failed eval. null otherwise
    **/
    var result:Null<String>;
}

/**
    Data for the `options` argument of `Webview.open`.
**/
typedef WebviewOpenOptions = {
    /**
        If true, the webview will stay hidden (default=false).
    **/
    @:optional var hidden:Bool;
}
