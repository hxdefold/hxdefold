package defold.types;

import defold.types.HashOrString;

/**
    A typed property.

    This abstract type wraps Hash and allows specifying property
    names together with their types. This is used for type checking
    and type inference for getting and setting properties.
**/
abstract Property<T>(Hash) from HashOrString
{
    @:pure
    public inline function new(s:String) this = Defold.hash(s);
}
