package defold.types.util;

import lua.Table;


/**
    This type is meant to be used for function arguments where an array is expected
    as a lua table with integer indices.

    Using this type for those arguments, allows the user on the Haxe side to directly
    pass a regular Haxe array, which will be converted to a lua table implicitly.

    And because this abstract also implicitly converts to and from `LuaArray< T>`,
    the default use of the API is left as-is without any overhead.

    This abstract also offers adjusted array access, by automatically incrementing given
    indices by `1`. This lets us keeps the `0`-based array access convention on the Haxe side.
**/
abstract LuaArray<T>(Table<Int,T>) from Table<Int,T> to Table<Int,T> {

    @:from
    static inline function fromArray<T>(arr:Array<T>):LuaArray<T> {
        return Table.fromArray(arr);
    }

    @:to
    inline function toArray():Array<T> {
        return Table.toArray(this);
    }

    @:op([])
    inline function get(i:Int):T {
        return this[i+1];
    }

    @:op([])
    inline function set(i:Int, v:T):Void {
        this[i+1] = v;
    }
}
