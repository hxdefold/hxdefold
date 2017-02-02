package defold;

/**
    Functions and constants for doing inter-app communication on iOS and
    Android.
**/
@:native("_G.iac")
extern class Iac {
    /**
        Set iac listener.

        The listener callback has the following signature: function(self, payload, type) where payload is a table
        with the iac payload and type is an iac.TYPE_<TYPE> enumeration.

        @param listener listener callback function
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
