package defold;

import defold.types.*;

/**
    Functions and messages for using system resources, controlling the engine,
    error handling and debugging.

    See `SysMessages` for standard system messages.
**/
@:native("_G.sys")
extern class Sys {
    /**
        Exits application.

        Terminates the game application and reports the specified `code` to the OS.

        @param code exit code to report to the OS, 0 means clean exit
    **/
    static function exit(code:Int):Void;

    /**
        Reboot engine with arguments.

        Reboots the game engine with a specified set of arguments.
        Arguments will be translated into command line arguments. Calling reboot
        function is equivalent to starting the engine with the same arguments.

        On startup the engine reads configuration from "game.project" in the
        project root.
    **/
    static function reboot(?arg1:String, ?arg2:String, ?arg3:String, ?arg4:String, ?arg5:String, ?arg6:String):Void;

    /**
        Set update frequency.

        Set game update-frequency (frame cap). This option is equivalent to `display.update_frequency` in
        the "game.project" settings but set in run-time. If `Vsync` checked in "game.project", the rate will
        be clamped to a swap interval that matches any detected main monitor refresh rate. If `Vsync` is
        unchecked the engine will try to respect the rate in software using timers. There is no
        guarantee that the frame cap will be achieved depending on platform specifics and hardware settings.

        @param frequency target frequency. 60 for 60 fps
    **/
    static function set_update_frequency(frequency:Int):Void;

    /**
        Set vsync swap interval.

        Set the vsync swap interval. The interval with which to swap the front and back buffers
        in sync with vertical blanks (v-blank), the hardware event where the screen image is updated
        with data from the front buffer. A value of 1 swaps the buffers at every v-blank, a value of
        2 swaps the buffers every other v-blank and so on. A value of 0 disables waiting for v-blank
        before swapping the buffers. Default value is 1.

        When setting the swap interval to 0 and having `vsync` disabled in
        "game.project", the engine will try to respect the set frame cap value from
        "game.project" in software instead.

        This setting may be overridden by driver settings.

        @param swap_interval target swap interval.
    **/
    static function set_vsync_swap_interval(swap_interval:Int):Void;

    /**
        Get application information.

        @return table with application information
    **/
    static function get_application_info(_:String):SysApplicationInfo; // TODO: wtf is this string arg?

    /**
        The path from which the application is run.

        @return path to application executable
    **/
    static function get_application_path(): String;

    /**
        Get config value from the game.project configuration file.

        In addition to the project file, configuration values can also be passed
        to the runtime as command line arguments with the `--config` argument.

        @param key key to get value for. The syntax is SECTION.KEY
        @param default_value default value to return if the value does not exist
        @return config value as a string. nil or default_value if the config key doesn't exists
    **/
    @:overload(function(key:String, default_value:String):String {})
    static function get_config(key:String):Null<String>;

    /**
        Returns the current network connectivity status on mobile platforms.

        On desktop, this function always return `NETWORK_CONNECTED`.
    **/
    static function get_connectivity():SysConnectivity;

    /**
        Get engine information.

        @return table with engine information
    **/
    static function get_engine_info():SysEngineInfo;

    /**
        Enumerate network cards.

        @return an array of tables
    **/
    static function get_ifaddrs():lua.Table<Int,SysIfaddr>;

    /**
        Gets the save-file path.

        The save-file path is operating system specific and is typically located under the users home directory.

        @param application_id user defined id of the application, which helps define the location of the save-file
        @param file_name file-name to get path for
        @return path to save-file
    **/
    static function get_save_file(application_id:String, file_name:String):String;

    /**
        Get system information.

        @return table with system information
    **/
    static function get_sys_info():SysSysInfo;

    /**
        Loads a lua table from a file on disk.

        If the file exists, it must have been created by `Sys.save` to be loaded.

        @param filename file to read from
        @return loaded lua table, which is empty if the file could not be found
    **/
    static function load(filename:String):lua.Table.AnyTable;

    /**
        Loads resource from game data.

        Loads a custom resource. Specify the full filename of the resource that you want
        to load. When loaded, the file data is returned as a string.
        If loading fails, the function returns nil.

        In order for the engine to include custom resources in the build process, you need
        to specify them in the "custom_resources" key in your "game.project" settings file.
        You can specify single resource files or directories. If a directory is included
        in the resource list, all files and directories in that directory is recursively
        included:

        For example "main/data/,assets/level_data.json".

        @param filename resource to load, full path
        @return loaded data, which is empty if the file could not be found
    **/
    static function load_resource(filename:String):SysResource;

    /**
        Open url in default application.

        Open URL in default application, typically a browser

        @param url url to open
        @return a boolean indicating if the url could be opened or not
    **/
    static function open_url(url:String):Bool;

    /**
        Saves a lua table to a file stored on disk.

        The table can later be loaded by `sys.load`.
        Use `sys.get_save_file` to obtain a valid location for the file.
        Internally, this function uses a workspace buffer sized output file sized 512kb.
        This size reflects the output file size which must not exceed this limit.
        Additionally, the total number of rows that any one table may contain is limited to 65536
        (i.e. a 16 bit range). When tables are used to represent arrays, the values of
        keys are permitted to fall within a 32 bit range, supporting sparse arrays, however
        the limit on the total number of rows remains in effect.

        @param filename file to write to
        @param table lua table to save
        @return a boolean indicating if the table could be saved or not
    **/
    static function save(filename:String, table:lua.Table.AnyTable):Bool;

    /**
        Set host to check for network connectivity against.

        @param host hostname to check against
    **/
    static function set_connectivity_host(host:String):Void;

    /**
        Set the error handler. The error handler is a function which is called whenever a lua runtime error occurs..

        @param error_handler the function to be called on error (arguments: source, message, traceback)
    **/
    static function set_error_handler(error_handler:String->String->String->Void):Void;


    /**
        The buffer can later deserialized by `sys.deserialize()`. This method has all the same limitations as `sys.save()`.

        @param buffer lua table to serialize
        @return serialized data buffer
    **/
    static function serialize(buffer:lua.Table.AnyTable):String;


    /**
        Deserializes buffer into a lua table.

        @param buffer buffer to deserialize from
        @return lua table with deserialized data
    **/
    static function deserialize(buffer:String):lua.Table.AnyTable;
}

