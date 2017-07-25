package defold;

import defold.types.*;

/**
    Functions for controlling particle effect component playback and
    shader constants.
**/
@:native("_G.particlefx")
extern class Particlefx {
    /**
        Start playing a particle FX.

        Particle FX started this way need to be manually stopped through `Particlefx.stop`.
        Which particle FX to play is identified by the URL.

        @param url the particle fx that should start playing
        @param emitter_state_cb optional callback that will be called when an emitter attached to this particlefx changes state.
        The callback receives the hash of the path to the particlefx, the hash of the id of the emitter, and the new state of the emitter.
    **/
    static function play<T>(url:UrlOrString, ?emitter_state_cb:T->Hash->Hash->ParticlefxEmitterState->Void):Void;

    /**
        Reset a shader constant for a particle FX emitter.

        The constant must be defined in the material assigned to the emitter.
        Resetting a constant through this function implies that the value defined in the material will be used.
        Which particle FX to reset a constant for is identified by the URL.

        @param url the particle FX that should have a constant reset
        @param emitter_id the id of the emitter
        @param name the name of the constant
    **/
    static function reset_constant(url:UrlOrString, emitter_id:HashOrString, name:HashOrString):Void;

    /**
        Set a shader constant for a particle FX emitter.

        The constant must be defined in the material assigned to the emitter.
        Setting a constant through this function will override the value set for that constant in the material.
        The value will be overridden until particlefx.reset_constant is called.
        Which particle FX to set a constant for is identified by the URL.

        @param url the particle FX that should have a constant set
        @param emitter_id the id of the emitter
        @param name the name of the constant
        @param value the value of the constant
    **/
    static function set_constant(url:UrlOrString, emitter_id:HashOrString, name:HashOrString, value:Vector4):Void;

    /**
        Stop playing a particle fx.

        Stopping a particle FX does not remove the already spawned particles.
        Which particle fx to stop is identified by the URL.

        @param url the particle fx that should stop playing
    **/
    static function stop(url:UrlOrString):Void;
}

@:native("_G.particlefx")
@:enum extern abstract ParticlefxEmitterState({}) {
    /**
        Sleeping state.

        The emitter does not have any living particles and will not spawn any particles in this state.
    **/
    var EMITTER_STATE_SLEEPING;

    /**
        Prespawn state.

        The emitter will be in this state when it has been started but before spawning any particles.
        Normally the emitter is in this state for a short time, depending on if a start delay has been set for this emitter or not.
    **/
    var EMITTER_STATE_PRESPAWN;

    /**
        Spawning state.

        The emitter is spawning particles.
    **/
    var EMITTER_STATE_SPAWNING;

    /**
        Postspawn state.

        The emitter is not spawning any particles, but has particles that are still alive.
    **/
    var EMITTER_STATE_POSTSPAWN;
}
