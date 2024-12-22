import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Popup {
    id: notify

    property string position: "top"
    property string type: "information"
    property string message: ''

    height: column.height + topPadding + bottomPadding
    width: column.width + leftPadding + rightPadding
    clip: true
    parent: Overlay.overlay

    x: (parent.width - width) * 0.5
    y: position === "top" ? ScStyles.margin : (
                                position === "bottom" ? parent.height - ScStyles.margin - height :
                                                        (parent.height - height) * 0.5
                                )

    background: Rectangle{
        border.width: 1
        border.color: ScColors.grey_5
        color: ScColors.blue_2
        radius: 5
        opacity: 1
    }

    ColumnLayout{
        id: column
        RowLayout{
            Layout.fillWidth: true

            ColumnLayout{

                ScAvatar{
                    border.width: 0
                    fontIcon: notify.type === "information" ? ScFontIcons.md_info : (
                                                                  notify.type === "warning" ? ScFontIcons.md_warning : (
                                                                                                  notify.type === "error" ? ScFontIcons.md_error : ''
                                                                                                  )
                                                                  )
                    iconColor: ScColors.red_5
                }
                Item{
                    Layout.fillHeight: true
                }
            }

            ScText{
                wrapMode: Text.WordWrap
                text: notify.message
                Layout.preferredWidth: notify.parent.width * 0.5 > 300 ? notify.parent.width * 0.5 : 200

            }

        }

    }

    onOpened:{
        timer.restart()
    }

    Timer{
        id: timer
        interval: 2000
        repeat: false
        onTriggered:{
            notify.close()
        }
    }
}
