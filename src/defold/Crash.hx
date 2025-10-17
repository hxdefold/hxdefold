package defold;

import defold.types.util.LuaArray;

/** *
 * Native crash logging functions.
* */
@:native("_G.crash")
extern final class Crash
{
    /**     *
     * The max number of user fields.
    * */
    @:native('USERFIELD_MAX')
    static var UserFieldMax(default,never):Int;

    /**     *
     * The max size of a single user field.
    * */
    @:native('USERFIELD_SIZE')
    static var UserFieldSize(default,never):Int;

    /**     *
     * The max number of sysfields.
    * */
    @:native('SYSFIELD_MAX')
    static var SysFieldMax(default,never):Int;

    /**     *
     * Read backtrace recorded in a loaded crash dump.
     *
     * A table is returned containing the addresses of the call stack.
     *
     * @param handle crash dump handle
     * @return backtrace table containing the backtrace
    * */
    @:pure
    @:native('get_backtrace')
    static function getBacktrace(handle:CrashHandle):LuaArray<String>;

    /**     *
     * Read text blob recorded in a crash dump.
     *
     * The format of read text blob is platform specific and not guaranteed but can be useful for manual inspection.
     *
     * @param handle crash dump handle
     * @return blob string with the platform specific data
    * */
    @:pure
    @:native('get_extra_data')
    static function getExtraData(handle:CrashHandle):String;

    /**     *
     * Get all loaded modules from when the crash occured.
     *
     * The function returns a table containing entries with sub-tables that
     * have fields 'name' and 'address' set for all loaded modules.
     *
     * @param handle crash dump handle
     * @return modules module table
    * */
    @:pure
    @:native('get_modules')
    static function getModules(handle:CrashHandle):LuaArray< {name:String, address:String}>;

    /**     *
     * Read signal number from a crash report.
     *
     * @param handle crash dump handle
     * @return signal signal number
    * */
    @:pure
    @:native('get_signum')
    static function getSignum(handle:CrashHandle):Int;

    /**     *
     * Reads a system field from a loaded crash dump.
     *
     * @param handle crash dump handle
     * @param index system field enum. Must be less than `Crash.SYSFIELD_MAX`
     * @return value recorded in the crash dump, or nil if it didn't exist
    * */
    @:pure
    @:native('get_sys_field')
    static function getSysField(handle:CrashHandle, index:CrashSysField):Null<String>;

    /**     *
     * Reads user field from a loaded crash dump.
     *
     * @param handle crash dump handle
     * @param index user data slot index
     * @return user data value recorded in the crash dump
    * */
    @:pure
    @:native('get_user_field')
    static function getUserField(handle:CrashHandle, index:Int):String;

    /**     *
     * Loads a previously written crash dump.
     *
     * The crash dump will be removed from disk upon a successful load, so loading is one-shot.
     *
     * @return handle handle to the loaded dump, or nil if no dump was found.
    * */
    @:native('load_previous')
    static function loadPrevious():Null<CrashHandle>;

    /**     *
     * Releases a previously loaded crash dump.
     *
     * @param handle handle to loaded crash dump
    * */
    static function release(handle:CrashHandle):Void;

    /**     *
     * Sets the file location for crash dumps.
     *
     * Crashes occuring before the path is set will be stored to a default engine location.
     *
     * @param path file path to use
    * */
    @:native('set_file_path')
    static function setFilePath(path:String):Void;

    /**     *
     * Stores user-defined string value.
     *
     * Store a user value that will get written to a crash dump when a crash occurs.
     * This can be user ids, breadcrumb data etc.
     *
     * There are 32 slots indexed from 0. Each slot stores at most 255 characters.
     *
     * @param index slot index. 0-indexed.
     * @param value string value to store
    * */
    @:native('set_user_field')
    static function setUserField(index:Int, value:String):Void;

    /**     *
     * Writes crash dump.
     *
     * Performs the same steps as if a crash had just occured but allows the program to continue.
     * The generated dump can be read by `Crash.load_previous`.
    * */
    @:native('write_dump')
    static function writeDump():Void;
}

/** *
 * Crash dump handle.
* */
extern abstract CrashHandle(Int) { }

/** *
 * Crash report system fields.
* */
@:native("_G.crash")
extern enum abstract CrashSysField(Int)
{
    /**     *
     * Android build fingerprint.
    * */
    @:native('SYSFIELD_ANDROID_BUILD_FINGERPRINT')
    var AndroidBuildFingerprint;

    /**     *
     * System device language as reported by `Sys.get_sys_info`.
    * */
    @:native('SYSFIELD_DEVICE_LANGUAGE')
    var DeviceLanguage;

    /**     *
     * Device manufacturer as reported by `Sys.get_sys_info`.
    * */
    @:native('SYSFIELD_MANUFACTURER')
    var Manufacturer;

    /**     *
     * Device model as reported by `Sys.get_sys_info`.
    * */
    @:native('SYSFIELD_DEVICE_MODEL')
    var DeviceModel;

    /**     *
     * Engine version as hash.
    * */
    @:native('SYSFIELD_ENGINE_HASH')
    var EngineHash;

    /**     *
     * Engine version as release number.
    * */
    @:native('SYSFIELD_ENGINE_VERSION')
    var EngineVersion;

    /**     *
     * System language as reported by `Sys.get_sys_info`.
    * */
    @:native('SYSFIELD_LANGUAGE')
    var Language;

    /**     *
     * System name as reported by `Sys.get_sys_info`.
    * */
    @:native('SYSFIELD_SYSTEM_NAME')
    var SystemName;

    /**     *
     * System version as reported by `Sys.get_sys_info`.
    * */
    @:native('SYSFIELD_SYSTEM_VERSION')
    var SystemVersion;

    /**     *
     * System territory as reported by `Sys.get_sys_info`.
    * */
    @:native('SYSFIELD_TERRITORY')
    var Territory;
}
