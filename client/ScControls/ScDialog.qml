import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Popup {
    id: dialog
    parent: Overlay.overlay

    implicitHeight: 200

    property string title: "Dialog"
    property int minWidth: 300
    property int maxWidth: 600
    property Item content: Rectangle{
        anchors.fill: parent
        color: ScColors.grey_1
    }

    clip: true

    width: parent.width * 0.5 < minWidth ? minWidth: parent.width * 0.5 > maxWidth ? maxWidth : parent.width * 0.5
    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)

    margins: 0

    contentItem: ColumnLayout{
        anchors.fill: parent
        Rectangle{
            Layout.fillWidth: true
            implicitHeight: ScStyles.panel_header_implicit_height
            color: ScColors.grey_4
            topRightRadius: background.radius
            topLeftRadius: background.radius

            RowLayout{
                anchors.fill: parent
                anchors.rightMargin: ScStyles.margin
                anchors.leftMargin: ScStyles.margin
                ScText{
                    Layout.fillWidth: true
                    text: dialog.title
                    color:  ScColors.grey_9
                    font.pointSize: 12
                }
                ScAvatar{
                    fontIcon: ScFontIcons.md_minimize
                    iconColor: ScColors.grey_9
                    Layout.preferredWidth: 22
                    Layout.preferredHeight: 22
                    radius: 2
                    border.width: 0
                }

                ScAvatar{
                    fontIcon: ScFontIcons.md_crop_square
                    iconColor:  ScColors.grey_9
                    Layout.preferredWidth: 22
                    Layout.preferredHeight: 22
                    radius: 2
                    border.width: 0
                }

                ScAvatar{
                    fontIcon: ScFontIcons.md_close
                    iconColor:  ScColors.grey_9
                    Layout.preferredWidth: 22
                    Layout.preferredHeight: 22
                    radius: 2
                    border.width: 0
                    onClicked: dialog.close()
                }
            }
        }

        Rectangle{
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"
            Control {
                anchors.fill: parent
                anchors.margins: 2 * ScStyles.margin
                contentItem: dialog.content
            }


        }
    }

    background: Rectangle{
        color: ScColors.grey_1
        radius: ScStyles.panel_radius
        border.color: ScColors.grey_4
        border.width: 1
    }
}
