package defold.types;

/**
    Url object type, can be created with `defold.Msg.url`.
**/
extern final class Url
{
    /**
     * Socket of the URL, this is an internal numeric value used by the engine.
     */
    var socket:UrlSocket;

    /**
     * Path of the URL, this is a hashed absolute path to the object.
     */
    var path:Hash;

    /**
     * Fragment of the URL, this is a hashed component name (without the #).
     */
    var fragment:Hash;
}
