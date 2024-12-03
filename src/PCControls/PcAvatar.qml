import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import cn.pc.controls

Rectangle{
    id: avatar

    signal clicked()

    property string image : ""
    property string fontIcon: ""

    width: PcStyles.avatar_implicit_width
    height: PcStyles.avatar_implicit_height
    border.width: 1
    border.color: PcColors.grey_5
    radius: width*0.5
    color: "transparent"

    PcImage{
        anchors.fill: parent
        anchors.margins: 2
        src:  avatar.image
        radius: width * 0.5
        fillMode: Image.PreserveAspectCrop
        visible: src.trim() !== ""
    }

    Text{
        anchors.centerIn: parent
        text: fontIcon.split('_')[1]
        visible: text.trim() !== ""
        font.pointSize: PcStyles.avatar_font_point_size
        font.family: {
            fontIcon.split('_')[0] === 'md' ? PcFonts.materialIconFont.name : PcFonts.notoSansSCFont.name
        }
        color: PcColors.primary
    }

    Rectangle{
        anchors.fill: parent
        radius: width * 0.5
        color: mousearea.containsMouse ? "#33FFFFFF" : "transparent"

        MouseArea{
            id: mousearea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                avatar.clicked()
            }
        }
    }
}
