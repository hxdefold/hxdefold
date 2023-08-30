package defold.types;

/**
 * A reference hash to a run-time version of a material resource.
 */
abstract MaterialResourceReference(Hash) {

    /**
     * The empty material.
     *
     * Can be returned from a `get_material` function when no material has been assigned.
     */
    public var None(get, never): MaterialResourceReference;
    inline function get_None(): MaterialResourceReference
    {
        return cast Defold.hash('');
    }
}
