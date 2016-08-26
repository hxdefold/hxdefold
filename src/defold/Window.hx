package defold;

/**
    Getting access to the window, window event listeners and screen dimming.
**/
@:native("_G.window")
extern class Window {
    /**
        Get the mode for screen dimming
    **/
    static function get_dim_mode():WindowDimmingMode;

    /**
        Set the mode for screen dimming
    **/
    static function set_dim_mode(mode:WindowDimmingMode):Void;

    /**
        Sets a window event listener
    **/
    static function set_listener<T>(callback:T->WindowEvent->WindowEventData->Void):Void;
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
    var WINDOW_EVENT_FOCUS_LOST;
    var WINDOW_EVENT_FOCUS_GAINED;
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
