package defold;

import defold.Go.GoProperty;
import defold.types.*;

/**
    Functions for controlling collection factory components which are
    used to dynamically spawn collections into the runtime.
**/
@:native("_G.collectionfactory")
extern class CollectionFactory
{
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

        Calling `CollectionFactory.create` create on a collection factory that is marked as dynamic without having loaded resources
        using `CollectionFactory.load` will synchronously load and create resources which may affect application performance.

        @param url the collection factory component to be used
        @param position position to assign to the newly spawned collection
        @param rotation rotation to assign to the newly spawned collection
        @param properties table of script properties to propagate to any new game object instances (table)
        @param scale uniform scaling to apply to the newly spawned collection (must be greater than 0)
        @return a table mapping the id:s from the collection to the new instance id:s
    **/
    static function create(url:HashOrStringOrUrl, ?position:Vector3, ?rotation:Quaternion, ?properties:lua.Table<Hash,lua.Table<String,GoProperty>>, ?scale:Float):lua.Table<Hash,Hash>;

    /**
        Get collection factory status.

        This returns status of the collection factory.

        Calling this function when the factory is not marked as dynamic loading always returns `CollectionFactoryStatus.STATUS_LOADED`.

        @param url the collection factory component to get status from
        @return status of the collection factory component
    **/
    @:native('get_status')
    @:pure
    static function getStatus(?url:HashOrStringOrUrl):CollectionFactoryStatus;

    /**
        Load resources of a collection factory prototype.

        Resources loaded are referenced by the collection factory component until the existing (parent) collection is destroyed or `CollectionFactory.unload` is called.

        Calling this function when the factory is not marked as dynamic loading does nothing.

        @param url the collection factory component to load
        @param completeFunction function to call when resources are loaded.
    **/
    static inline function load(?url:HashOrStringOrUrl, ?completeFunction:(url:Url, result:Bool)->Void):Void
    {
        // 1. hide the reall callback parameter which expects a function with a "self" argument
        // 2. ensure that the global self reference is present for the callback
        load_(url, completeFunction == null ? null : (self, url, result) ->
        {
            untyped __lua__('_hxdefold_.self = _self');
            completeFunction(url, result);
            untyped __lua__('_hxdefold_.self = nil');
        });

    }
    @:native('load') private static function load_(?url:HashOrStringOrUrl, ?completeFunction:(Any, Url, Bool)->Void):Void;

    /**
        Unload resources previously loaded using `CollectionFactory.load`.

        This decreases the reference count for each resource loaded with collectionfactory.load. If reference is zero, the resource is destroyed.

        Calling this function when the factory is not marked as dynamic loading does nothing.

        @param url the collection factory component to unload
    **/
    static function unload(?url:HashOrStringOrUrl):Void;

    /**
        Changes the prototype for the collection factory.
        This allows the developer to load and spawn an arbitrary `.collectionc/.goc` file, further simplifying using dynamic content.
        The `.collectionc/.goc` files still need to be part of the resource archive.

        We’ve added a “Dynamic Prototype” checkbox to the factories. The prototype can only be overridden when this is checked.
        If set, then the collection component count cannot be optimized, and the owning collection will use the default component counts from game.project.

        Setting the prototype to `null` will revert back to the original prototype.

        @param url the collection factory component
        @param prototype the path to the new prototype, or `null`
    **/
    @:native('set_prototype')
    static function setPrototype(url:HashOrStringOrUrl, ?prototype:String):Void;
}

/**
    Possible values for the `CollectionFactory.get_status` return value.
**/
@:native("_G.collectionfactory")
extern enum abstract CollectionFactoryStatus({})
{
    var STATUS_UNLOADED;
    var STATUS_LOADING;
    var STATUS_LOADED;
}
