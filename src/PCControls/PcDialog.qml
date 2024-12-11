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
        color: PcColors.grey_1
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
            implicitHeight: PcStyles.panel_header_implicit_height
            color: PcColors.grey_4
            topRightRadius: background.radius
            topLeftRadius: background.radius

            RowLayout{
                anchors.fill: parent
                anchors.rightMargin: PcStyles.margin
                anchors.leftMargin: PcStyles.margin
                PcText{
                    Layout.fillWidth: true
                    text: dialog.title
                    color:  PcColors.grey_9
                    font.pointSize: 12
                }
                PcAvatar{
                    fontIcon: PcFontIcons.md_minimize
                    iconColor: PcColors.grey_9
                    Layout.preferredWidth: 22
                    Layout.preferredHeight: 22
                    radius: 2
                    border.width: 0
                }

                PcAvatar{
                    fontIcon: PcFontIcons.md_crop_square
                    iconColor:  PcColors.grey_9
                    Layout.preferredWidth: 22
                    Layout.preferredHeight: 22
                    radius: 2
                    border.width: 0
                }

                PcAvatar{
                    fontIcon: PcFontIcons.md_close
                    iconColor:  PcColors.grey_9
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
                anchors.margins: 2 * PcStyles.margin
                contentItem: dialog.content
            }


        }
    }

    background: Rectangle{
        color: PcColors.grey_1
        radius: PcStyles.panel_radius
        border.color: PcColors.grey_4
        border.width: 1
    }
}
