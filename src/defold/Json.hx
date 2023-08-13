package defold;

import lua.Table;

/**
    Manipulation of JSON data strings.
**/
@:native("_G.json")
extern class Json
{
    /**
        Decode a string of JSON data into a Lua table.
        A Lua error is raised for syntax errors.

        @param json json data
        @return decoded json
    **/
    @:pure
    static function decode(json:String):Table<String,Dynamic>;

    /**
        Encode a lua table to a JSON string. A Lua error is raised for syntax errors.

        @param tbl lua table to encode
        @return encoded json
    **/
    @:pure
    static function encode(tbl:Table<String,Dynamic>):String;
}
