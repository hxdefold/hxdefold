package defold.types;

import haxe.extern.EitherType;

/** *
 * Shortcut type that can be either either String or Url.
 *
 * Many functions in Defold accept both String and Url, so this
 * type is used to represent that.
* */
typedef UrlOrString = EitherType<Url,String>
