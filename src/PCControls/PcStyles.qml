pragma Singleton

import QtQuick

QtObject {

    // property string color_primary   : "#1976d2";
    // property string color_primary_light   : "#881976d2";
    // property string color_secondary : "#26A69A";
    // property string color_accent    : "#9C27B0";
    // property string color_dark      : "#1d1d1d";
    // property string color_dark_page : "#121212";
    // property string color_positive  : "#21BA45";
    // property string color_negative  : "#C10015";
    // property string color_info      : "#31CCEC";
    // property string color_warning   : "#F2C037";
    // property string color_white     : "#FFFFFF";
    // property string color_grey      : "#AAAAAA";

    property int button_implicit_height: 28;
    property int button_implicit_width: button_implicit_height;
    property int button_border_width: 0;
    property int button_border_width_outlined: 1;
    property int button_font_size: 10;


    property int avatar_implicit_width: 32
    property int avatar_implicit_height: 32
    property int avatar_font_point_size: 22


    property int spacing: 10
    property int margin: 5
    property int padding: 5
    property int radius: 3

    property int text_font_size: 10

    property int text_field_implicit_height: 28
    property int text_field_implicit_width: 56
    property int text_field_font_size: 10
    property int text_field_padding: 3



    property int panel_radius: 5



    property int header_implicit_height: 40

    property int panel_header_implicit_height: 32

}
