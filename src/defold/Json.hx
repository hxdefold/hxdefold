package defold;

/**
    Decoding of JSON data strings.
**/
@:native("_G.json")
extern class Json {
    /**
        Decode a string of JSON data into a Lua table.
    **/
    static function decode(json:String):lua.Table<String,Dynamic>;
}
