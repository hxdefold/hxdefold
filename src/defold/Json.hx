package defold;

@:native("_G.json")
extern class Json {
    static function decode(json:String):lua.Table<String,Dynamic>;
}
