import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Button {
    id: control
    text: ""
    property string leftIcon: "" //ScFontIcons.md_check
    property string rightIcon: ""
    property string iconColor: ScColors.primary
    property string flatColor: ScColors.grey_9
    property string flatBackgroundColor: "transparent"
    property string flatMouseOverBackgroundColor: ScColors.grey_4
    property string color: isActivate ? focusColor : ( flat ? flatColor :  ScColors.grey_9)
    property string backgroundColor:isActivate ? focusBackgroundColor : ( flat ? flatBackgroundColor : ScColors.grey_4)
    property string mouseoverBackgroundColor: isActivate ? focusBackgroundColor : (flat ? flatMouseOverBackgroundColor : ScColors.grey_5)
    property int borderWidth: 0
    property string borderColor: control.color
    property int radius: 2
    property bool rightIconClickStandalone: false
    property bool leftIconClickStandalone: false
    property bool isActivate: false
    property string focusBackgroundColor: ScColors.primary
    property string focusColor: ScColors.white
    property int textAlignment: Text.AlignHCenter

    property bool mouseOvered: mouseArea.containsMouse

    signal rightIconClicked()
    signal leftIconClicked()

    padding: 0
    leftPadding: ScStyles.padding
    rightPadding: ScStyles.padding

    contentItem: RowLayout{

        ScAvatar{
            visible: leftIcon.trim() != ''
            border.width: 0
            Layout.preferredHeight: control.height -  ScStyles.margin
            Layout.preferredWidth: Layout.preferredHeight
            fontIcon: control.leftIcon
            radius: 0.5 * height
            clickable: control.leftIconClickStandalone
            onClicked: control.leftIconClicked()
            iconColor: control.isActivate ? control.focusColor : control.iconColor
        }

        ScText {
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

        ScAvatar{
            visible: rightIcon.trim() != ''
            border.width: 0
            Layout.preferredHeight: control.height - ScStyles.margin
            Layout.preferredWidth: Layout.preferredHeight
            fontIcon: control.rightIcon
            radius: 0.5 * height
            clickable: control.rightIconClickStandalone
            onClicked: control.rightIconClicked()
            iconColor: control.isActivate ? control.focusColor : control.iconColor
        }
    }

    background: Rectangle {
        implicitWidth: ScStyles.button_implicit_width
        implicitHeight: ScStyles.button_implicit_height
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
