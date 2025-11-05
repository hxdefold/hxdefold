package defold;

import defold.types.Hash;

/** *
 * Functions for performing HTTP and HTTPS requests.
**/
@:native("_G.http")
extern final class Http {
	/**
	 * Perform a HTTP/HTTPS request.
	 *
	 * The following cipher suites are supported for HTTPS requests:
	 *
	 	* TLS_RSA_WITH_AES_128_CBC_SHA
	 	* TLS_RSA_WITH_AES_256_CBC_SHA
	 	* TLS_RSA_WITH_AES_128_CBC_SHA256
	 	* TLS_RSA_WITH_AES_256_CBC_SHA256
	 *
	 * If no timeout value is passed, the configuration value "network.http_timeout" is used.
	 * If that is not set, the timeout value is 0. (0 == blocks indefinitely)
	 *
	 * @param url target url
	 * @param method HTTP/HTTPS method, e.g. GET/PUT/POST/DELETE/...
	 * @param callback response callback
	 * @param headers optional lua-table with custom headers
	 * @param postData optional data to send
	 * @param options optional lua-table with request parameters
	**/
	static inline function request(url:String, method:String, callback:HttpResponse->Void, ?headers:lua.Table<String, String>, ?postData:String,
			?options:HttpOptions):Void {
		// 1. hide the reall callback parameter which expects a function with a "self" argument
		// 2. ensure that the global self reference is present for the callback
		request_(url, method, (self, hash, response) -> {
			untyped __lua__('_G._hxdefold_self_ = {0}', self);
			callback(response);
			untyped __lua__('_G._hxdefold_self_ = nil');
		}, headers, postData, options);
	}

	@:native('request') private static function request_(url:String, method:String, callback:(Any, Hash, HttpResponse) -> Void,
		?headers:lua.Table<String, String>, ?postData:String, ?options:HttpOptions):Void;
}

/** *
 * Type for the `response` argument for the http request callback.
**/
typedef HttpResponse = {
	/**
	 * Status code.
	**/
	var status:Int;

	/**
	 * Response data.
	**/
	var response:String;

	/**
	 * Response headers.
	**/
	var headers:haxe.DynamicAccess<String>;

	/**
	 * The final URL after redirects (if any)
	**/
	var ?url:String;

	/**
	 * The stored path (if saved to disc)
	**/
	var ?path:String;

	/**
	 * If any unforeseen errors occurred (e.g. file I/O)
	**/
	var ?error:String;

	/**
	 * The amount of bytes received/sent for a request, only if option report_progress is true
	**/
	var ?bytes_received:Float;

	/**
	 * The total amount of bytes for a request, only if option report_progress is true
	**/
	var ?bytes_total:Float;

	/**
	 * The start offset into the requested file
	**/
	var ?range_start:Float;

	/**
	 * The end offset into the requested file (inclusive)
	**/
	var ?range_end:Float;

	/**
	 * The full size of the requested file
	**/
	var ?document_size:Float;
}

/** *
 * Type for the `options` argument of `Http.request` method.
**/
typedef HttpOptions = {
	/**
	 * Request timeout in seconds
	**/
	var ?timeout:Float;

	/**
	 * Path on disc where to download the file.
	 * Only overwrites the path if status is 200
	**/
	var ?path:String;

	/**
	 * Don't return cached data if we get a 304
	**/
	var ?ignore_cache:Bool;

	/**
	 * Use chunked transfer encoding for https requests larger than 16kb.
	 * Defaults to `true`.
	**/
	var ?chunked_transfer:Bool;

	/**
	 * When it is `true`, the amount of bytes sent and/or received for a request
	 * will be passed into the callback function
	**/
	var ?report_progress:Bool;
}
