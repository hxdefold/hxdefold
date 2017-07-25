package defold;

import defold.types.*;

/**
    Functions for mathematical operations on vectors, matrices and quaternions.

    * The vector types (`Vector3` and `Vector4`) supports addition, subtraction,
      negation and multiplication with numbers and other vectors of the same type.

    * The quaternion type (`Quaternion`) supports multiplication with other quaternions.

    * The matrix type (`Matrix4`) can be multiplied with numbers, other matrices and `Vector4` values.

    * All types performs equality comparison by each component value.
**/
@:native("_G.vmath")
extern class Vmath {
    /**
        Calculates the conjugate of a quaternion. The result is a
        quaternion with the same magnitudes but with the sign of
        the imaginary (vector) parts changed:

        `q* = [w, -v]`

        @param q1 quaternion of which to calculate the conjugate
        @return the conjugate
    **/
    static function conj(q1:Quaternion):Quaternion;

    /**
        Calculates the cross-product of two vectors.

        Given two linearly independent vectors P and Q, the cross product,
        P x Q, is a vector that is perpendicular to both P and Q and
        therefore normal to the plane containing them.

        If the two vectors have the same direction (or have the exact
        opposite direction from one another, i.e. are not linearly independent)
        or if either one has zero length, then their cross product is zero.

        @param v1 first vector
        @param v2 second vector
        @return a new vector representing the cross product
    **/
    static function cross(v1:Vector3, v2:Vector3):Vector3;

    /**
        Calculates the dot-product of two vectors.

        The returned value is a scalar defined as:

        `P &#x22C5; Q = |P| |Q| cos &#x03B8;`

        where &#x03B8; is the angle between the vectors P and Q.

         * If the dot product is >1.0 then the vectors are both pointing in the same direction.
         * If the dot product is zero the vectors are perpendicular (at right-angles to each other).
         * If the dot product is < 1.0 then the vectors are pointing in opposite directions.

        @param v1 first vector
        @param v1 second vector
        @return dot product
    **/
    @:overload(function(v1:Vector4, v2:Vector4):Float {})
    static function dot(v1:Vector3, v2:Vector3):Float;

    /**
        Calculates the inverse matrix..

        The resulting matrix is the inverse of the supplied matrix.

        For ortho-normal matrices, e.g. regular object transformation,
        use `Vmath.ortho_inv` instead.
        The specialized inverse for ortho-normalized matrices is much faster
        than the general inverse.

        @param m1 matrix to invert
        @return inverse of the supplied matrix
    **/
    static function inv(m1:Matrix4):Matrix4;

    /**
        Calculates the vector length.

        Returns the length of the supplied vector.

        @param v vector of which to calculate the length
        @return vector length
    **/
    @:overload(function(v:Vector4):Float {})
    static function length(v:Vector3):Float;

    /**
        Calculates the squared vector length.

        Returns the squared length of the supplied vector.

        @param v vector of which to calculate the squared length
        @return squared vector length
    **/
    @:overload(function(v:Vector4):Float {})
    static function length_sqr(v:Vector3):Float;

    /**
        Lerps between two vectors/quaternions/numbers.

        The function treats the vectors as positions and interpolates between
        the positions in a straight line. Lerp is useful to describe
        transitions from one place to another over time.

        Linear interpolation of rotations are only useful for small
        rotations. For interpolations of arbitrary rotations,
        `Vmath.slerp()` yields much better results.

        Number lerp is useful to describe transitions from one value to another over time.

        The function does not clamp t between 0 and 1.

        @param t interpolation parameter, 0-1
        @param v1 vector to lerp from
        @param v2 vector to lerp to
        @param n1 number to lerp from
        @param n2 number to lerp to
        @param q1 quaternion to lerp from
        @param q2 quaternion to lerp to
        @return the lerped vector/quaternion/number
    **/
    @:overload(function(t:Float, q1:Quaternion, q2:Quaternion):Quaternion {})
    @:overload(function(t:Float, n1:Float, n2:Float):Float {})
    @:overload(function(t:Float, v1:Vector4, v2:Vector4):Vector4 {})
    static function lerp(t:Float, v1:Vector3, v2:Vector3):Vector3;

    /**
        Creates a new matrix.

        If `m` is not specified, the resulting matrix is an indentity matrix,
        describing a transform with no translation or rotation.

        Otherwise creates a new matrix with all components set to the
        corresponding values from the supplied matrix. I.e.
        the function creates a copy of the given matrix.

        @param m1 existing matrix
        @return identity or copy matrix
    **/
    static function matrix4(?m1:Matrix4):Matrix4;

    /**
        Creates a matrix from an axis and an angle.

        The resulting matrix describes a rotation around the axis by the specified angle.

        @param v axis
        @param angle angle in radians
        @return matrix represented by axis and angle
    **/
    static function matrix4_axis_angle(v:Vector3, angle:Float):Matrix4;

    /**
        Creates a matrix from a quaternion.

        The resulting matrix describes the same rotation as the quaternion,
        but does not have any translation (also like the quaternion).

        @param q quaternion to create matrix from
        @return matrix represented by quaternion
    **/
    static function matrix4_from_quat(q:Quaternion):Matrix4;

    /**
        Creates a frustum matrix.

        Constructs a frustum matrix from the given values. The left, right,
        top and bottom coordinates of the view cone are expressed as distances
        from the center of the near clipping plane. The near and far coordinates
        are expressed as distances from the tip of the view frustum cone.

        @param left coordinate for left clipping plane
        @param right coordinate for right clipping plane
        @param bottom coordinate for bottom clipping plane
        @param top coordinate for top clipping plane
        @param near coordinate for near clipping plane
        @param far coordinate for far clipping plane
        @return matrix representing the frustum
    **/
    static function matrix4_frustum(left:Float, right:Float, bottom:Float, top:Float, near:Float, far:Float):Matrix4;

    /**
        Creates a look-at view matrix.

        The resulting matrix is created from the supplied look-at parameters.
        This is useful for constructing a view matrix for a camera or
        rendering in general.

        @param eye eye position
        @param look_at look-at position
        @param up up vector
        @return look-at matrix
    **/
    static function matrix4_look_at(eye:Vector3, look_at:Vector3, up:Vector3):Matrix4;

    /**
        Creates an orthographic projection matrix.
        This is useful to construct a projection matrix for a camera or rendering in general.

        @param left coordinate for left clipping plane
        @param right coordinate for right clipping plane
        @param bottom coordinate for bottom clipping plane
        @param top coordinate for top clipping plane
        @param near coordinate for near clipping plane
        @param far coordinate for far clipping plane
        @return orthographic projection matrix
    **/
    static function matrix4_orthographic(left:Float, right:Float, bottom:Float, top:Float, near:Float, far:Float):Matrix4;

    /**
        Creates a perspective projection matrix.
        This is useful to construct a projection matrix for a camera or rendering in general.

        @param fov angle of the full vertical field of view in radians
        @param aspect aspect ratio
        @param near coordinate for near clipping plane
        @param far coordinate for far clipping plane
        @return perspective projection matrix
    **/
    static function matrix4_perspective(fov:Float, aspect:Float, near:Float, far:Float):Matrix4;

    /**
        Creates a matrix from rotation around x-axis.

        The resulting matrix describes a rotation around the x-axis
        by the specified angle.

        @param angle angle in radians around x-axis
        @return matrix from rotation around x-axis
    **/
    static function matrix4_rotation_x(angle:Float):Matrix4;

    /**
        Creates a matrix from rotation around y-axis.

        The resulting matrix describes a rotation around the y-axis
        by the specified angle.

        @param angle angle in radians around y-axis
        @return matrix from rotation around y-axis
    **/
    static function matrix4_rotation_y(angle:Float):Matrix4;

    /**
        Creates a matrix from rotation around z-axis.

        The resulting matrix describes a rotation around the z-axis
        by the specified angle.

        @param angle angle in radians around z-axis
        @return matrix from rotation around z-axis
    **/
    static function matrix4_rotation_z(angle:Float):Matrix4;

    /**
        Normalizes a vector, i.e. returns a new vector with the same
        direction as the input vector, but with length 1.

        The length of the vector must be above 0, otherwise a
        division-by-zero will occur.

        @param v1 vector to normalize
        @return new normalized vector
    **/
    @:overload(function(v1:Vector4):Vector4 {})
    static function normalize(v1:Vector3):Vector3;

    /**
        Calculates the inverse of an ortho-normal matrix..

        The resulting matrix is the inverse of the supplied matrix.
        The supplied matrix has to be an ortho-normal matrix, e.g.
        describe a regular object transformation.

        For matrices that are not ortho-normal
        use the general inverse `Vmath.inv` instead.

        @param m1 ortho-normalized matrix to invert
        @return inverse of the supplied matrix
    **/
    static function ortho_inv(m1:Matrix4):Matrix4;

    /**
        Projects a vector onto another vector.

        Calculates the extent the projection of the first vector onto the second.
        The returned value is a scalar p defined as:

        `p = |P| cos &#x03B8; / |Q|`

        where &#x03B8; is the angle between the vectors P and Q.

        @param v1 vector to be projected on the second
        @param v2 vector onto which the first will be projected, must not have zero length
        @return the projected extent of the first vector onto the second
    **/
    static function project(v1:Vector3, v2:Vector3):Float;

    /**
        Creates a new quaternion from another existing quaternion, from its coordinates or a new identity quaternion,

        If `q` is not given, the identity quaternion is returned (equal to: `Vmath.quat(0, 0, 0, 1)`).
        Otherwise creates a new quaternion with all components set to the corresponding values from the supplied quaternion.
        I.e. This function creates a copy of the given quaternion.

        @param x x coordinate
        @param y y coordinate
        @param z z coordinate
        @param w w coordinate
    **/
    @:overload(function(?q1:Quaternion):Quaternion {})
    static function quat(x:Float, y:Float, z:Float, w:Float):Quaternion;

    /**
        Creates a quaternion to rotate around a unit vector.

        The resulting quaternion describes a rotation of `angle`
        radians around the axis described by the unit vector `v`.

        @param v axis
        @param angle angle
        @return quaternion representing the axis-angle rotation
    **/
    static function quat_axis_angle(v:Vector3, angle:Float):Quaternion;

    /**
        Creates a quaternion from three base unit vectors.

        The resulting quaternion describes the rotation from the
        identity quaternion (no rotation) to the coordinate system
        as described by the given x, y and z base unit vectors.

        @param x x base vector
        @param y y base vector
        @param z z base vector
        @return quaternion representing the rotation of the specified base vectors
    **/
    static function quat_basis(x:Vector3, y:Vector3, z:Vector3):Quaternion;

    /**
        Creates a quaternion to rotate between two unit vectors.

        The resulting quaternion describes the rotation that,
        if applied to the first vector, would rotate the first
        vector to the second. The two vectors must be unit
        length vectors (of length 1).

        The result is undefined if the two vectors point in opposite directions

        @param v1 first unit vector, before rotation
        @param v2 second unit vector, after rotation
        @return quaternion representing the rotation from first to second vector
    **/
    static function quat_from_to(v1:Vector3, v2:Vector3):Quaternion;

    /**
        Creates a quaternion from rotation around x-axis.

        The resulting quaternion describes a rotation of `angle`
        radians around the x-axis.

        @param angle angle in radians around x-axis
        @return quaternion representing the rotation around the x-axis
    **/
    static function quat_rotation_x(angle:Float):Quaternion;

    /**
        Creates a quaternion from rotation around y-axis.

        The resulting quaternion describes a rotation of `angle`
        radians around the y-axis.

        @param angle angle in radians around y-axis
        @return quaternion representing the rotation around the y-axis
    **/
    static function quat_rotation_y(angle:Float):Quaternion;

    /**
        Creates a quaternion from rotation around z-axis.

        The resulting quaternion describes a rotation of `angle`
        radians around the z-axis.

        @param angle angle in radians around z-axis
        @return quaternion representing the rotation around the z-axis
    **/
    static function quat_rotation_z(angle:Float):Quaternion;

    /**
        Rotates a vector by a quaternion.

        Returns a new vector from the supplied vector that is
        rotated by the rotation described by the supplied
        quaternion.

        @param q quaternion
        @param v vector to rotate
        @return the rotated vector
    **/
    static function rotate(q:Quaternion, v:Vector3):Vector3;

    /**
        Slerps between two vectors or quaternions.

        ---

        Spherically interpolates between two vectors. The difference to
        lerp is that slerp treats the vectors as directions instead of
        positions in space.

        The direction of the returned vector is interpolated by the angle
        and the magnitude is interpolated between the magnitudes of the
        from and to vectors.

        ---

        Slerp travels the torque-minimal path maintaining constant
        velocity, which means it travels along the straightest path along
        the rounded surface of a sphere. Slerp is useful for interpolation
        of rotations.

        Slerp travels the torque-minimal path, which means it travels
        along the straightest path the rounded surface of a sphere.

        ---

        Slerp is computationally more expensive than lerp.

        The function does not clamp t between 0 and 1.

        @param t interpolation parameter, 0-1
        @param v1 vector to slerp from
        @param v2 vector to slerp to
        @param q1 quaternion to slerp from
        @param q2 quaternion to slerp to
        @return the slerped vector
    **/
    @:overload(function(t:Float, q1:Quaternion, q2:Quaternion):Quaternion {})
    @:overload(function(t:Float, v1:Vector4, v2:Vector4):Vector4 {})
    static function slerp(t:Float, v1:Vector3, v2:Vector3):Vector3;

    /**
        Creates a new vector from a table of values.

        @param t table of numbers
        @return new vector
    **/
    // TODO: this should return some generic Vector type
    static function vector(t:lua.Table<Int,Float>):haxe.extern.EitherType<Vector3,Vector4>;

    /**
        Creates a new zero vector, a vector from scalar value, from another existing vector or from given coordinates.
    **/
    @:overload(function():Vector3 {})
    @:overload(function(n:Float):Vector3 {})
    @:overload(function(v:Vector3):Vector3 {})
    static function vector3(x:Float, y:Float, z:Float):Vector3;

    /**
        Creates a new zero vector, a vector from scalar value, from another existing vector or from given coordinates.
    **/
    @:overload(function():Vector4 {})
    @:overload(function(n:Float):Vector4 {})
    @:overload(function(v:Vector4):Vector4 {})
    static function vector4(x:Float, y:Float, z:Float, w:Float):Vector4;
}
