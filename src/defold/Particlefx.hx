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

        @param url the particle fx that should start playing
        @param emitter_state_cb optional callback that will be called when an emitter attached to this particlefx changes state.
    **/
    static function play<T>(url:UrlOrString, ?emitter_state_cb:T->Hash->Hash->ParticlefxEmitterState->Void):Void;

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

@:native("_G.particlefx")
@:enum extern abstract ParticlefxEmitterState({}) {
    /**
        postspawn state

        The emitter is not spawning any particles, but has particles that are still alive.
    **/
    var EMITTER_STATE_POSTSPAWN;

    /**
        prespawn state

        The emitter will be in this state when it has been started but before spawning any particles.
        Normally the emitter is in this state for a short time, depending on if a start delay has been set for this emitter or not.
    **/
    var EMITTER_STATE_PRESPAWN;

    /**
        sleeping state

        The emitter does not have any living particles and will not spawn any particles in this state.
    **/
    var EMITTER_STATE_SLEEPING;

    /**
        spawning state

        The emitter is spawning particles.
    **/
    var EMITTER_STATE_SPAWNING;
}
