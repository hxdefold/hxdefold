package defold;

/**
    Timers allow you to set a delay and a callback to be called when the timer completes.
    The timers created with this API are updated with the collection timer where they
    are created. If you pause or speed up the collection (using `set_time_step`) it will
    also affect the new timer.
**/
@:native("_G.timer")
extern class Timer {
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
        @return identifier for the create timer, returns `Timer.INVALID_TIMER_HANDLE` if the timer can not be created
    **/
    static function delay<T>(delay:Float, repeat:Bool, callback:(self:T, handle:TimerHandle, time_elapsed:Float)->Void):TimerHandle;

    /**
        Manual triggering a callback for a timer.

        @param handle the timer handle returned by `timer.delay()`
        @return `true` if the timer was active, `false` if the timer is already cancelled / complete
    **/
    static function trigger(handle:TimerHandle):Bool;

    /**
        Indicates an invalid timer handle.
    **/
    static var INVALID_TIMER_HANDLE(default, never):TimerHandle;
}

extern class TimerHandle {}
