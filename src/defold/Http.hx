package defold;

import defold.types.Hash;

/**
    Functions for performing HTTP requests.
**/
@:native("_G.http")
extern class Http {
    /**
        Perform a HTTP request.
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
