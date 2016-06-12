package defold;

import defold.Go.GoProperty;
import defold.types.*;

/**
    Functions for controlling collection factories that are used to dynamically spawn collections.
**/
@:native("_G.collectionfactory")
extern class Collectionfactory {
    /**
        Spawn a new instance of a collection into the existing collection.

        The URL identifies the collectionfactory component that should do the spawning.

        Spawning is instant, but spawned game objects get their first update calls the following frame.

        The supplied parameters for position, rotation and scale will be applied to the whole collection when spawned.

        Script properties in the created game objects can be overridden through a properties-parameter table.
        The table should contain game object ids (hash) as keys and property tables as values to be used when initiating each spawned game object.

        The function returns a table that contains a key for each game object id (hash), as addressed if the collection file was top level,
        and the corresponding spawned instance id (hash) as value with a unique path prefix added to each instance.
    **/
    static function create(url:Url, ?position:Vector3, ?rotation:Quaternion, ?properties:lua.Table<Hash,lua.Table<Hash,GoProperty>>, ?scale:Float):lua.Table<Hash,Hash>;
}
