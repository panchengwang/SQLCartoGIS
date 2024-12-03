import QtQuick
import QtQuick.Layouts
import cn.pc.controls

Rectangle {
    id: button

    property bool round: true;
    property bool outlined: false;
    signal clicked();

    implicitHeight: PcStyles.button_implicit_height
    implicitWidth: PcStyles.button_implicit_width

    color: outlined ?
        ( mouse.containsMouse ? PcColors.grey_3 : PcColors.grey_1) :
        ( mouse.containsMouse ? PcColors.primary_light : PcColors.primary)

    radius: round ? height * 0.5 : 0
    border.width: outlined ? 1 : 0
    border.color: PcColors.grey_5
    width: row.width < PcStyles.button_implicit_width ? PcStyles.button_implicit_width : row.width
    RowLayout{
        id: row
        anchors.centerIn: parent

        Text{
            id: leftText
        }

        Text{
            id: label
            Layout.fillWidth: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: "B"
            color: outlined ?
                ( mouse.containsMouse ? PcColors.grey_10 : PcColors.grey_7) :
                PcColors.white
            font.pointSize: PcStyles.button_font_size
        }

        Text{
            id: rightText
        }
    }

    MouseArea{
        id: mouse
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            button.clicked();
        }
    }


}
