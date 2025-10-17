package defold.types;

import haxe.extern.EitherType;

/** *
 * Shortcut type that can be either either String or Hash or Url.
 *
 * Some functions in Defold accept both String, Hash and Url objects,
 * so this type is used to represent that.
* */
typedef HashOrStringOrUrl = EitherType<Hash,EitherType<String,Url>>
