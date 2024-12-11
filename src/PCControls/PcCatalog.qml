import QtQuick
import QtQuick.Layouts
import QtQuick.Controls


ColumnLayout {
    implicitHeight: 200
    implicitWidth: 200

    PcButton{
        Layout.fillWidth: true
        leftIcon: PcFontIcons.md_database
        text: 'Spatial Database'
        textAlignment: Text.AlignLeft
    }

    TreeView{
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
}
