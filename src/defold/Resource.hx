package defold;

import defold.types.Buffer;
import defold.types.HashOrString;

/**
    Functions and constants to access resources.
**/
@:native("_G.resource")
extern class Resource {
    /**
        Return a reference to the Manifest that is currently loaded.

        This reference should be passed on to the `verify_resource` function when
        downloading content that was selected for LiveUpdate during the build
        process.

        @return reference to the Manifest that is currently loaded
    **/
    static function get_current_manifest():ResourceManifestReference;

    /**
        Loads the resource data for a specific resource.

        @param path The path to the resource
        @return the buffer stored on disc
    **/
    static function load(path:HashOrString):Buffer;

    /**
        Sets the resource data for a specific resource

        @param path The path to the resource
        @param The buffer of precreated data, suitable for the intended resource type
    **/
    static function set(path:HashOrString, buffer:Buffer):Void;

    /**
        Sets the pixel data for a specific texture.

        @param path The path to the resource
        @param table A table containing info about the texture
        @param buffer The buffer of precreated pixel data

        *NOTE* Currently, only 1 mipmap is generated.
    **/
    static function set_texture(path:HashOrString, table:ResourceTextureInfo, buffer:Buffer):Void;

    /**
        Add a resource to the data archive and runtime index.

        The resource that is added must already exist in the manifest and can be verified using
        verify_resource. The resource will also be verified internally before being added to the data archive.

        @param manifest_reference The manifest to check against.
        @param data The resource data that should be stored.
        @param hexdigest The expected hash for the resource, retrieved through collectionproxy.missing_resources.
        @param callback  The callback function that is executed once the engine has been attempted to store
        the resource. Arguments:
         * `self` The current object.
         * `hexdigest` The hexdigest of the resource.
         * `status` Whether or not the resource was successfully stored.
    **/
    static function store_resource<T>(manifest_reference:ResourceManifestReference, data:String, hexdigest:String, callback:T->String->Bool->Void):Void;
}

/**
    Resource manifest reference used by the `Resource` module.
**/
typedef ResourceManifestReference = Int;

/**
    Texture info used by the `Resource.set_texture` method.
**/
typedef ResourceTextureInfo = {
    /**
        The texture type
    **/
    var type:ResourceTextureType;

    /**
        The width of the texture (in pixels)
    **/
    var width:Int;

    /**
        The height of the texture (in pixels)
    **/
    var height:Int;

    /**
        The texture format
    **/
    var format:ResourceTextureFormat;
}

/**
    Resource type used in `ResourceTextureInfo.type` field.
**/
@:native("_G.resource")
@:enum extern abstract ResourceTextureType(Int) {
    var TEXTURE_TYPE_2D;
}

/**
    Resource format used in `ResourceTextureInfo.format` field.
**/
@:native("_G.resource")
@:enum extern abstract ResourceTextureFormat(Int) {
    var TEXTURE_FORMAT_RGB;
    var TEXTURE_FORMAT_RGBA;
}
