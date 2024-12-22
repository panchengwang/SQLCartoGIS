import QtQuick
import QtQuick.Controls.Basic


TextField {
    id: control

    property int borderWidth: 1
    property string backgroundColor: control.enabled ? ScColors.white : ScColors.grey_3
    implicitHeight: ScStyles.text_field_implicit_height
    font.pointSize: ScStyles.text_field_font_size
    leftPadding: ScStyles.text_field_left_padding
    rightPadding: ScStyles.text_field_right_padding


    background: Rectangle{
        border.width: control.borderWidth
        radius: ScStyles.radius
        color: control.backgroundColor
        border.color: control.enabled ?
                          (control.focus ? ScColors.indigo_5 : ScColors.grey_9) :
                          ScColors.grey_5

    }
}
