package defold;

@:native("physics")
extern class Physics {
    static function ray_cast(from:Vector3, to:Vector3, groups:lua.Table<Int,Hash>, ?request_id:Int):Void;
}