/**
    Messages handled by the system (send to the `@system:` socket).
**/
@:publicFields
class SysMessages {
    /**
        Exits application.

        Terminates the game application and reports the specified `code` to the OS.
        This message can only be sent to the designated `@system` socket.
    **/
    static var exit(default, never) = new Message<SysMessageExit>("exit");

    /**
        Reboot engine with arguments.

        Arguments will be translated into command line arguments. Sending the reboot
        command is equivalent to starting the engine with the same arguments.

        On startup the engine reads configuration from "game.project" in the
        project root.

        This message can only be sent to the designated `@system` socket.
    **/
    static var reboot(default, never) = new Message<SysMessageReboot>("reboot");

    /**
        Set update frequency.

        Set game update-frequency (frame cap). This option is equivalent to `display.update_frequency` in
        the "game.project" settings but set in run-time. If `Vsync` checked in "game.project", the rate will
        be clamped to a swap interval that matches any detected main monitor refresh rate. If `Vsync` is
        unchecked the engine will try to respect the rate in software using timers. There is no
        guarantee that the frame cap will be achieved depending on platform specifics and hardware settings.
    **/
    static var set_update_frequency(default, never) = new Message<SysMessageSetUpdateFrequency>("set_update_frequency");

    /**
        Set vsync swap interval.

        Set the vsync swap interval. The interval with which to swap the front and back buffers
        in sync with vertical blanks (v-blank), the hardware event where the screen image is updated
        with data from the front buffer. A value of 1 swaps the buffers at every v-blank, a value of
        2 swaps the buffers every other v-blank and so on. A value of 0 disables waiting for v-blank
        before swapping the buffers. Default value is 1.

        When setting the swap interval to 0 and having `vsync` disabled in
        "game.project", the engine will try to respect the set frame cap value from
        "game.project" in software instead.

        This setting may be overridden by driver settings.

        This message can only be sent to the designated `@system` socket.
    **/
    static var set_vsync(default, never) = new Message<SysMessageSetVsync>("set_vsync");

    /**
        Starts video recording.

        Starts video recording of the game frame-buffer to file. Current video format is the
        open vp8 codec in the ivf container. It's possible to upload this format directly
        to YouTube. The VLC video player has native support but with the known issue that
        not the entire file is played back. It's probably an issue with VLC.
        The Miro Video Converter has support for vp8/ivf.
        Video recording is only supported on desktop platforms.
        NOTE: Audio is currently not supported
        NOTE: Window width and height must be a multiple of 8 to be able to record video.
    **/
    static var start_record(default, never) = new Message<SysMessageStartRecord>("start_record");

    /**
        Stops the currently active video recording.

        Video recording is only supported on desktop platforms.
    **/
    static var stop_record(default, never) = new Message<Void>("stop_record");

    /**
        Shows/hides the on-screen physics visual debugging.

        This message can only be sent to the designated `@system` socket.
    **/
    static var toggle_physics_debug(default, never) = new Message<Void>("toggle_physics_debug");

