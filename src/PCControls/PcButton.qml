import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Button {
    id: control
    text: ""
    property string fontIcon: "" //PcFontIcons.md_check

    property string flatColor: PcColors.grey_9
    property string flatBackgroundColor: "transparent"
    property string flatMouseOverBackgroundColor: PcColors.grey_4
    property string color: flat ? flatColor :  PcColors.white
    property string backgroundColor: flat ? flatBackgroundColor : PcColors.indigo_5
    property string mouseoverBackgroundColor: flat ? flatMouseOverBackgroundColor : PcColors.indigo_3
    property int borderWidth: 0

    padding: 0
    leftPadding: PcStyles.padding
    rightPadding: PcStyles.padding

    contentItem: RowLayout{

        PcText{
            id: textIcon
            verticalAlignment: Text.AlignVCenter
            text: {
                control.fontIcon.split('_')[0] === 'md' ? control.fontIcon.split('_')[1] : control.fontIcon
            }
            visible: control.fontIcon.trim() !== ''
            font.pointSize: 14
            font.family: {
                control.fontIcon.split('_')[0] === 'md' ? PcFonts.materialIconFont.name : PcFonts.notoSansSCFont.name
            }
            color: control.color
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
