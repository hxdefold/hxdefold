package defold;

import haxe.extern.EitherType;
import defold.support.UrlOrString;

@:native("factory")
extern class Factory {
    static function create(url:UrlOrString, ?position:Vector3, ?rotation:Quaternion, ?properties:lua.Table<Hash,lua.Table.AnyTable>, ?scale:EitherType<Float,Vector3>):Hash;
}
