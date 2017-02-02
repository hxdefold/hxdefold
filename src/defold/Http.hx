package defold;

import defold.types.Hash;

/**
    Functions for performing HTTP and HTTPS requests.
**/
@:native("_G.http")
extern class Http {
    /**
        Perform a HTTP/HTTPS request.

        If no timeout value is passed, the configuration value "network.http_timeout" is used.
        If that is not set, the timeout value is 0. (0 == blocks indefinitely)

        @param url target url
        @param method HTTP/HTTPS method, e.g. GET/PUT/POST/DELETE/...
        @param callback response callback
        @param headers optional lua-table with custom headers
        @param post_data optional data to send
        @param options optional lua-table with request parameters
    **/
    static function request<T>(url:String, method:String, callback:T->Hash->HttpResponse->Void, ?headers:lua.Table<String,String>, ?post_data:String, ?options:HttpOptions):Void;
}

/**
    Type for the `response` argument for the http request callback.
**/
typedef HttpResponse = {
    /**
        Status code.
    **/
    var status:Int;

    /**
        Response data.
    **/
    var response:String;

    /**
        Response headers.
    **/
    var headers:haxe.DynamicAccess<String>;
}

/**
    Type for the `options` argument of `Http.request` method.
**/
typedef HttpOptions = {
    /**
        Request timeout in seconds
    **/
    @:optional var timeout:Float;
}
