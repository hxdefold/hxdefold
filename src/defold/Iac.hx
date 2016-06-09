package defold;

/**
    Inter-app communication.
**/
@:native("_G.iac")
extern class Iac {
    /**
        Set iac listener.

        The listener callback has the following signature: `function(self, payload, type)`
        where payload is a table with the iac payload.
    **/
    static function set_listener<T>(listener:T->lua.Table.AnyTable->IacType->Void):Void;
}

/**
    Possible IAC types.
**/
@:native("_G.iac")
@:enum extern abstract IacType({}) {
    var TYPE_INVOCATION;
}
