package defold;

/**
    HTML5 platform specific functions.

    (The following functions are only available on HTML5 builds, the `Html5` methods will not be available on other platforms.)
**/
@:native("_G.html5")
extern final class Html5
{
    /**
        Run JavaScript code, in the browser, from Lua.

        Executes the supplied string as JavaScript inside the browser.
        A call to this function is blocking, the result is returned as-is, as a string.
        (Internally this will execute the string using the `eval()` JavaScript function.)

        @param code Javascript code to run
        @return result as string
    **/
    static function run(code:String):String;

    /**
        Set a JavaScript interaction listener callaback from lua that will be invoked when a user interacts with the web page by clicking, touching or typing.
        The callback can then call DOM restricted actions like requesting a pointer lock, or start playing sounds the first time the callback is invoked.

        @param callback The interaction callback. Pass an empty function or nil if you no longer wish to receive callbacks.
    **/
    static inline function setInteractionListener(callback:Void->Void):Void
    {
        // 1. hide the reall callback parameter which expects a function with a "self" argument
        // 2. ensure that the global self reference is present for the callback
        setInteractionListener_((self) ->
        {
            untyped __lua__('_hxdefold_.self = _self');
            callback();
            untyped __lua__('_hxdefold_.self = nil');
        });
    }
    @:native('set_interaction_listener') private static function setInteractionListener_(callback:Any->Void):Void;
}
