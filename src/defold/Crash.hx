package defold;

@:native("_G.crash")
extern class Crash {
    static function get_backtrace(handle:CrashHandle):lua.Table.AnyTable; // TODO: figure out what is it
    static function get_extra_data(handle:CrashHandle):String;
    static function get_modules(handle:CrashHandle):lua.Table.AnyTable;
    static function get_signum(handle:CrashHandle):Int;
    static function get_sys_field(handle:CrashHandle, index:Int):String;
    static function get_user_field(handle:CrashHandle, index:Int):String;
    static function load_previous():Null<CrashHandle>;
    static function release(handle:CrashHandle):Void;
    static function set_file_path(path:String):Void;
    static function set_user_field(index:Int, value:String):Void;
    static function write_dump():Void;

    static var SYSFIELD_ANDROID_BUILD_FINGERPRINT(default,null):Int;
    static var SYSFIELD_DEVICE_LANGUAGE(default,null):Int;
    static var SYSFIELD_DEVICE_MANUFACTURER(default,null):Int;
    static var SYSFIELD_DEVICE_MODEL(default,null):Int;
    static var SYSFIELD_ENGINE_HASH(default,null):Int;
    static var SYSFIELD_ENGINE_VERSION(default,null):Int;
    static var SYSFIELD_LANGUAGE(default,null):Int;
    static var SYSFIELD_SYSTEM_NAME(default,null):Int;
    static var SYSFIELD_SYSTEM_VERSION(default,null):Int;
    static var SYSFIELD_TERRITORY(default,null):Int;
}

typedef CrashHandle = Int
