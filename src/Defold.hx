import defold.Hash;

@:native("_G")
extern class Defold {
    static function hash(s:String):Hash;
    static function hash_to_hex(h:Hash):String;
    static function pprint(v:Dynamic):String;
}
