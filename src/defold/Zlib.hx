package defold;

/**
    Functions for compression and decompression.
**/
@:native("_G.zlib")
extern class Zlib {
    /**
        Deflate (compress) a buffer.
    **/
    static function deflate(buf:String):String;

    /**
        Inflate (decompress) a buffer.
    **/
    static function inflate(buf:String):String;
}
