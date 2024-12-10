import QtQuick
import QtQuick.Controls.Basic


TextField {
    id: control

    property int borderWidth: 1
    property string backgroundColor: control.enabled ? PcColors.white : PcColors.grey_3
    implicitHeight: PcStyles.text_field_implicit_height
    font.pointSize: PcStyles.text_field_font_size
    leftPadding: PcStyles.text_field_left_padding
    rightPadding: PcStyles.text_field_right_padding


    background: Rectangle{
        border.width: control.borderWidth
        radius: PcStyles.radius
        color: control.backgroundColor
        border.color: control.enabled ?
                          (control.focus ? PcColors.indigo_5 : PcColors.grey_9) :
                          PcColors.grey_5

    }
}
