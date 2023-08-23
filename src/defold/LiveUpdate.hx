package defold;


/**
    Functions and constants to access live update.
**/
@:native("_G.liveupdate")
extern final class LiveUpdate
{
    /**
        Return a reference to the Manifest that is currently loaded.

        @return reference to the Manifest that is currently loaded
    **/
    @:native('get_current_manifest')
    static function getCurrentManifest():LiveUpdateManifestReference;

    /**
        Create, verify, and store a manifest to device.

        Create a new manifest from a buffer. The created manifest is verified
        by ensuring that the manifest was signed using the bundled public/private
        key-pair during the bundle process and that the manifest supports the current
        running engine version. Once the manifest is verified it is stored on device.
        The next time the engine starts (or is rebooted) it will look for the stored
        manifest before loading resources. Storing a new manifest allows the
        developer to update the game, modify existing resources, or add new
        resources to the game through LiveUpdate.

        @param manifest_buffer the binary data that represents the manifest
        @param callback the callback function executed once the engine has attempted to store the manifest.
    **/
    static inline function storeManifest(manifest_buffer:String, callback:(status:LiveUpdateStatus)->Void):Void
    {
        // 1. hide the reall callback parameter which expects a function with a "self" argument
        // 2. ensure that the global self reference is present for the callback
        storeManifest_(manifest_buffer, (self, status) ->
        {
            untyped __lua__('_G._hxdefold_self_ = {0}', self);
            callback(status);
            untyped __lua__('_G._hxdefold_self_ = nil');
        });
    }
    @:native('store_manifest') private static function storeManifest_(manifest_buffer:String, callback:(self:Any, status:LiveUpdateStatus)->Void):Void;

    /**
        Stores a zip file and uses it for live update content. The path is renamed and stored in the (internal) live update location.

        @param path the path to the original file on disc
        @param callback the callback function executed after the storage has completed
        @param options optional table with extra parameters
    **/
    static inline function storeArchive(path:String, callback:(status:LiveUpdateStatus)->Void, ?options:LiveUpdateStoreArchiveOptions):Void
    {
        // 1. hide the reall callback parameter which expects a function with a "self" argument
        // 2. ensure that the global self reference is present for the callback
        storeArchive_(path, (self, status) ->
        {
            untyped __lua__('_G._hxdefold_self_ = {0}', self);
            callback(status);
            untyped __lua__('_G._hxdefold_self_ = nil');
        }, options);
    }
    @:native('store_archive') private static function storeArchive_(path:String, callback:(self:Any, status:LiveUpdateStatus)->Void, ?options:LiveUpdateStoreArchiveOptions):Void;

    /**
        Is any liveupdate data mounted and currently in use? This can be used to determine if a new manifest or zip file should be downloaded.

        @return true if a liveupdate archive (any format) has been loaded
    **/
    @:pure
    @:native('is_using_liveupdate_data')
    static function isUsingLiveupdateData():Bool;

    /**
        Add a resource to the data archive and runtime index.

        The resource will be verified internally before being added to the data archive.

        @param manifestReference The manifest to check against.
        @param data The resource data that should be stored.
        @param hexdigest The expected hash for the resource, retrieved through collectionproxy.missing_resources.
        @param callback  The callback function that is executed once the engine has been attempted to store
        the resource. Arguments:
         * `self` The current object.
         * `hexdigest` The hexdigest of the resource.
         * `status` Whether or not the resource was successfully stored.
    **/
    static inline function storeResource(manifestReference:LiveUpdateManifestReference, data:String, hexdigest:String, callback:(hexdigest:String, status:Bool)->Void):Void
    {
        // 1. hide the reall callback parameter which expects a function with a "self" argument
        // 2. ensure that the global self reference is present for the callback
        storeResource_(manifestReference, data, hexdigest, (self, hexdigest, status) ->
        {
            untyped __lua__('_G._hxdefold_self_ = {0}', self);
            callback(hexdigest, status);
            untyped __lua__('_G._hxdefold_self_ = nil');
        });
    }
    @:native('store_resource') private static function storeResource_(manifestReference:LiveUpdateManifestReference, data:String, hexdigest:String, callback:(Any, String, Bool)->Void):Void;
}

/**
    Resource manifest reference used by the `LiveUpdate` module.
**/
extern abstract LiveUpdateManifestReference(Int) { }


@:native("_G.liveupdate")
extern enum abstract LiveUpdateStatus({})
{
    /**
        Mismatch between between expected bundled resources and actual bundled resources.
        The manifest expects a resource to be in the bundle, but it was not found in the bundle.
        This is typically the case when a non-excluded resource was modified between publishing the bundle and publishing the manifest.
    **/
    var LIVEUPDATE_BUNDLED_RESOURCE_MISMATCH;

    /**
        Mismatch between running engine version and engine versions supported by manifest.
    **/
    var LIVEUPDATE_ENGINE_VERSION_MISMATCH;

    /**
        Failed to parse manifest data buffer. The manifest was probably produced by a different engine version.
    **/
    var LIVEUPDATE_FORMAT_ERROR;

    /**
        The handled resource is invalid.
    **/
    var LIVEUPDATE_INVALID_RESOURCE;

    var LIVEUPDATE_OK;

    /**
        Mismatch between scheme used to load resources.
        Resources are loaded with a different scheme than from manifest, for example over HTTP or directly from file.
        This is typically the case when running the game directly from the editor instead of from a bundle.
    **/
    var LIVEUPDATE_SCHEME_MISMATCH;

    /**
        Mismatch between manifest expected signature and actual signature.
    **/
    var LIVEUPDATE_SIGNATURE_MISMATCH;

    /**
        Mismatch between manifest expected version and actual version.
    **/
    var LIVEUPDATE_VERSION_MISMATCH;
}


/**
    Options used by the `LiveUpdate.storeArchive` method.
**/
typedef LiveUpdateStoreArchiveOptions =
{
    /**
        If archive should be verified as well as stored (defaults to `true`).
    **/
    var ?verify:Bool;
}
