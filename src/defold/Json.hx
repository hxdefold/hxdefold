package defold;

@:native("json")
extern class Json {
    static function decode(json:String):lua.Table.AnyTable;
}
