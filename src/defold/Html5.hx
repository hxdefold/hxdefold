package defold;

/**
    HTML5 platform specific functions.

    (The following functions are only available on HTML5 builds, the `Html5` methods will not be available on other platforms.)
**/
@:native("_G.html5")
extern class Html5 {
    /**
        Run JavaScript code, in the browser, from Lua.

        Executes the supplied string as JavaScript inside the browser.
        A call to this function is blocking, the result is returned as-is, as a string.
        (Internally this will execute the string using the `eval()` JavaScript function.)

        @param code Javascript code to run
        @return result as string
    **/
    static function run(code:String):String;
}
