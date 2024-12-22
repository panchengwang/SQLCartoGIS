import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ScTabPanel{
    id: panel
    title: "System settings"
    icon: ScFontIcons.md_settings
    Rectangle{

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.6 < 300 ? 300 : parent.width * 0.6
        anchors.margins: ScStyles.margin

        Flickable{
            id: flick
            anchors.fill: parent
            contentHeight: grid.height
            contentWidth: grid.width
            GridLayout{
                id: grid
                width: flick.width

                anchors.margins: ScStyles.margin

                columns: 2

                // ScText{
                //     Layout.columnSpan: 2
                //     text: 'You can change system settings here: '
                //     font.pointSize: 11
                // }

                ScText{
                    text: 'Server address'
                }

                ScTextField{
                    id: txtMasterUrl
                    Layout.fillWidth: true
                    text: ScApplication.masterUrl
                }

                ScText{
                    text: 'Accelerate by local host'
                }

                RowLayout{
                    Layout.fillWidth: true
                    ScCheckbox{
                        text: ''
                    }
                    Item{
                        Layout.fillWidth: true
                    }
                }

                ScOkCancelButtons{
                    Layout.columnSpan: 2
                    okButtonText: "Save Settings"
                    cancelButtonVisible: false
                    onOk:{
                        ScApplication.masterUrl = txtMasterUrl.text.trim()
                        panel.closed()
                    }
                }
            }
        }
    }
}
