package defold;

@:native("_G.crash")
extern class Crash {
    static function get_backtrace(handle:CrashHandle):lua.Table<Int,String>;
    static function get_extra_data(handle:CrashHandle):String;
    static function get_modules(handle:CrashHandle):lua.Table.AnyTable; // TODO: what's this table?
    static function get_signum(handle:CrashHandle):Int;
    static function get_sys_field(handle:CrashHandle, index:CrashSysField):String;
    static function get_user_field(handle:CrashHandle, index:Int):String;
    static function load_previous():Null<CrashHandle>;
    static function release(handle:CrashHandle):Void;
    static function set_file_path(path:String):Void;
    static function set_user_field(index:Int, value:String):Void;
    static function write_dump():Void;

}

typedef CrashHandle = Int

@:native("_G.crash")
@:enum extern abstract CrashSysField(Int) {
    var SYSFIELD_ANDROID_BUILD_FINGERPRINT;
    var SYSFIELD_DEVICE_LANGUAGE;
    var SYSFIELD_DEVICE_MANUFACTURER;
    var SYSFIELD_DEVICE_MODEL;
    var SYSFIELD_ENGINE_HASH;
    var SYSFIELD_ENGINE_VERSION;
    var SYSFIELD_LANGUAGE;
    var SYSFIELD_SYSTEM_NAME;
    var SYSFIELD_SYSTEM_VERSION;
    var SYSFIELD_TERRITORY;
}
