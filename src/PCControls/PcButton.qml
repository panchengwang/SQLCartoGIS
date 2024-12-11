import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Button {
    id: control
    text: ""
    property string leftIcon: "" //PcFontIcons.md_check
    property string rightIcon: ""
    property string iconColor: PcColors.primary
    property string flatColor: PcColors.grey_9
    property string flatBackgroundColor: "transparent"
    property string flatMouseOverBackgroundColor: PcColors.grey_4
    property string color: isActivate ? focusColor : ( flat ? flatColor :  PcColors.grey_9)
    property string backgroundColor:isActivate ? focusBackgroundColor : ( flat ? flatBackgroundColor : PcColors.grey_4)
    property string mouseoverBackgroundColor: flat ? flatMouseOverBackgroundColor : PcColors.grey_5
    property int borderWidth: 0
    property string borderColor: control.color
    property int radius: 2
    property bool rightIconClickStandalone: false
    property bool leftIconClickStandalone: false
    property bool isActivate: false
    property string focusBackgroundColor: PcColors.primary
    property string focusColor: PcColors.white
    property int textAlignment: Text.AlignHCenter

    signal rightIconClicked()
    signal leftIconClicked()

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
            clickable: control.leftIconClickStandalone
            onClicked: control.leftIconClicked()
            iconColor: control.isActivate ? control.focusColor : control.iconColor
        }

        PcText {
            id: label
            Layout.fillWidth: true
            text: control.text
            font: control.font
            visible: label.text.trim() !== ''
            color: control.color
            horizontalAlignment: control.textAlignment
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
            clickable: control.rightIconClickStandalone
            onClicked: control.rightIconClicked()
            iconColor: control.isActivate ? control.focusColor : control.iconColor
        }
    }

    background: Rectangle {
        implicitWidth: PcStyles.button_implicit_width
        implicitHeight: PcStyles.button_implicit_height
        color: mouseArea.containsMouse ? control.mouseoverBackgroundColor: control.backgroundColor
        border.color: control.borderColor
        border.width: control.borderWidth
        radius: control.radius

        MouseArea{
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: flat ? Qt.PointingHandCursor : Qt.ArrowCursor
        }
    }
}
