package defold.types;

/**
    A typed property.

    This abstracts wraps Hash and allows linking property
    type to its name. This is used to provide type-safe access to
    game object properties.
**/
abstract Property<T>(Hash) {
    public inline function new(name:String) this = Defold.hash(name);
}

/**
    A typed Vector3 property.
**/
abstract Vector3Property(Property<Vector3>) from Property<Vector3> to Property<Vector3> {
    public inline function new(name:String) this = new Property(name);

    /**
        Property pointing to the x component of this property.
    **/
    public var x(get,never):Property<Float>;
    inline function get_x() return new Property<Float>(this + ".x");

    /**
        Property pointing to the y component of this property.
    **/
    public var y(get,never):Property<Float>;
    inline function get_y() return new Property<Float>(this + ".y");

    /**
        Property pointing to the z component of this property.
    **/
    public var z(get,never):Property<Float>;
    inline function get_z() return new Property<Float>(this + ".z");
}

/**
    A typed Vector4 property.
**/
abstract Vector4Property(Property<Vector4>) from Property<Vector4> to Property<Vector4> {
    public inline function new(name:String) this = new Property(name);

    /**
        Property pointing to the x component of this property.
    **/
    public var x(get,never):Property<Float>;
    inline function get_x() return new Property<Float>(this + ".x");

    /**
        Property pointing to the y component of this property.
    **/
    public var y(get,never):Property<Float>;
    inline function get_y() return new Property<Float>(this + ".y");

    /**
        Property pointing to the z component of this property.
    **/
    public var z(get,never):Property<Float>;
    inline function get_z() return new Property<Float>(this + ".z");

    /**
        Property pointing to the z component of this property.
    **/
    public var w(get,never):Property<Float>;
    inline function get_w() return new Property<Float>(this + ".w");
}

/**
    A typed Quaternion property.
**/
abstract QuaternionProperty(Property<Quaternion>) from Property<Quaternion> to Property<Quaternion> {
    public inline function new(name:String) this = new Property(name);

    /**
        Property pointing to the x component of this property.
    **/
    public var x(get,never):Property<Float>;
    inline function get_x() return new Property<Float>(this + ".x");

    /**
        Property pointing to the y component of this property.
    **/
    public var y(get,never):Property<Float>;
    inline function get_y() return new Property<Float>(this + ".y");

    /**
        Property pointing to the z component of this property.
    **/
    public var z(get,never):Property<Float>;
    inline function get_z() return new Property<Float>(this + ".z");

    /**
        Property pointing to the z component of this property.
    **/
    public var w(get,never):Property<Float>;
    inline function get_w() return new Property<Float>(this + ".w");
}
