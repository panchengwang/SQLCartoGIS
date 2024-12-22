import QtQuick
import QtQuick.Layouts

RowLayout {
    id: buttons
    property string okButtonText: "OK"
    property string cancelButtonText: "Cancel"
    property alias cancelButtonVisible: cancelButton.visible

    signal cancel()
    signal ok()

    Item{
        Layout.fillWidth: true
    }

    ScButton{
        text: buttons.okButtonText
        onClicked: buttons.ok()
    }

    ScButton{
        id: cancelButton
        text: buttons.cancelButtonText
        onClicked: buttons.cancel()
    }
}
