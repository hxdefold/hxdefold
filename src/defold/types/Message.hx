package defold.types;

/**
    A typed message.

    This abstract type wraps Hash and allows specifying message data
    as its type parameter. This is used to provide type-checked messaging.
**/
abstract Message<T>(Hash)
{
    @:pure
    public inline function new(s:String) this = Defold.hash(s);
}
