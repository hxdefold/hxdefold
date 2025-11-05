package defold;

import defold.types.HashOrString;

/** *
 * Functions to manipulate font resources at runtime.
 * These map to the global "font" Lua module.
**/
@:native("_G.font")
extern final class Font {
	/**
	 * Asynchronously add glyphs to a .fontc resource.
	 *
	 * @param path The path to the .fontc resource
	 * @param text A string with unique unicode characters to be loaded
	 * @param callback Optional callback called when the request finishes: (request_id, result, errstring)
	 * @return The asynchronous request id
	**/
	@:pure
	static inline function addGlyphs(path:HashOrString, text:String, ?callback:(FontRequestId, Bool, Null<String>) -> Void):FontRequestId {
		return addGlyphs_(path, text, callback == null ? null : (self, request_id, result, errstring) -> {
			untyped __lua__("_G._hxdefold_self_ = {0}", self);
			callback(request_id, result, errstring);
			untyped __lua__("_G._hxdefold_self_ = nil");
		});
	}

	@:native('add_glyphs') private static function addGlyphs_(path:HashOrString, text:String,
		?callback:(Any, FontRequestId, Bool, Null<String>) -> Void):FontRequestId;

	/**
	 * Remove glyphs from the font.
	 *
	 * @param path The path to the .fontc resource
	 * @param text A string with unique unicode characters to be removed
	 * @return The asynchronous request id
	**/
	@:native('remove_glyphs')
	static function removeGlyphs(path:HashOrString, text:String):FontRequestId;
}

/** The ID for a font async request (add/remove glyphs). */
extern abstract FontRequestId(Int) {}
