package defold;

/**
    Functions and constants to access the window, window event listeners
    and screen dimming.
**/
@:native("_G.window")
extern final class Window
{
    /**
        Returns the current dimming mode set on a mobile device.

        The dimming mode specifies whether or not a mobile device should dim the screen after a period without user interaction.

        On platforms that does not support dimming, `DIMMING_UNKNOWN` is always returned.

        @return The mode for screen dimming
    **/
    @:pure
    @:native('get_dim_mode')
    static function getDimMode():WindowDimmingMode;

    /**
        This returns the current window size (width and height).

        @return The size of the window.
    **/
    @:pure
    @:native('get_size')
    static function getSize():WindowSize;

    /**
        Sets the dimming mode on a mobile device.

        The dimming mode specifies whether or not a mobile device should dim the screen after a period without user interaction.
        The dimming mode will only affect the mobile device while the game is in focus on the device, but not when the game is running in the background.

        This function has no effect on platforms that does not support dimming.

        @param mode The mode for screen dimming
    **/
    @:native('set_dim_mode')
    static function setDimMode(mode:WindowDimmingMode):Void;

    /**
        Sets a window event listener.

        @param callback A callback which receives info about window events. Can be null.
    **/
    static inline function setListener(callback:(event:WindowEvent, data:WindowEventData)->Void):Void
    {
        // 1. hide the reall callback parameter which expects a function with a "self" argument
        // 2. ensure that the global self reference is present for the callback
        setListener_((self, event, data) ->
        {
            untyped __lua__('_hxdefold_.self = _self');
            callback(event, data);
            untyped __lua__('_hxdefold_.self = nil');
        });
    }
    @:native('set_listener') private static function setListener_(callback:(Any, WindowEvent, WindowEventData)->Void):Void;

    /**
        Set the locking state for current mouse cursor on a PC platform.
        This function locks or unlocks the mouse cursor to the center point of the window.
        While the cursor is locked, mouse position updates will still be sent to the scripts as usual.

        @param flag The lock state for the mouse cursor
    **/
    @:native('set_mouse_lock')
    static function setMouseLock(flag:Bool):Void;

    /**
        This returns the current lock state of the mouse cursor.

        @return The lock state
    **/
    @:pure
    @:native('get_mouse_lock')
    static function getMouseLock():Bool;
}


/**
    Dimming mode is used to control whether or not a mobile device
    should dim the screen after a period without user interaction.
**/
@:native("_G.window")
extern enum abstract WindowDimmingMode({})
{
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
extern enum abstract WindowEvent({})
{
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
typedef WindowEventData =
{
    /**
        The width of a resize event. null otherwise.
    **/
    var ?width:Int;

    /**
        The height of a resize event. null otherwise.
    **/
    var ?height:Int;
}

/**
    Window size data, returned from `Window.get_size()`.
**/
@:multiReturn extern final class WindowSize
{
    /**
        The window width.
    **/
    var width:Int;

    /**
        The window height.
    **/
    var height:Int;
}
