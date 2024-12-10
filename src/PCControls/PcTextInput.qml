import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
    id: control

    property alias text: txtField.text
    property string placeholderText: ''

    implicitHeight: PcStyles.text_field_implicit_height + PcStyles.margin
    implicitWidth: 180
    radius: PcStyles.radius
    border.width: 1
    border.color: PcColors.grey_8
    clip: true

    RowLayout{
        anchors.fill: parent
        spacing: 0
        PcAvatar{
            fontIcon: PcFontIcons.md_search
            iconColor: PcColors.grey_8
            Layout.leftMargin: 3
            Layout.preferredWidth: Layout.preferredHeight
            Layout.preferredHeight: control.height - 10
            border.width: 0
        }

        PcTextField{
            id: txtField
            placeholderText:"Search"
            borderWidth: 0
            backgroundColor: "transparent"
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        PcAvatar{
            fontIcon: PcFontIcons.md_close
            iconColor: PcColors.grey_8
            Layout.leftMargin: 3
            Layout.preferredWidth: Layout.preferredHeight
            Layout.preferredHeight: control.height - 10
            border.width: 0
            Layout.rightMargin: 3
            visible: txtField.text !== ''
            onClicked:{
                txtField.text = ''
            }
        }
    }
}
