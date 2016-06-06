package defold;

@:native("_G.http")
extern class Http {
    static function request<T>(url:String, method:String, callback:T->Hash->HttpResponse->Void, ?headers:lua.Table<String,String>, ?post_data:String, ?options:HttpOptions):Void;
}

typedef HttpResponse = {
    var status:Int;
    var response:String;
    var headers:haxe.DynamicAccess<String>;
}

typedef HttpOptions = {
    @:optional var timeout:Int;
}
