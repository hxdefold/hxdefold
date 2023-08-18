package defold;

import haxe.extern.EitherType;
import defold.Go.GoProperty;
import defold.types.*;

/**
    Functions for controlling factory components which are used to
    dynamically spawn game objects into the runtime.
**/
@:native("_G.factory")
extern final class Factory
{
    /**
        Make a factory create a new game object.

        The URL identifies which factory should create the game object.
        If the game object is created inside of the frame (e.g. from an update callback), the game object will be created instantly,
        but none of its component will be updated in the same frame.

        Properties defined in scripts in the created game object can be overridden through the properties-parameter below.

        Calling `Factory.create` on a factory that is marked as dynamic without having loaded resources
        using `Factory.load` will synchronously load and create resources which may affect application performance.

        @param url the factory that should create a game object.
        @param position the position of the new game object, the position of the game object calling `Factory.create()` is used by default, or if the value is `nil`
        @param rotation the rotation of the new game object, the rotation of the game object calling `Factory.create()` is used by default, or if the value is `nil`.
        @param properties the properties defined in a script attached to the new game object.
        @param scale the scale of the new game object (must be greater than 0), the scale of the game object containing the factory is used by default, or if the value is `nil`
        @return the global id of the spawned game object
    **/
    static function create(url:HashOrStringOrUrl, ?position:Vector3, ?rotation:Quaternion, ?properties:lua.Table<String,GoProperty>, ?scale:EitherType<Float,Vector3>):Hash;

    /**
        Get factory status.

        This returns status of the factory.

        Calling this function when the factory is not marked as dynamic loading always returns
        `FactoryStatus.STATUS_LOADED`.

        @param url the factory component to get status from
        @return status of the factory component
    **/
    @:pure
    @:native('get_status')
    static function getStatus(?url:HashOrStringOrUrl):FactoryStatus;

    /**
        Load resources of a factory prototype.

        Resources are referenced by the factory component until the existing (parent) collection is destroyed or `Factory.unload` is called.

        Calling this function when the factory is not marked as dynamic loading does nothing.

        @param url the factory component to load
        @param completeFunction function to call when resources are loaded.
    **/
    static inline function load(?url:HashOrStringOrUrl, ?completeFunction:(url:Url, result:Bool)->Void):Void
    {
        // 1. hide the reall callback parameter which expects a function with a "self" argument
        // 2. ensure that the global self reference is present for the callback
        load_(url, completeFunction == null ? null : (self, url, result) ->
        {
            untyped __lua__('_hxdefold_.self = {0}', self);
            completeFunction(url, result);
            untyped __lua__('_hxdefold_.self = nil');
        });
    }
    @:native('load') private static function load_(?url:HashOrStringOrUrl, ?completeFunction:(Any, Url, Bool)->Void):Void;

    /**
        Unload resources previously loaded using `Factory.load`.

        This decreases the reference count for each resource loaded with `Factory.load`. If reference is zero, the resource is destroyed.

        Calling this function when the factory is not marked as dynamic loading does nothing.

        @param url the factory component to unload
    **/
    static function unload(?url:HashOrStringOrUrl):Void;

    /**
        Changes the prototype for the factory.
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
    Possible return values for `Factory.get_status`.
**/
@:native("_G.factory")
extern enum abstract FactoryStatus({})
{
    var STATUS_UNLOADED;
    var STATUS_LOADING;
    var STATUS_LOADED;
}
