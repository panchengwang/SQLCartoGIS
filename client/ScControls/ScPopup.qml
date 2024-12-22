import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Popup {
    id: popup
    width: 200
    height: 300
    // parent: Overlay.overlay
    // x: Math.round((parent.width - width) / 2)
    // y: Math.round((parent.height - height) / 2)
    closePolicy: modal ?  Popup.CloseOnEscape : Popup.CloseOnEscape | Popup.CloseOnPressOutside
    background: Rectangle{
        border.width: 1
        border.color: ScColors.grey_5
        color: ScColors.grey_2
        radius: 2
    }

    Overlay.modal: Rectangle {
        color: ScColors.grey_1
        opacity: 0.3
    }

}
