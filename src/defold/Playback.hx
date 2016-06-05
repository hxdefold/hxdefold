package defold;

@:native("go")
@:enum extern abstract Playback(Dynamic) {
    var PLAYBACK_ONCE_FORWARD;
    var PLAYBACK_ONCE_BACKWARD;
    var PLAYBACK_ONCE_PINGPONG;
    var PLAYBACK_LOOP_FORWARD;
    var PLAYBACK_LOOP_BACKWARD;
    var PLAYBACK_LOOP_PINGPONG;
}
