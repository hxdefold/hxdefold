package defold;

/**
    Functions for compression and decompression of string buffers.
**/
@:native("_G.zlib")
extern class Zlib {
    /**
        Deflate (compress) a buffer.

        A lua error is raised is on error

        @param buf buffer to deflate
        @return deflated buffer
    **/
    static function deflate(buf:String):String;

    /**
        Inflate (decompress) a buffer.

        A lua error is raised is on error

        @param buf buffer to inflate
        @return inflated buffer
    **/
    static function inflate(buf:String):String;
}
