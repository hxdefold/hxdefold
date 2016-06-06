package defold;

@:native("_G.iac")
extern class Iac {
    static function set_listener<T>(listener:T->lua.Table.AnyTable->IacType->Void):Void;
}

@:native("_G.iac")
@:enum extern abstract IacType({}) {
    var TYPE_INVOCATION;
}
