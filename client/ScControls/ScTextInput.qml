import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
    id: control

    property alias text: txtField.text
    property string placeholderText: ''

    implicitHeight: ScStyles.text_field_implicit_height + ScStyles.margin
    implicitWidth: 180
    radius: ScStyles.radius
    border.width: 1
    border.color: ScColors.grey_8
    clip: true

    RowLayout{
        anchors.fill: parent
        spacing: 0
        ScAvatar{
            fontIcon: ScFontIcons.md_search
            iconColor: ScColors.grey_8
            Layout.leftMargin: 3
            Layout.preferredWidth: Layout.preferredHeight
            Layout.preferredHeight: control.height - 10
            border.width: 0
        }

        ScTextField{
            id: txtField
            placeholderText:"Search"
            borderWidth: 0
            backgroundColor: "transparent"
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        ScAvatar{
            fontIcon: ScFontIcons.md_close
            iconColor: ScColors.grey_8
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
