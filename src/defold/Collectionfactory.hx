package defold;

import defold.Go.GoProperty;
import defold.types.*;

/**
    Functions for controlling collection factory components which are
    used to dynamically spawn collections into the runtime.
**/
@:native("_G.collectionfactory")
extern class Collectionfactory {
    /**
        Spawn a new instance of a collection into the existing collection.

        The URL identifies the collectionfactory component that should do the spawning.

        Spawning is instant, but spawned game objects get their first update calls the following frame. The supplied parameters for position, rotation and scale
        will be applied to the whole collection when spawned.

        Script properties in the created game objects can be overridden through
        a properties-parameter table. The table should contain game object ids
        (hash) as keys and property tables as values to be used when initiating each
        spawned game object.

        See go.property for more information on script properties.

        The function returns a table that contains a key for each game object
        id (hash), as addressed if the collection file was top level, and the
        corresponding spawned instance id (hash) as value with a unique path
        prefix added to each instance.

        @param url the collection factory component to be used
        @param position position to assign to the newly spawned collection
        @param rotation rotation to assign to the newly spawned collection
        @param properties table of script properties to propagate to any new game object instances (table)
        @param scale uniform scaling to apply to the newly spawned collection (must be greater than 0)
        @return a table mapping the id:s from the collection to the new instance id:s
    **/
    static function create(url:HashOrStringOrUrl, ?position:Vector3, ?rotation:Quaternion, ?properties:lua.Table<Hash,lua.Table<Hash,GoProperty>>, ?scale:Float):lua.Table<Hash,Hash>;
}
