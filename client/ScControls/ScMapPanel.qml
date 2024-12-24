import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ScTabPanel {
    id: panel
    icon: ScFontIcons.md_map
    title: "Map"
    closeable: true

    SplitView{
        anchors.fill: parent
        ScMapView{
            SplitView.fillWidth: true
            SplitView.fillHeight: true
        }
    }
}
