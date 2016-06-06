package defold;

@:native("_G.zlib")
extern class Zlib {
    static function deflate(buf:String):String;
    static function inflate(buf:String):String;
}
