package defold;

import defold.types.*;

/**
    Functions to manipulate a label component.

    See `LabelProperties` for related properties.
**/
@:native("_G.label")
extern class Label {

    /**
        Gets the text from a label component

        @return the label text
    **/
    static function get_text(url:HashOrStringOrUrl): String;

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

/**
    Properties related to the `Label` module.
**/
@:publicFields
class LabelProperties {
    /**
        The color of the label.
    **/
    static var color(default, never) = new Property<Vector4>("color");

    /**
        The outline color of the label.
    **/
    static var outline(default, never) = new Property<Vector4>("outline");

    /**
        The vector scale of the label.
    **/
    static var scale(default, never) = new Property<Vector3>("scale");

    /**
        The uniform scale of the label.
    **/
    static var scale_uniform(default, never) = new Property<Float>("scale"); // added by hand for clarity

    /**
        The shadow color of the label.
    **/
    static var shadow(default, never) = new Property<Vector4>("shadow");

    /**
        Returns the size of the label. The size will constrain the text if line break is enabled
    **/
    static var size(default, never) = new Property<Vector3>("size");

    /**
        The leading of the label. This value is used to scale the line spacing of text.
    **/
    static var leading(default, never) = new Property<Float>("leading");

    /**
        The tracking of the label. This value is used to adjust the vertical spacing of characters in the text.
    **/
    static var tracking(default, never) = new Property<Float>("tracking");

    /**
        The line break of the label. This value is used to adjust the vertical spacing of characters in the text.
    **/
    static var line_break(default, never) = new Property<Bool>("line_break");
}
