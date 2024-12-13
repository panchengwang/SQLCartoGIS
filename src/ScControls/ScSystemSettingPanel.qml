import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ScTabPanel{
    title: "系统设置" //"System settings"
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

                ScText{
                    Layout.columnSpan: 2
                    text: 'You can change system settings here: '
                    font.pointSize: 13
                }

                ScText{
                    text: 'Server address'
                }

                ScTextField{
                    Layout.fillWidth: true
                    text: "http://127.0.0.1/pcwanggisserver"
                }
                ScText{
                    text: 'Server address'
                }

                ScTextField{
                    Layout.fillWidth: true
                    text: "http://127.0.0.1/pcwanggisserver"
                }
                ScText{
                    text: 'Server address'
                }

                ScTextField{
                    Layout.fillWidth: true
                    text: "http://127.0.0.1/pcwanggisserver"
                }
                ScText{
                    text: 'Server address'
                }

                ScTextField{
                    Layout.fillWidth: true
                    text: "http://127.0.0.1/pcwanggisserver"
                }
                ScText{
                    text: 'Server address'
                }

                ScTextField{
                    Layout.fillWidth: true
                    text: "http://127.0.0.1/pcwanggisserver"
                }
                ScText{
                    text: 'Server address'
                }

                ScTextField{
                    Layout.fillWidth: true
                    text: "http://127.0.0.1/pcwanggisserver"
                }
                ScText{
                    text: 'Server address'
                }

                ScTextField{
                    Layout.fillWidth: true
                    text: "http://127.0.0.1/pcwanggisserver"
                }
                ScText{
                    text: 'Server address'
                }

                ScTextField{
                    Layout.fillWidth: true
                    text: "http://127.0.0.1/pcwanggisserver"
                }
                ScText{
                    text: 'Server address'
                }

                ScTextField{
                    Layout.fillWidth: true
                    text: "http://127.0.0.1/pcwanggisserver"
                }
                ScText{
                    text: 'Server address'
                }

                ScTextField{
                    Layout.fillWidth: true
                    text: "http://127.0.0.1/pcwanggisserver"
                }
                ScText{
                    text: 'Server address'
                }

                ScTextField{
                    Layout.fillWidth: true
                    text: "http://127.0.0.1/pcwanggisserver"
                }

                ScOkCancelButtons{
                    Layout.columnSpan: 2
                    okButtonText: "Save Settings"
                    cancelButtonVisible: false
                }
            }
        }
    }
}
