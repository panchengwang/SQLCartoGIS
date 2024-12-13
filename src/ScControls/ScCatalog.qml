import QtQuick
import QtQuick.Layouts
import QtQuick.Controls


ColumnLayout {
    implicitHeight: 200
    implicitWidth: 200

    ScButton{
        Layout.fillWidth: true
        leftIcon: ScFontIcons.md_database
        text: 'Spatial Database'
        textAlignment: Text.AlignLeft
    }

    TreeView{
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
}
