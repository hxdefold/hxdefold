package defold;

import defold.types.Matrix4;
import defold.types.Message;
import defold.types.Property;
import defold.types.HashOrStringOrUrl;

/** *
 * Messages related to the `Camera` module.
 **/
@:publicFields
class CameraMessages {
	/**	 *
	 * Makes the receiving camera become the active camera.
	 *
	 * Post this message to a camera-component to activate it.
	 *
	 * Several cameras can be active at the same time, but only the camera that was last activated will be used for rendering.
	 * When the camera is deactivated (see `release_camera_focus`), the previously activated camera will again be used for rendering automatically.
	 *
	 * The reason it is called "camera focus" is the similarity to how acquiring input focus works (see `acquire_input_focus`).
	* */
	static var acquire_camera_focus(default, never) = new Message<Void>("acquire_camera_focus");

	/**	 *
	 * Deactivates the receiving camera.
	 *
	 * Post this message to a camera-component to deactivate it. The camera is then removed from the active cameras.
	 * See `acquire_camera_focus` for more information how the active cameras are used in rendering.
	* */
	static var release_camera_focus(default, never) = new Message<Void>("release_camera_focus");

	/**	 *
	 * Sets camera properties.
	 *
	 * Post this message to a camera-component to set its properties at run-time.
	* */
	static var set_camera(default, never) = new Message<CameraMessageSetCamera>("set_camera");
}

/** *
 * Data for the `CameraMessages.set_camera` message.
* */
typedef CameraMessageSetCamera = {
	/**	 *
	 * Aspect ratio of the screen (width divided by height)
	* */
	var aspect_ratio:Float;

	/**	 *
	 * Field of view of the lens, measured as the angle in radians between the right and left edge
	* */
	var fov:Float;

	/**	 *
	 * Position of the near clipping plane (distance from camera along relative z)
	* */
	var near_z:Float;

	/**	 *
	 * Position of the far clipping plane (distance from camera along relative z)
	* */
	var far_z:Float;

	/**	 *
	 * Set to use an orthographic projection
	* */
	var orthographic_projection:Bool;

	/**	 *
	 * Zoom level when the camera is using an orthographic projection
	* */
	var orthographic_zoom:Float;

	/**	 *
	 * Orthographic zoom behavior when orthographic_projection is enabled.
	* */
	@:optional var orthographic_mode:CameraOrthoMode;
}

@:publicFields
class CameraProperties {
	/**	 *
	 * Vertical field of view of the camera.
	* */
	static var fov(default, never) = new Property<Float>("fov");

	/**	 *
	 * Camera frustum near plane.
	* */
	static var near_z(default, never) = new Property<Float>("near_z");

	/**	 *
	 * Camera frustum far plane.
	* */
	static var far_z(default, never) = new Property<Float>("far_z");

	/**	 *
	 * Zoom level when using an orthographic projection.
	* */
	static var orthographic_zoom(default, never) = new Property<Float>("orthographic_zoom");

	/**	 *
	 * The calculated projection matrix of the camera. (READ ONLY)
	* */
	static var projection(default, never) = new Property<Matrix4>("projection");

	/**	 *
	 * The calculated view matrix of the camera. (READ ONLY)
	* */
	static var view(default, never) = new Property<Matrix4>("view");

	/**	 *
	 * The ratio between the frustum width and height. Used when calculating the projection of a perspective camera.
	* */
	static var aspect_ratio(default, never) = new Property<Float>("aspect_ratio");
}

