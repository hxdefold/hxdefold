package defold;

import defold.types.HashOrString;
import defold.types.UrlOrString;

/**
    Functions to manipulate a label component.
**/
@:native("_G.label")
extern class Label {
    /**
        Set the text for a label.

        @param url the label that should have a constant set
        @param text the text
    **/
    static function set_text(url:UrlOrString, text:HashOrString):Void;
}
