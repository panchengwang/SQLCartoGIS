import QtQuick
import QtQuick.Layouts

RowLayout {
    id: buttons
    property string okButtonText: "OK"
    property string cancelButtonText: "Cancel"

    signal cancel()
    signal ok()

    Item{
        Layout.fillWidth: true
    }

    PcButton{
        text: buttons.okButtonText
        onClicked: buttons.ok()
    }

    PcButton{
        text: buttons.cancelButtonText
        onClicked: buttons.cancel()
    }
}
