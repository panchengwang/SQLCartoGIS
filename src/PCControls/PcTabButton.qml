import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
    id: button

    signal clicked()
    signal closed()

    property string text: "button"
    property string leftIcon: ''
    property string rightIcon: PcFontIcons.md_close
    property bool closeable: true
    property int index: -1
    property bool isActivate: false

    implicitHeight: PcStyles.button_implicit_height
    implicitWidth: 80

    topLeftRadius: 5
    topRightRadius: 5
    border.width: 1
    border.color: PcColors.grey_4
    color: button.isActivate ?  PcColors.primary : (mouseArea.containsMouse ? PcColors.grey_1 : PcColors.grey_3)

    clip: true

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked:{
            button.clicked()
        }
    }

    RowLayout{
        anchors.fill: parent
        anchors.leftMargin: PcStyles.margin
        anchors.rightMargin: PcStyles.margin

        PcAvatar{
            id: leftAvatar
            Layout.preferredHeight: PcStyles.button_implicit_height - 8
            Layout.preferredWidth: Layout.preferredHeight
            visible: button.leftIcon.trim() !== ''
            fontIcon: button.leftIcon
            onClicked: button.closed()
            border.width: 0
            iconColor: button.isActivate ? PcColors.white : PcColors.primary
            // radius: 2
        }

        PcText{
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            text: button.text
            elide: Text.ElideRight
            color: button.isActivate ? PcColors.white : PcColors.grey_8
        }
        PcAvatar{
            id: rightAvatar
            Layout.preferredHeight: PcStyles.button_implicit_height - 8
            Layout.preferredWidth: Layout.preferredHeight
            visible: button.closeable
            fontIcon: button.rightIcon
            onClicked: button.closed()
            border.width: 0
            iconColor: button.isActivate ? PcColors.white : PcColors.primary
            // radius: 2
        }
    }


}

// PcButton {
//     id: button

//     signal closed();

//     property bool closeable: true
//     property int index: 0

//     implicitWidth: 100

//     rightIcon: button.closeable ? PcFontIcons.md_close : ''
//     rightIconClickStandalone: true

//     borderWidth: 1
//     borderColor: PcColors.grey_5


//     onRightIconClicked:{
//         button.closed();
//     }

// }
