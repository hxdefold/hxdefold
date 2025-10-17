package defold;

/** *
 * Functions for checking Defold userdata types.
 **/
@:native("_G.types")
extern final class Types {
	/** Check if passed value is a hash */
	@:native('is_hash') static function isHash(v:Any):Bool;

	/** Check if passed value is matrix4 */
	@:native('is_matrix4') static function isMatrix4(v:Any):Bool;

	/** Check if passed value is quaternion */
	@:native('is_quat') static function isQuat(v:Any):Bool;

	/** Check if passed value is URL */
	@:native('is_url') static function isUrl(v:Any):Bool;

	/** Check if passed value is vector */
	@:native('is_vector') static function isVector(v:Any):Bool;

	/** Check if passed value is vector3 */
	@:native('is_vector3') static function isVector3(v:Any):Bool;

	/** Check if passed value is vector4 */
	@:native('is_vector4') static function isVector4(v:Any):Bool;
}
