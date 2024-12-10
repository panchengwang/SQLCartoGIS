import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Flickable{
    id: flick
    contentHeight: grid.height
    GridLayout{
        id: grid
        width: flick.width

        anchors.margins: PcStyles.margin

        columns: 2

        PcText{
            Layout.columnSpan: 2
            text: 'You can change system settings here: '
            font.pointSize: 13
        }

        PcText{
            text: 'Server address'
        }

        PcTextField{
            Layout.fillWidth: true
            text: "http://127.0.0.1/pcwanggisserver"
        }

        PcOkCancelButtons{
            Layout.columnSpan: 2
            okButtonText: "Save Settings"
            cancelButtonVisible: false
        }
    }
}

