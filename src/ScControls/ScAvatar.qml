import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Rectangle{
    id: avatar

    signal clicked()

    property string image : ""
    property string fontIcon: ""
    property string iconColor: ScColors.primary
    property bool clickable: true
    property string mouseOverBackgroundColor: ScColors.grey_5
    width: ScStyles.avatar_implicit_width
    height: ScStyles.avatar_implicit_height
    border.width: 1
    border.color: ScColors.grey_7
    radius: width*0.5
    opacity: mousearea.containsMouse ? 0.8 : 1
    color: mousearea.containsMouse ? avatar.mouseOverBackgroundColor : "transparent"

    MouseArea{
        id: mousearea
        anchors.fill: parent
        hoverEnabled: true
        visible: avatar.clickable
        onClicked: {
            avatar.clicked()
        }
    }
    // Rectangle{
    //     anchors.fill: parent
    //     radius: avatar.radius
    //     color: mousearea.containsMouse ? avatar.mouseOverBackgroundColor : "transparent"

    //     MouseArea{
    //         id: mousearea
    //         anchors.fill: parent
    //         hoverEnabled: true
    //         visible: avatar.clickable
    //         onClicked: {
    //             avatar.clicked()
    //         }
    //     }
    // }


    ScImage{
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
            avatar.fontIcon.split('_')[0] === 'md' ? ScFonts.materialIconFont.name : ScFonts.notoSansSCFont.name
        }
        color: avatar.iconColor // mousearea.containsMouse ? ScColors.primary : ScColors.grey_8
    }


}
