import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
    id: button

    signal clicked()
    signal closed()

    property string text: "button"
    property string leftIcon: ''
    property string rightIcon: ScFontIcons.md_close
    property bool closeable: true
    property int index: -1
    property bool isActivate: false

    implicitHeight: ScStyles.button_implicit_height
    implicitWidth: 60
                   + (rightAvatar.visible ? rightAvatar.width + row.spacing : 0)
                   + (leftAvatar.visible ? leftAvatar.width + row.spacing : 0)
                   + row.anchors.leftMargin + row.anchors.rightMargin

    topLeftRadius: 5
    topRightRadius: 5
    border.width: 1
    border.color: ScColors.grey_4
    color: button.isActivate ?  ScColors.blue_5 : (mouseArea.containsMouse ? ScColors.grey_1 : ScColors.grey_3)
    clip: true

    ToolTip {
        parent: button
        visible: mouseArea.containsMouse
        text: button.text
    }


    MouseArea{
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked:{
            button.clicked()
        }
    }

    RowLayout{
        id: row
        anchors.fill: parent
        // anchors.top: parent.top
        // anchors.bottom: parent.bottom
        anchors.leftMargin: ScStyles.margin
        anchors.rightMargin: ScStyles.margin

        ScAvatar{
            id: leftAvatar
            Layout.preferredHeight: ScStyles.button_implicit_height - 8
            Layout.preferredWidth: Layout.preferredHeight
            visible: button.leftIcon.trim() !== ''
            fontIcon: button.leftIcon
            clickable: false
            border.width: 0
            iconColor: button.isActivate ? ScColors.white : ScColors.primary
            // radius: 2
        }

        ScText{
            id: txtTitle
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth:100
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: button.text
            elide: Text.ElideRight
            color: button.isActivate ? ScColors.white : ScColors.grey_8
        }
        ScAvatar{
            id: rightAvatar
            Layout.preferredHeight: ScStyles.button_implicit_height - 8
            Layout.preferredWidth: Layout.preferredHeight
            visible: button.closeable
            fontIcon: button.rightIcon
            onClicked: button.closed()
            border.width: 0
            iconColor: button.isActivate ? ScColors.white : ScColors.primary
            // radius: 2
        }
    }


}

// ScButton {
//     id: button

//     signal closed();

//     property bool closeable: true
//     property int index: 0

//     implicitWidth: 100

//     rightIcon: button.closeable ? ScFontIcons.md_close : ''
//     rightIconClickStandalone: true

//     borderWidth: 1
//     borderColor: ScColors.grey_5


//     onRightIconClicked:{
//         button.closed();
//     }

// }
