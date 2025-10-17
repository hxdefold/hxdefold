package defold;

import defold.types.util.LuaArray;
import defold.types.Message;
import defold.types.Url;

/** *
 * Messages for controlling and interacting with collection proxies
 * which are used to dynamically load collections into the runtime.
 *
 * See `CollectionProxyMessages` for related messages.
* */
@:native("_G.collectionproxy")
extern final class CollectionProxy {
	/**	 *
	 * Return an indexed table of missing resources for a collection proxy.
	 *
	 * Each entry is a hexadecimal string that represents the data of the specific
	 * resource. This representation corresponds with the filename for each
	 * individual resource that is exported when you bundle an application with
	 * LiveUpdate functionality. It should be considered good practise to always
	 * check whether or not there are any missing resources in a collection proxy
	 * before attempting to load the collection proxy.
	 *
	 * @param collectionProxy the collection proxy to check for missing resources.
	 * @return the missing resources
	* */
	@:native('missing_resources')
	static function missingResources(collectionProxy:Url):LuaArray<String>;

	/**	 *
	 * Returns an indexed table of resources for a collection proxy.
	 * Each entry is a hexadecimal string that represents the data of the specific resource.
	 * This representation corresponds with the filename for each individual resource that is exported when you bundle an application with LiveUpdate functionality.
	 *
	 * @param collectionProxy the collection proxy to check
	 * @return the necessary resources
	* */
	@:pure
	@:native('get_resources')
	static function getResources(collectionProxy:Url):LuaArray<String>;

	/**	 *
	 * Changes the collection for a collection proxy.
	 *
	 * The collection should be loaded by the collection proxy. Setting the collection to `null` will revert it
	 * back to the original collection. The collection proxy shouldn't be loaded and should have the 'Exclude'
	 * checkbox checked. This functionality is designed to simplify the management of Live Update resources.
	 *
	 * @param collectionProxy the collection proxy component
	 * @param prototype the path to the new collection, or null to reset
	 * @return tuple (success, code). If unsuccessful, code is one of the `CollectionProxyResult` constants.
	* */
	@:multiReturn
	@:native('set_collection')
	static function setCollection(collectionProxy:Url, prototype:Null<String>):CollectionProxySetCollectionResult;
}

/** *
 * Messages related to the `CollectionProxy` module.
* */
@:publicFields
class CollectionProxyMessages {
	/**	 *
	 * Tells a collection proxy to start asynchronous loading of the referenced collection.
	 *
	 * Post this message to a collection-proxy-component to start background loading of the referenced collection.
	 * When the loading has completed, the message `proxy_loaded` will be sent back to the script.
	 *
	 * A loaded collection must be initialized (message `init`) and enabled (message `enable`) in order to be simulated and drawn.
	* */
	static var async_load(default, never) = new Message<Void>("async_load");

	/**	 *
	 * Tells a collection proxy to disable the referenced collection.
	 *
	 * Post this message to a collection-proxy-component to disable the referenced collection, which in turn disables the contained game objects and components.
	* */
	static var disable(default, never) = new Message<Void>("disable");

	/**	 *
	 * Tells a collection proxy to enable the referenced collection.
	 *
	 * Post this message to a collection-proxy-component to enable the referenced collection, which in turn enables the contained game objects and components.
	 * If the referenced collection was not initialized prior to this call, it will automatically be initialized.
	* */
	static var enable(default, never) = new Message<Void>("enable");

	/**	 *
	 * Tells a collection proxy to finalize the referenced collection.
	 *
	 * Post this message to a collection-proxy-component to finalize the referenced collection, which in turn finalizes the contained game objects and components.
	* */
	static var final_(default, never) = new Message<Void>("final");

	/**	 *
	 * Tells a collection proxy to initialize the loaded collection.
	 *
	 * Post this message to a collection-proxy-component to initialize the game objects and components in the referenced collection.
	 * Sending `enable` to an uninitialized collection proxy automatically initializes it.
	 * The `init` message simply provides a higher level of control.
	* */
	static var init(default, never) = new Message<Void>("init");

