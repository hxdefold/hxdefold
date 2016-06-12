package defold;

import haxe.extern.EitherType;
import defold.Go.GoProperty;
import defold.types.*;

/**
    Functions for controlling factory components that are used to dynamically spawn game objects.
**/
@:native("_G.factory")
extern class Factory {
    /**
        Make a factory create a new game object.

        If the game object is created inside of the frame (e.g. from an update callback), the game object will be created instantly,
        but none of its component will be updated in the same frame.

        Properties defined in scripts in the created game object can be overridden through the properties-parameter below.
    **/
    static function create(url:UrlOrString, ?position:Vector3, ?rotation:Quaternion, ?properties:lua.Table<Hash,GoProperty>, ?scale:EitherType<Float,Vector3>):Hash;
}
