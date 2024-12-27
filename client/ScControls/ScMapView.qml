import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtWebEngine
import QtWebView
import cn.pc.controls

Rectangle {





    ScWebMapControl{
        id: bkWebMapControl
        anchors.fill: parent
    }

    ScMapControl{
        anchors.fill: parent
    }


    ScButton{
        text: "Background Map"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.rightMargin: 10
        leftIcon: ScFontIcons.md_public
        rightIcon: down ? ScFontIcons.md_arrow_right : ScFontIcons.md_arrow_drop_down
        onClicked:{
            menu.open()
        }

        ScPopup{
            id: menu
            x: parent.width - width
            y: parent.height
            height: column.height + topPadding + bottomPadding
            width: column.width + leftPadding + rightPadding
            ColumnLayout{
                id: column
                spacing: 1
                // ScButton{
                //     text: "Open Streets Map "
                //     Layout.fillWidth: true
                //     textAlignment: Text.AlignLeft
                //     onClicked: {

                //     }
                // }
                Repeater {
                    model: [
                        {icon: "",text: "No Background Map",type: "BLANK"},
                        {icon: "",text: "Open Streets Map",type: "OSM"},
                        {icon: "",text: "Gaode Streets",type: "GAODE_ROADMAP"},
                        {icon: "",text: "Gaode Satellite",type: "GAODE_SATELLITE"},
                        {icon: "",text: "Google Road Map",type: "GOOGLE_ROADMAP"},
                        {icon: "",text: "Google Terrain",type: "GOOGLE_TERRAIN"},
                        {icon: "",text: "Google Satellite",type: "GOOGLE_SATELLITE"},
                        {icon: "",text: "Tianditu Road Map",type: "TIANDITU_ROADMAP"},
                        {icon: "",text: "Tianditu Satellite",type: "TIANDITU_SATELLITE"},
                        {icon: "",text: "Bing Road Map",type: "BING_ROADMAP"},
                        {icon: "",text: "Bing Satellite",type: "BING_SATELLITE"}
                    ]
                    ScButton{
                        text: modelData.text
                        Layout.fillWidth: true
                        textAlignment: Text.AlignLeft
                        onClicked: {
                            menu.close()
                            bkWebMapControl.setBackgroundMap(modelData.type)
                        }
                    }
                }
            }
        }
    }


}
