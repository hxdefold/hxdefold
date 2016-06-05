package defold;

@:native("collectionfactory")
extern class Collectionfactory {
    static function create(url:Url, ?position:Vector3, ?rotation:Quaternion, ?properties:lua.Table<Hash,lua.Table.AnyTable>, ?scale:Float):lua.Table<Hash,Hash>;
}
