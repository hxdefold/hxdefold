package defold;

import defold.types.HashOrString;
import defold.types.HashOrStringOrUrl;
import defold.types.UrlOrString;

/**
    Functions to manipulate a label component.
**/
@:native("_G.label")
extern class Label {
    /**
        Gets the text metrics from a label component

        @param url the label to get the (unscaled) metrics from
    **/
    static function get_text_metrics(url:HashOrStringOrUrl):LabelTextMetrics;

    /**
        Set the text for a label.

        @param url the label that should have a constant set
        @param text the text
    **/
    static function set_text(url:UrlOrString, text:HashOrString):Void;
}

/**
    Return structure for `Label.get_text_metrics`.
**/
typedef LabelTextMetrics = {
    var width:Float;
    var height:Float;
    var max_ascent:Float;
    var max_descent:Float;
}
