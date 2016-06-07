package defold;

import defold.support.UrlOrString;
import defold.support.HashOrString;

@:native("_G.sprite")
extern class Sprite {
    static function reset_constant(url:UrlOrString, name:HashOrString):Void;
    static function set_constant(url:UrlOrString, name:HashOrString, value:Vector4):Void;
    static function set_hflip(url:UrlOrString, flip:Bool):Void;
    static function set_vflip(url:UrlOrString, flip:Bool):Void;
}

@:publicFields
class SpriteMessages {
    static var AnimationDone(default,never) = new Message<{current_tile:Int, id:Hash}>("animation_done");
    static var PlayAnimation(default,never) = new Message<{id:Hash}>("play_animation");
}
