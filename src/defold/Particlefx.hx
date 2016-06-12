package defold;

import defold.types.*;

/**
    Functions for controlling particle effect components.
**/
@:native("_G.particlefx")
extern class Particlefx {
    /**
        Start playing a particle FX.

        Particle FX started this way need to be manually stopped through `Particlefx.stop`.
    **/
    static function play(url:UrlOrString):Void;

    /**
        Reset a shader constant for a particle FX emitter.

        The constant must be defined in the material assigned to the emitter.
        Resetting a constant through this function implies that the value defined in the material will be used.
    **/
    static function reset_constant(url:UrlOrString, emitter_id:HashOrString, name:HashOrString):Void;

    /**
        Set a shader constant for a particle FX emitter.

        The constant must be defined in the material assigned to the emitter.
        Setting a constant through this function will override the value set for that constant in the material.
        The value will be overridden until `Particlefx.reset_constant` is called.
    **/
    static function set_constant(url:UrlOrString, emitter_id:HashOrString, name:HashOrString, value:Vector4):Void;

    /**
        Stop playing a particle fx.

        Stopping a particle FX does not remove the already spawned particles.
    **/
    static function stop(url:UrlOrString):Void;
}
