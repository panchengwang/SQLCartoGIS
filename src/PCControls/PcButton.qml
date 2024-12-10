import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Button {
    id: control
    text: ""
    property string leftIcon: "" //PcFontIcons.md_check
    property string rightIcon: ""
    property string flatColor: PcColors.grey_9
    property string flatBackgroundColor: "transparent"
    property string flatMouseOverBackgroundColor: PcColors.grey_4
    property string color: flat ? flatColor :  PcColors.grey_9
    property string backgroundColor: flat ? flatBackgroundColor : PcColors.grey_4
    property string mouseoverBackgroundColor: flat ? flatMouseOverBackgroundColor : PcColors.grey_5
    property int borderWidth: 0

    padding: 0
    leftPadding: PcStyles.padding
    rightPadding: PcStyles.padding

    contentItem: RowLayout{

        PcAvatar{
            visible: leftIcon.trim() != ''
            border.width: 0
            Layout.preferredHeight: control.height -  PcStyles.margin
            Layout.preferredWidth: Layout.preferredHeight
            fontIcon: control.leftIcon
            radius: 3
        }

        PcText {
            id: label
            Layout.fillWidth: true
            text: control.text
            font: control.font
            visible: label.text.trim() !== ''
            color: control.color
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        PcAvatar{
            visible: rightIcon.trim() != ''
            border.width: 0
            Layout.preferredHeight: control.height - PcStyles.margin
            Layout.preferredWidth: Layout.preferredHeight
            fontIcon: control.rightIcon
            radius: 3
        }
    }

    background: Rectangle {
        implicitWidth: PcStyles.button_implicit_width
        implicitHeight: PcStyles.button_implicit_height
        color: mouseArea.containsMouse ? control.mouseoverBackgroundColor: control.backgroundColor
        border.color: control.color
        border.width: control.borderWidth
        radius: 2

        MouseArea{
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: flat ? Qt.PointingHandCursor : Qt.ArrowCursor
        }
    }
}
