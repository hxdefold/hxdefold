import defold.types.Hash;

/**
    Built-in scripting functions.
**/
@:native("_G")
extern class Defold {
    /**
        Hashes a string.

        All ids in the engine are represented as hashes, so a string needs to be hashed
        before it can be compared with an id.

        @param s string to hash
        @return a hashed string
    **/
    @:pure static function hash(s:String):Hash;

    /**
        Get hex representation of a hash value as a string.

        The returned string is always padded with leading zeros.

        @param h hash value to get hex string for
        @return hex representation of the hash
    **/
    @:pure static function hash_to_hex(h:Hash):String;

    /**
        Pretty printing of Lua values.
        
        This function prints Lua values in a manner similar to `lua.Lua.print`, but will also recurse into tables
        and pretty print them. There is a limit to how deep the function will recurse.

        @param v value to print
    **/
    static function pprint(v:Any):Void;
}
