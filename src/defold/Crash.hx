package defold;

import defold.types.util.LuaArray;

/**
    Native crash logging functions.
**/
@:native("_G.crash")
extern class Crash {
    /**
        The max number of user fields.
    **/
    static var USERFIELD_MAX(default,never):Int;

    /**
        The max size of a single user field.
    **/
    static var USERFIELD_SIZE(default,never):Int;

    /**
        The max number of sysfields.
    **/
    static var SYSFIELD_MAX(default,never):Int;

    /**
        Read backtrace recorded in a loaded crash dump.

        A table is returned containing the addresses of the call stack.

        @param handle crash dump handle
        @return backtrace table containing the backtrace
    **/
    static function get_backtrace(handle:CrashHandle):LuaArray<String>;

    /**
        Read text blob recorded in a crash dump.

        The format of read text blob is platform specific and not guaranteed but can be useful for manual inspection.

        @param handle crash dump handle
        @return blob string with the platform specific data
    **/
    static function get_extra_data(handle:CrashHandle):String;

    /**
        Get all loaded modules from when the crash occured.

        The function returns a table containing entries with sub-tables that
        have fields 'name' and 'address' set for all loaded modules.

        @param handle crash dump handle
        @return modules module table
    **/
    static function get_modules(handle:CrashHandle):LuaArray< {name:String, address:String}>;

    /**
        Read signal number from a crash report.

        @param handle crash dump handle
        @return signal signal number
    **/
    static function get_signum(handle:CrashHandle):Int;

    /**
        Reads a system field from a loaded crash dump.

        @param handle crash dump handle
        @param index system field enum. Must be less than `Crash.SYSFIELD_MAX`
        @return value recorded in the crash dump, or nil if it didn't exist
    **/
    static function get_sys_field(handle:CrashHandle, index:CrashSysField):Null<String>;

    /**
        Reads user field from a loaded crash dump.

        @param handle crash dump handle
        @param index user data slot index
        @return user data value recorded in the crash dump
    **/
    static function get_user_field(handle:CrashHandle, index:Int):String;

    /**
        Loads a previously written crash dump.

        The crash dump will be removed from disk upon a successful load, so loading is one-shot.

        @return handle handle to the loaded dump, or nil if no dump was found.
    **/
    static function load_previous():Null<CrashHandle>;

    /**
        Releases a previously loaded crash dump.

        @param handle handle to loaded crash dump
    **/
    static function release(handle:CrashHandle):Void;

    /**
        Sets the file location for crash dumps.

        Crashes occuring before the path is set will be stored to a default engine location.

        @param path file path to use
    **/
    static function set_file_path(path:String):Void;

    /**
        Stores user-defined string value.

        Store a user value that will get written to a crash dump when a crash occurs.
        This can be user ids, breadcrumb data etc.

        There are 32 slots indexed from 0. Each slot stores at most 255 characters.

        @param index slot index. 0-indexed.
        @param value string value to store
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
    var SYSFIELD_MANUFACTURER;

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