/** *
 * Camera runtime API functions.
* */
@:native("_G.camera")
extern final class Camera {
	/**	 *
	 * Returns true if a camera component is enabled.
	 *
	 * @param camera camera id (url|hash|string)
	 * @return true if the camera is enabled
	* */
	@:native('get_enabled')
	static function getEnabled(camera:HashOrStringOrUrl):Bool;

	/**	 *
	 * Returns all camera URLs registered in the render context.
	 *
	 * @return a table with all camera URLs
	* */
	@:pure
	@:native('get_cameras')
	static function getCameras():lua.Table<Any, defold.types.Url>;

	/**	 *
	 * Gets the effective aspect ratio of the camera.
	 *
	 * If auto aspect ratio is enabled, returns the aspect ratio calculated from the current render target.
	 * Otherwise returns the manually set aspect ratio.
	 *
	 * @param camera camera id
	 * @return the effective aspect ratio
	* */
	@:native('get_aspect_ratio') static function getAspectRatio(camera:HashOrStringOrUrl):Float;

	/**	 *
	 * Returns whether auto aspect ratio calculation is enabled.
	 *
	 * When enabled, the camera automatically calculates aspect ratio from render target dimensions.
	 * When disabled, uses the manually set aspect ratio value.
	 *
	 * @param camera camera id
	 * @return true if auto aspect ratio is enabled
	* */
	@:native('get_auto_aspect_ratio') static function getAutoAspectRatio(camera:HashOrStringOrUrl):Bool;

	/**	 *
	 * Returns the far z for the camera frustum.
	 *
	 * @param camera camera id
	 * @return the far z
	* */
	@:native('get_far_z') static function getFarZ(camera:HashOrStringOrUrl):Float;

	/**	 *
	 * Returns the vertical field of view.
	 *
	 * @param camera camera id
	 * @return the field of view
	* */
	@:native('get_fov') static function getFov(camera:HashOrStringOrUrl):Float;

	/**	 *
	 * Returns the near z for the camera frustum.
	 *
	 * @param camera camera id
	 * @return the near z
	* */
	@:native('get_near_z') static function getNearZ(camera:HashOrStringOrUrl):Float;

	/**	 *
	 * Returns the orthographic zoom mode.
	 *
	 * @param camera camera id
	 * @return one of CameraOrthoMode values
	* */
	@:native('get_orthographic_mode') static function getOrthographicMode(camera:HashOrStringOrUrl):CameraOrthoMode;

	/**	 *
	 * Returns the orthographic zoom value.
	 *
	 * @param camera camera id
	 * @return the orthographic zoom
	* */
	@:native('get_orthographic_zoom') static function getOrthographicZoom(camera:HashOrStringOrUrl):Float;

	/**	 *
	 * Returns the calculated projection matrix.
	 *
	 * @param camera camera id
	 * @return the projection matrix
	* */
	@:native('get_projection') static function getProjection(camera:HashOrStringOrUrl):Matrix4;

	/**	 *
	 * Returns the calculated view matrix.
	 *
	 * @param camera camera id
	 * @return the view matrix
	* */
	@:native('get_view') static function getView(camera:HashOrStringOrUrl):Matrix4;

	/**	 *
	 * Sets the manual aspect ratio for the camera.
	 *
	 * This value is only used when auto aspect ratio is disabled.
	 *
	 * @param camera camera id
	 * @param aspect_ratio the manual aspect ratio value
	* */
	@:native('set_aspect_ratio') static function setAspectRatio(camera:HashOrStringOrUrl, aspect_ratio:Float):Void;

	/**	 *
	 * Enables or disables automatic aspect ratio calculation.
	 *
	 * When enabled (true), the camera automatically calculates aspect ratio from render target dimensions.
	 * When disabled (false), uses the manually set aspect ratio value.
	 *
	 * @param camera camera id
	 * @param auto true to enable auto aspect ratio
	* */
	@:native('set_auto_aspect_ratio') static function setAutoAspectRatio(camera:HashOrStringOrUrl, auto:Bool):Void;

	/**	 *
	 * Sets the far z of the camera frustum.
	 *
	 * @param camera camera id
	 * @param far_z the far z
	* */
	@:native('set_far_z') static function setFarZ(camera:HashOrStringOrUrl, far_z:Float):Void;

	/**	 *
	 * Sets the vertical field of view.
	 *
	 * @param camera camera id
	 * @param fov the field of view
	* */
	@:native('set_fov') static function setFov(camera:HashOrStringOrUrl, fov:Float):Void;

	/**	 *
	 * Sets the near z of the camera frustum.
	 *
	 * @param camera camera id
	 * @param near_z the near z
	* */
	@:native('set_near_z') static function setNearZ(camera:HashOrStringOrUrl, near_z:Float):Void;

	/**	 *
	 * Sets the orthographic zoom mode.
	 *
	 * @param camera camera id
	 * @param mode one of CameraOrthoMode values
	* */
	@:native('set_orthographic_mode') static function setOrthographicMode(camera:HashOrStringOrUrl, mode:CameraOrthoMode):Void;

	/**	 *
	 * Sets the orthographic zoom value.
	 *
	 * @param camera camera id
	 * @param zoom the orthographic zoom value
	* */
	@:native('set_orthographic_zoom') static function setOrthographicZoom(camera:HashOrStringOrUrl, zoom:Float):Void;
}

/** *
 * Camera orthographic zoom mode constants.
* */
@:native("_G.camera")
extern enum abstract CameraOrthoMode(Int) {
	@:native('ORTHO_MODE_FIXED') var Fixed;
	@:native('ORTHO_MODE_AUTO_FIT') var AutoFit;
	@:native('ORTHO_MODE_AUTO_COVER') var AutoCover;
}
