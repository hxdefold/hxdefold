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
    **/
    static function hash(s:String):Hash;

    /**
        Get hex representation of a hash value as a string.

        The returned string is always padded with leading zeros.

        @param h hash value to get hex string for
    **/
    static function hash_to_hex(h:Hash):String;

    /**
        Pretty printing of lua values.

        @param v value to print
    **/
    static function pprint(v:Any):String;
}
