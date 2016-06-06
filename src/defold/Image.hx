package defold;

@:native("_G.image")
extern class Image {
    static function load(buffer:String, ?premult:Bool):Null<ImageLoadResult>;
}

typedef ImageLoadResult = {
    var width:Int;
    var height:Int;
    var type:ImageType;
    var buffer:String;
}

@:native("_G.image")
@:enum extern abstract ImageType({}) {
    var TYPE_LUMINANCE;
    var TYPE_RGB;
    var TYPE_RGBA;
}
