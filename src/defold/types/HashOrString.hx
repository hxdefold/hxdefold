package defold.types;

import haxe.extern.EitherType;

/** *
 * Shortcut type that can be either either String or Hash.
 *
 * Many functions in Defold accept both String and Hash, so this
 * type is used to represent that.
* */
typedef HashOrString = EitherType<Hash,String>
