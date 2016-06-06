package defold;

@:native("_G.sys")
extern class Sys {
    static function get_application_info(_:String):SysApplicationInfo; // TODO: wtf is this string arg?
    static function get_config(key:String, ?default_value:String):Null<String>;
    static function get_connectivity():SysConnectivity;
    static function get_engine_info():SysEngineInfo;
    static function get_ifaddrs():lua.Table<Int,SysIfaddr>;
    static function get_save_file(application_id:String, file_name:String):String;
    static function get_sys_info():SysSysInfo;
    static function load(filename:String):Null<lua.Table.AnyTable>;
    static function load_resource(filename:String):Null<String>;
    static function open_url(url:String):Bool;
    static function save(filename:String, table:lua.Table.AnyTable):Bool;
    static function set_connectivity_host(host:String):Void;
    static function set_error_handler(error_handler:String->String->String->Void):Void;
}

typedef SysApplicationInfo = {
    var installed:Bool;
}

@:native("_G.sys")
@:enum extern abstract SysConnectivity({}) {
    var NETWORK_DISCONNECTED;
    var NETWORK_CONNECTED_CELLULAR;
    var NETWORK_CONNECTED;
}

typedef SysEngineInfo = {
    var version:String;
    var version_sha1:String; // docs say "engine_sha1", but in fact it's "version_sha1"
}

typedef SysIfaddr = {
    var name:String;
    var address:Null<String>;
    var mac:Null<String>;
    var up:Bool;
    var running:Bool;
}

typedef SysSysInfo = {
    var device_model:String;
    var manufacturer:String;
    var system_name:String;
    var system_version:String;
    var api_version:String;
    var language:String;
    var device_language:String;
    var territory:String;
    var gmt_offset:Int;
    var device_ident:String;
    var ad_ident:String;
    var ad_tracking_enabled:Bool;
    var user_agent:String;
}
