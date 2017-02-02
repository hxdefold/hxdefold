package defold;

/**
    Manipulation of JSON data strings.
**/
@:native("_G.json")
extern class Json {
    /**
        Decode a string of JSON data into a Lua table.
        A Lua error is raised for syntax errors.

        @param json json data
        @return decoded json
    **/
    static function decode(json:String):lua.Table<String,Dynamic>;
}
