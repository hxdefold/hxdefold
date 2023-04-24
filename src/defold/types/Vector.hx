package defold.types;

/**
    A vector of arbitrary size, which is returned by `Vmath.vector()`.

    Array access is possible, but note that the indices given are actually incremented
    by `1` in the abstract. This is because Lua indexes from `1`, but on the Haxe
    side we want to index from `0`.

```haxe
var vec: Vector = Vmath.vector(Table.fromArray([ 1, 2, 3 ]));
var firstElement: Float = vec[0]; // in Lua this would be vec[1]
```
**/
extern abstract Vector(Array<Float>) {

    @:op([])
    inline function get(i:Int):Float {
        return this[i+1];
    }

    @:op([])
    inline function set(i:Int, v:Float):Void {
        this[i+1] = v;
    }
}
