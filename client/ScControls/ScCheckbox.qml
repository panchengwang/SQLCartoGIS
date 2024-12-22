import QtQuick
import QtQuick.Controls.Basic

CheckBox {
    id: control
    text: qsTr("CheckBox")
    checked: false

    indicator: Rectangle {
        implicitWidth: ScStyles.checkbox_indicator_size
        implicitHeight: ScStyles.checkbox_indicator_size
        anchors.centerIn: parent
        radius: 3
        border.color: ScColors.grey_9

        ScText{
            anchors.centerIn: parent
            text: ScFontIcons.md_check.split('_')[1]
            font.family: ScFonts.materialIconFont.name
            font.pixelSize: parent.height - 4
            visible: control.checked
        }
    }

    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: ScColors.grey_9
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
    }
}
