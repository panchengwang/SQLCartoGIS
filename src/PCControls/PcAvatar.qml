import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import cn.pc.controls

Rectangle{
    id: avatar

    signal clicked()

    property string image : ""
    property string fontIcon: ""
    property string iconColor: PcColors.primary

    width: PcStyles.avatar_implicit_width
    height: PcStyles.avatar_implicit_height
    border.width: 1
    border.color: PcColors.grey_7
    radius: width*0.5
    color: "transparent"

    PcImage{
        id: pcImage
        anchors.fill: parent
        anchors.margins: 2
        src:  avatar.image
        radius: avatar.radius -1
        fillMode: Image.PreserveAspectCrop
        visible: src.trim() !== ""
    }

    Text{
        anchors.centerIn: parent
        horizontalAlignment:Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: {
            avatar.fontIcon.split('_')[0] === 'md' ? avatar.fontIcon.split('_')[1] : avatar.fontIcon
        }
        visible: !pcImage.visible
        font.pixelSize: avatar.width-5
        font.family: {
            avatar.fontIcon.split('_')[0] === 'md' ? PcFonts.materialIconFont.name : PcFonts.notoSansSCFont.name
        }
        color: avatar.iconColor // mousearea.containsMouse ? PcColors.primary : PcColors.grey_8
    }

    Rectangle{
        anchors.fill: parent
        radius: avatar.radius
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