	/**	 *
	 * Tells a collection proxy to start loading the referenced collection.
	 *
	 * Post this message to a collection-proxy-component to start the loading of the referenced collection.
	 * When the loading has completed, the message `proxy_loaded` will be sent back to the script.
	 *
	 * A loaded collection must be initialized (message `init`) and enabled (message `enable`) in order to be simulated and drawn.
	* */
	static var load(default, never) = new Message<Void>("load");

	/**	 *
	 * Reports that a collection proxy has loaded its referenced collection.
	 *
	 * This message is sent back to the script that initiated a collection proxy load when the referenced
	 * collection is loaded. See documentation for "load" for examples how to use.
	* */
	static var proxy_loaded(default, never) = new Message<Void>("proxy_loaded");

	/**	 *
	 * Reports that a collection proxy has unloaded its referenced collection.
	 *
	 * This message is sent back to the script that initiated an unload with a collection proxy when
	 * the referenced collection is unloaded. See documentation for "unload" for examples how to use.
	* */
	static var proxy_unloaded(default, never) = new Message<Void>("proxy_unloaded");

	/**	 *
	 * Sets the time-step for update.
	 *
	 * Post this message to a collection-proxy-component to modify the time-step used when updating the collection controlled by the proxy.
	 * The time-step is modified by a scaling `factor` and can be incremented either continuously or in discrete steps.
	 *
	 * The continuous mode can be used for slow-motion or fast-forward effects.
	 *
	 * The discrete mode is only useful when scaling the time-step to pass slower than real time (`factor` is below 1).
	 * The time-step will then be set to 0 for as many frames as the scaling demands and then take on the full real-time-step for one frame,
	 * to simulate pulses. E.g. if `factor` is set to `0.1` the time-step would be 0 for 9 frames, then be 1/60 for one
	 * frame, 0 for 9 frames, and so on. The result in practice is that the game looks like it's updated at a much lower frequency than 60 Hz,
	 * which can be useful for debugging when each frame needs to be inspected.
	* */
	static var set_time_step(default, never) = new Message<CollectionProxyMessageSetTimeStep>("set_time_step");

	/**	 *
	 * Tells a collection proxy to start unloading the referenced collection.
	 *
	 * Post this message to a collection-proxy-component to start the unloading of the referenced collection.
	 * When the unloading has completed, the message `proxy_unloaded` will be sent back to the script.
	* */
	static var unload(default, never) = new Message<Void>("unload");
}

/** *
 * Return value from `CollectionProxy.setCollection`.
* */
@:multiReturn
typedef CollectionProxySetCollectionResult = {
	/** true if the collection change was successful */
	var success:Bool;

	/** error code if unsuccessful (one of CollectionProxyResult) */
	var code:CollectionProxyResult;
}

/** *
 * Result codes for `CollectionProxy.setCollection`.
* */
@:native("_G.collectionproxy")
extern enum abstract CollectionProxyResult({}) {
	/** It's impossible to change the collection if the collection is already loaded. */
	@:native('RESULT_ALREADY_LOADED') var AlreadyLoaded;

	/** It's impossible to change the collection while the collection proxy is loading. */
	@:native('RESULT_LOADING') var Loading;

	/** It's impossible to change the collection for a proxy that isn't excluded. */
	@:native('RESULT_NOT_EXCLUDED') var NotExcluded;
}

/** *
 * Data for the `CollectionProxyMessages.set_time_step` message.
* */
typedef CollectionProxyMessageSetTimeStep = {
	/**	 *
	 * Time-step scaling factor
	* */
	var factor:Float;

	/**	 *
	 * Time-step mode, either continous or discreet.
	* */
	var mode:SetTimeStepMode;
}

enum abstract SetTimeStepMode(Int) {
	/**	 *
	 * The continuous mode can be used for slow-motion or fast-forward effects.
	* */
	var Continuous = 0;

	/**	 *
	 * The discrete mode is only useful when scaling the time-step to pass slower than real time (`factor` is below `1`).
	* */
	var Discrete = 1;
}
