package defold;

import defold.types.Hash;

/**
    Timers allow you to set a delay and a callback to be called when the timer completes.
    The timers created with this API are updated with the collection timer where they
    are created. If you pause or speed up the collection (using `set_time_step`) it will
    also affect the new timer.
**/
@:native("_G.timer")
extern class Timer
{
    /**
        Cancel a timer.

        You may cancel a timer from inside a timer callback.
        Cancelling a timer that is already executed or cancelled is safe.

        @param handle the timer handle returned by timer.delay()
        @return true if the timer was active, false if the timer is already cancelled / complete
    **/
    static function cancel(handle:TimerHandle):Bool;

    /**
        Create a timer.

        Adds a timer and returns a unique handle

        You may create more timers from inside a timer callback.

        Using a delay of 0 will result in a timer that triggers at the next frame just before
        script update functions.

        If you want a timer that triggers on each frame, set delay to 0.0f and repeat to true.

        Timers created within a script will automatically die when the script is deleted.

        @param delay time interval in seconds
        @param repeat true = repeat timer until cancel, false = one-shot timer
        @param callback timer callback function
        @return identifier for the create timer, returns `TimerHandle.Invalid` if the timer can not be created
    **/
    static function delay<T>(delay:Float, repeat:Bool, callback:(self:T, handle:TimerHandle, timeElapsed:Float)->Void):TimerHandle;

    /**
        Manual triggering a callback for a timer.

        @param handle the timer handle returned by `timer.delay()`
        @return `true` if the timer was active, `false` if the timer is already cancelled / complete
    **/
    static function trigger(handle:TimerHandle):Bool;

    /**
        Get information about timer.

        @param handle the timer handle returned by `timer.delay()`
        @return the timer info, or `null` if timer is cancelled/completed
     */
    @:pure
    @:native('get_info')
    static function getInfo(handle:TimerHandle):TimerInfo;
}

@:native("_G.timer")
extern enum abstract TimerHandle(Hash)
{
    @:native('INVALID_TIMER_HANDLE')
    var Invalid;
}

/**
    Timer information returned by the `get_info()` method.
**/
extern class TimerInfo
{
    /** Time remaining until the next time a timer.delay() fires. */
    @:native('time_remaining')
    var timeRemaining:Float;

    /** Time interval. */
    var delay: Float;

    /** `true` = repeat timer until cancel, `false` = one-shot timer. */
    var repeat: Bool;
}
