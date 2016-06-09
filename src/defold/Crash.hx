package defold;

/**
    Native crash logging functions.
**/
@:native("_G.crash")
extern class Crash {
    /**
        Read backtrace recorded in a loaded crash dump.

        A table is returned containing the addresses of the call stack.
    **/
    static function get_backtrace(handle:CrashHandle):lua.Table<Int,String>;

    /**
        Read text blob recorded in a crash dump.

        The format of read text blob is platform specific and not guaranteed but can be useful for manual inspection.
    **/
    static function get_extra_data(handle:CrashHandle):String;

    /**
        Get all loaded modules from when the crash occured.
    **/
    static function get_modules(handle:CrashHandle):lua.Table<Int, {name:String, address:String}>;

    /**
        Read signal number from a crash report.
    **/
    static function get_signum(handle:CrashHandle):Int;

    /**
        Reads a system field from a loaded crash dump.
    **/
    static function get_sys_field(handle:CrashHandle, index:CrashSysField):String;

    /**
        Reads user field from a loaded crash dump.
    **/
    static function get_user_field(handle:CrashHandle, index:Int):String;

    /**
        Loads a previously written crash dump.

        The crash dump will be removed from disk upon a successful load, so loading is one-shot.
    **/
    static function load_previous():Null<CrashHandle>;

    /**
        Releases a previously loaded crash dump.
    **/
    static function release(handle:CrashHandle):Void;

    /**
        Sets the file location for crash dumps.

        Crashes occuring before the path is set will be stored to a default engine location.
    **/
    static function set_file_path(path:String):Void;

    /**
        Stores user-defined string value.

        Store a user value that will get written to a crash dump when a crash occurs.
        This can be user ids, breadcrumb data etc.

        There are 32 slots indexed from 0. Each slot stores at most 255 characters.
    **/
    static function set_user_field(index:Int, value:String):Void;

    /**
        Writes crash dump.

        Performs the same steps as if a crash had just occured but allows the program to continue.
        The generated dump can be read by `Crash.load_previous`.
    **/
    static function write_dump():Void;

}

/**
    Crash dump handle (integer).
**/
typedef CrashHandle = Int;

/**
    Crash report system fields.
**/
@:native("_G.crash")
@:enum extern abstract CrashSysField(Int) {
    /**
        Android build fingerprint.
    **/
    var SYSFIELD_ANDROID_BUILD_FINGERPRINT;

    /**
        System device language as reported by `Sys.get_sys_info`.
    **/
    var SYSFIELD_DEVICE_LANGUAGE;

    /**
        Device manufacturer as reported by `Sys.get_sys_info`.
    **/
    var SYSFIELD_DEVICE_MANUFACTURER;

    /**
        Device model as reported by `Sys.get_sys_info`.
    **/
    var SYSFIELD_DEVICE_MODEL;

    /**
        Engine version as hash.
    **/
    var SYSFIELD_ENGINE_HASH;

    /**
        Engine version as release number.
    **/
    var SYSFIELD_ENGINE_VERSION;

    /**
        System language as reported by `Sys.get_sys_info`.
    **/
    var SYSFIELD_LANGUAGE;

    /**
        System name as reported by `Sys.get_sys_info`.
    **/
    var SYSFIELD_SYSTEM_NAME;

    /**
        System version as reported by `Sys.get_sys_info`.
    **/
    var SYSFIELD_SYSTEM_VERSION;

    /**
        System territory as reported by `Sys.get_sys_info`.
    **/
    var SYSFIELD_TERRITORY;
}
