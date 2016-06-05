package defold;

import defold.support.HashOrString;

@:native("particlefx")
extern class Particlefx {
    static function play(url:Url):Void;
    static function reset_constant(url:Url, emitter_id:HashOrString, name:HashOrString):Void;
    static function set_constant(url:Url, emitter_id:HashOrString, name:HashOrString, value:Vector4):Void;
    static function stop(url:Url):Void;
}
