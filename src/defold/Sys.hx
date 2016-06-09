package defold;

/**
    System functions.
**/
@:native("_G.sys")
extern class Sys {
    /**
        Get application information.
    **/
    static function get_application_info(_:String):SysApplicationInfo; // TODO: wtf is this string arg?

    /**
        Get config value from the game.project configuration file.
    **/
    @:overload(function(key:String, default_value:String):String {})
    static function get_config(key:String):Null<String>;

    /**
        Get current network connectivity status.
    **/
    static function get_connectivity():SysConnectivity;

    /**
        Get engine information.
    **/
    static function get_engine_info():SysEngineInfo;

    /**
        Enumerate network cards.
    **/
    static function get_ifaddrs():lua.Table<Int,SysIfaddr>;

    /**
        Get the save-file path.

        The save-file path is operating system specific and
        is typically located under the users home directory.
    **/
    static function get_save_file(application_id:String, file_name:String):String;

    /**
        Get system information.
    **/
    static function get_sys_info():SysSysInfo;

    /**
        Load a lua table from a file on disk.

        If the file exists, it must have been created by `Sys.save` to be loaded.
    **/
    static function load(filename:String):lua.Table.AnyTable;

    /**
        Loads a custom resource from game data.

        Specify the full filename of the resource that you want to load.
        In order for the engine to include custom resources in the build process,
        you need to specify them in the "game.project" settings file.
    **/
    static function load_resource(filename:String):String;

    /**
        Open url in default application (typically a browser).

        Returns a boolean indicating if the url could be opened or not.
    **/
    static function open_url(url:String):Bool;

    /**
        Saves a lua table to a file stored on disk.

        The table can later be loaded by `Sys.load`.
        Use `Sys.get_save_file` to obtain a valid location for the file.

        Returns a boolean indicating if the table could be saved or not.
    **/
    static function save(filename:String, table:lua.Table.AnyTable):Bool;

    /**
        Set host to check for network connectivity against.
    **/
    static function set_connectivity_host(host:String):Void;

    /**
        Set the error handler (a function which is called whenever a lua runtime error occurs).
        Handler arguments: source, message, traceback.
    **/
    static function set_error_handler(error_handler:String->String->String->Void):Void;
}

/**
    Messages handled by the system (send to the `@system:` socket).
**/
@:publicFields
class SysMessages {
    /**
        Exits application.

        Terminates the game application and reports the specified code to the OS.
    **/
    static var Exit(default,never) = new Message<{code:Int}>("exit");

    /**
        Reboots engine with arguments.

        Arguments will be translated into command line arguments.
        Sending the reboot command is equivalent to starting the engine with the same arguments.
    **/
    static var Reboot(default,never) = new Message<SysMessageReboot>("reboot");

    /**
        Sets update frequency.

        This option is equivalent to display.update_frequency but set in run-time.
    **/
    static var SetUpdateFrequency(default,never) = new Message<{frequency:Int}>("set_update_frequency");

    /**
        Starts video recording of the game frame-buffer to file.
    **/
    static var StartRecord(default,never) = new Message<SysMessageStartRecord>("start_record");

    /**
        Stop current video recording.
    **/
    static var StopRecord(default,never) = new Message<Void>("stop_record");

    /**
        Shows/hides the on-screen profiler.
    **/
    static var ToggleProfile(default,never) = new Message<Void>("toggle_profile");
}

/**
    Data for the `SysMessages.Reboot` message.
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
    Data for the `SysMessages.StartRecord` message.
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

        The fps value doens't affect the recording.
        It's only meta-data in the written video file.
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
@:enum extern abstract SysConnectivity({}) {
    /**
        No network connection is found.
    **/
    var NETWORK_DISCONNECTED;

    /**
        Connected through mobile cellular.
    **/
    var NETWORK_CONNECTED_CELLULAR;

    /**
        Connected not through a cellular connection.
    **/
    var NETWORK_CONNECTED;
}

/**
    Return value for `Sys.get_engine_info`.
**/
typedef SysEngineInfo = {
    var version:String;
    var version_sha1:String; // docs say "engine_sha1", but in fact it's "version_sha1"
}

/**
    Return value for `Sys.get_ifaddrs`.
**/
typedef SysIfaddr = {
    var name:String;
    var address:Null<String>;
    var mac:Null<String>;
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

    var system_name:String;
    var system_version:String;
    var api_version:String;

    /**
        ISO-639 format (two characters).
    **/
    var language:String;

    /**
        Reflects device preferred language.
        ISO-639 format (two characters) and if applicable by a dash (-) and an ISO 15924 script code.
    **/
    var device_language:String;

    /**
        ISO-3166 format (two characters).
    **/
    var territory:String;

    /**
        GMT offset in minutes.
    **/
    var gmt_offset:Int;

    /**
        "identifierForVendor" on iOS, "android_id" on Android.
    **/
    var device_ident:String;

    /**
        "advertisingIdentifier" on iOS, advertising ID provided by Google Play on Android.
    **/
    var ad_ident:String;

    var ad_tracking_enabled:Bool;
    var user_agent:String;
}
