package defold;

import lua.Table;

/**
    Manipulation of JSON data strings.
**/
@:native("_G.json")
extern final class Json
{
    /**
        Decode a string of JSON data into a Lua table.
        A Lua error is raised for syntax errors.

        @param json json data
        @param options table with decode options
        @return decoded json
    **/
    @:pure
    static function decode(json:String, ?options:JsonEncodingOptions):Table<String,Dynamic>;

    /**
        Encode a lua table to a JSON string. A Lua error is raised for syntax errors.

        @param tbl lua table to encode
        @param options table with decode options
        @return encoded json
    **/
    @:pure
    static function encode(tbl:Table<String,Dynamic>, ?options:JsonEncodingOptions):String;
}


typedef JsonEncodingOptions =
{
    /**
        Whether to decode a JSON null value as json.null or nil (default is nil)

        This is currentlu omitted on purpose, since in Haxe we only want to work with the native null.
    **/
    // var decode_null_as_userdata:Bool;
}
