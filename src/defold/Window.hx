package defold;

/**
    Functions and constants to access the window, window event listeners
    and screen dimming.
**/
@:native("_G.window")
extern class Window {
    /**
        Returns the current dimming mode set on a mobile device.

        The dimming mode specifies whether or not a mobile device should dim the screen after a period without user interaction.

        On platforms that does not support dimming, `DIMMING_UNKNOWN` is always returned.

        @return The mode for screen dimming
    **/
    static function get_dim_mode():WindowDimmingMode;

    /**
        This returns the current window size (width and height).

        @return The size of the window.
    **/
    static function get_size():WindowSize;

    /**
        Sets the dimming mode on a mobile device.

        The dimming mode specifies whether or not a mobile device should dim the screen after a period without user interaction.
        The dimming mode will only affect the mobile device while the game is in focus on the device, but not when the game is running in the background.

        This function has no effect on platforms that does not support dimming.

        @param mode The mode for screen dimming
    **/
    static function set_dim_mode(mode:WindowDimmingMode):Void;

    /**
        Sets a window event listener.

        @param callback A callback which receives info about window events. Can be null.
    **/
    static function set_listener<T>(callback:T->WindowEvent->WindowEventData->Void):Void;

    /**
        Set the locking state for current mouse cursor on a PC platform.
        This function locks or unlocks the mouse cursor to the center point of the window.
        While the cursor is locked, mouse position updates will still be sent to the scripts as usual.

        @param flag The lock state for the mouse cursor
    **/
    static function set_mouse_lock(flag:Bool):Void;

    /**
        This returns the current lock state of the mouse cursor.

        @return The lock state
    **/
    static function get_mouse_lock():Bool;
}


/**
    Dimming mode is used to control whether or not a mobile device
    should dim the screen after a period without user interaction.
**/
@:native("_G.window")
@:enum extern abstract WindowDimmingMode({}) {
    /**
        Dimming off
    **/
    var DIMMING_OFF;

    /**
        Dimming on
    **/
    var DIMMING_ON;

    /**
        This mode indicates that the dim mode can't be determined,
        or that the platform doesn't support dimming.
    **/
    var DIMMING_UNKNOWN;
}


/**
    Window events, used in `Window.set_listener` callbacks.
**/
@:native("_G.window")
@:enum extern abstract WindowEvent({}) {
    /**
        Deiconified window event.

        This event is sent to a window event listener when the game window or app screen
        is restored after being iconified.
    **/
    var WINDOW_EVENT_DEICONIFIED;

    /**
        Iconify window event.

        This event is sent to a window event listener when the game window or app screen
        is iconified (reduced to an application icon in a toolbar, application tray or similar).
    **/
    var WINDOW_EVENT_ICONFIED;

    /**
        Focus gained window event.

        This event is sent to a window event listener when the game window or app screen has
        gained focus.
        This event is also sent at game startup and the engine gives focus to the game.
    **/
    var WINDOW_EVENT_FOCUS_GAINED;

    /**
        Focus lost window event.

        This event is sent to a window event listener when the game window or app screen has lost focus.
    **/
    var WINDOW_EVENT_FOCUS_LOST;

    /**
        Resized window event.

        This event is sent to a window event listener when the game window or app screen is resized.
        The new size is passed along in the data field to the event listener.
    **/
    var WINDOW_EVENT_RESIZED;
}


/**
    Window event data, used in `Window.set_listener` callbacks.
**/
typedef WindowEventData = {
    /**
        The width of a resize event. null otherwise.
    **/
    @:optional var width:Int;

    /**
        The height of a resize event. null otherwise.
    **/
    @:optional var height:Int;
}

/**
    Window size data, returned from `Window.get_size()`.
**/
@:multiReturn extern class WindowSize {
    /**
        The window width.
    **/
    var width:Int;

    /**
        The window height.
    **/
    var height:Int;
}