    /**
        Shows/hides the on-screen profiler.

        This message can only be sent to the designated `@system` socket.
    **/
    static var toggle_profile(default, never) = new Message<Void>("toggle_profile");
}

/**
    Data for the `SysMessages.exit` message.
**/
typedef SysMessageExit = {
    /**
        exit code to report to the OS, 0 means clean exit
    **/
    var code:Int;
}

/**
    Data for the `SysMessages.reboot` message.
**/
typedef SysMessageReboot = {
    ?arg1:String,
    ?arg2:String,
    ?arg3:String,
    ?arg4:String,
    ?arg5:String,
    ?arg6:String,
}

/**
    Data for the `SysMessages.set_update_frequency` message.
**/
typedef SysMessageSetUpdateFrequency = {
    /**
        target frequency. 60 for 60 fps
    **/
    var frequency:Int;
}

/**
    Data for the `SysMessages.set_vsync` message.
**/
typedef SysMessageSetVsync = {
    /**
        Target swap interval.
    **/
    var swap_interval:Int;
}

/**
    Data for the `SysMessages.start_record` message.
**/
typedef SysMessageStartRecord = {
    /**
        File name to write the video to.
    **/
    var file_name:String;

    /**
        Frame period to record, ie write every nth frame.
        Default value is 2.
    **/
    @:optional var frame_period:Int;

    /**
        Frames per second. Playback speed for the video.
        Default value is 30.

        The fps value doens't affect the recording. It's only meta-data in the written video file.
    **/
    @:optional var fps:Int;
}

/**
    Return value of `Sys.get_application_info`.
**/
typedef SysApplicationInfo = {
    /**
        Is application installed?
    **/
    var installed:Bool;
}

/**
    Return value of `Sys.get_connectivity`.
**/
@:native("_G.sys")
@:enum extern abstract SysConnectivity(Int) {
    /**
        No network connection is found.
    **/
    var NETWORK_DISCONNECTED;

    /**
        Connected through mobile cellular.
    **/
    var NETWORK_CONNECTED_CELLULAR;

    /**
        Connected not through a cellular connection (Wifi).
    **/
    var NETWORK_CONNECTED;
}

/**
    Return value for `Sys.get_engine_info`.
**/
typedef SysEngineInfo = {
    /**
        The current Defold engine version, i.e. "1.2.96"
    **/
    var version:String;

    /**
        The SHA1 for the current engine build, i.e. "0060183cce2e29dbd09c85ece83cbb72068ee050"
    **/
    var version_sha1:String;

    /**
        If the engine is a debug or release version
    **/
    var is_debug:Bool;
}

/**
    Return value for `Sys.get_ifaddrs`.
**/
typedef SysIfaddr = {
    var name:String;

    /**
        IP string (null if not available).
    **/
    var address:Null<String>;

    /**
        Hardware address, colon separated string (null if not available).
    **/
    var mac:String;
    var up:Bool;
    var running:Bool;
}


/**
    Return value for `Sys.get_sys_info`.
**/
typedef SysSysInfo = {
    /**
        Only available on iOS and Android.
    **/
    var device_model:String;

    /**
        Only available on iOS and Android.
    **/
    var manufacturer:String;

    /**
        The system OS name: "Darwin", "Linux", "Windows", "HTML5", "Android" or "iPhone OS"
    **/
    var system_name:String;

    /**
        The system OS version.
    **/
    var system_version:String;

    /**
        The API version on the system.
    **/
    var api_version:String;

    /**
        Two character ISO-639 format, i.e. "en".
    **/
    var language:String;

    /**
        Two character ISO-639 format (i.e. "sr") and, if applicable, followed by a dash (-) and an ISO 15924 script code (i.e. "sr-Cyrl" or "sr-Latn").
        Reflects the device preferred language.
    **/
    var device_language:String;

    /**
        Two character ISO-3166 format, i.e. "US".
    **/
    var territory:String;

    /**
        The current offset from GMT (Greenwich Mean Time), in minutes.
    **/
    var gmt_offset:Int;

    /**
        "identifierForVendor" on iOS, "android_id" on Android.
    **/
    var device_ident:String;

    /**
        The HTTP user agent, i.e. "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/602.4.8 (KHTML, like Gecko) Version/10.0.3 Safari/602.4.8"
    **/
    var user_agent:String;
}

/**
    The returned value of `Sys.load_resource()`.
**/
@:multiReturn extern class SysResource {
    /**
        Loaded data, or `null` if the resource could not be loaded.
    **/
    var data: String;

    /**
        The error message, or `null` if no error occurred.
    **/
    var error: String;
}
