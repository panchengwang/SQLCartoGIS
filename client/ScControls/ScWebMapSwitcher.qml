import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic


// ComboBox {
//     id: control
//     editable: false
//     property ScWebMapControl webMapControl: null
//     property string currentMap: model[currentIndex].value
//     textRole: "text"
//     valueRole: "value"
//     rightPadding: 0
//     leftPadding: 5

//     model: [
//         {value: "BLANK", text: "Blank"},
//         {value: "OSM", text: "OpenStreetMap" },
//         {value: "GAODE", text: "GaoDe" },
//         {value: "TIANDITU", text: "TianDiTu" },
//         {value: "GOOGLE", text: "Google" },
//         {value: "BING", text: "Bing" }
//     ]

//     delegate: ItemDelegate {
//          id: delegate

//          required property var model
//          required property int index

//          width: control.width
//          contentItem: Text {
//              text: delegate.model[control.textRole]
//              color: "#21be2b"
//              font: control.font
//              elide: Text.ElideRight
//              verticalAlignment: Text.AlignVCenter
//          }
//          highlighted: control.highlightedIndex === index
//      }

//     background: Rectangle {
//         implicitWidth: 120 // ScStyles.button_implicit_width
//         implicitHeight: ScStyles.button_implicit_height
//         color: ScColors.grey_4
//         border.color: ScColors.grey_5
//         border.width: 1
//         radius: ScStyles.radius

//         MouseArea{
//             id: mouseArea
//             anchors.fill: parent
//             hoverEnabled: true
//         }
//     }
//     indicator: ScAvatar{
//         radius: 2
//         fontIcon: ScFontIcons.md_arrow_drop_down
//         x: control.width - width - control.rightPadding
//         y: control.topPadding + (control.availableHeight - height) / 2
//         height: parent.height
//         width: height
//         clickable: false
//         border.width: 0
//     }

//     contentItem: ScText {
//         rightPadding: control.indicator.width + control.spacing

//         text: control.displayText
//         font: control.font
//         verticalAlignment: Text.AlignVCenter
//         elide: Text.ElideRight
//     }

//     onCurrentIndexChanged:{
//         changeWebMap()
//     }

//     Component.onCompleted:{
//         changeWebMap()
//     }

//     function changeWebMap(){
//         var val = control.model[currentIndex].value
//         currentMap = val;
//         // if(control.webMapControl){
//         //     control.webMapControl.setBackgroundMap(val)
//         // }
//     }
// }

// ColumnLayout{
//     id: switcher
//     property alias currentMap: control.currentMap
ScButton {
    id: control
    property ScWebMapControl webMapControl: null
    property string currentMap: ""
    leftIcon: ScFontIcons.md_public
    rightIcon: ScFontIcons.md_arrow_drop_down
    text: "Blank"
    width: menu.width
    onClicked:{
        menu.open()
    }

    ScPopup{
        id: menu
        x: parent.width - width
        y: parent.height
        height:  column.height + topPadding + bottomPadding
        width: column.width + leftPadding + rightPadding
        ColumnLayout{
            id: column
            spacing: 1
            Repeater {
                model: [
                    {icon: "",text: "Blank",type: "BLANK"},
                    {icon: ScFileHelper.getLocalFilePathOfResource("./icons/gaode.png"),text: "Gaode",type: "GAODE"},
                    {icon: ScFileHelper.getLocalFilePathOfResource("./icons/google.png"),text: "Google",type: "GOOGLE"},
                    {icon: ScFileHelper.getLocalFilePathOfResource("./icons/microsoft.png"),text: "Bing",type: "BING"},
                    {icon: ScFileHelper.getLocalFilePathOfResource("./icons/tianditu.png"),text: "Tianditu",type: "TIANDITU"},
                    {icon: ScFileHelper.getLocalFilePathOfResource("./icons/osm.svg"),text: "Open Streets Map",type: "OSM"}
                ]
                RowLayout{
                    Layout.fillWidth: true
                    spacing: 0
                    ScAvatar{
                        image: modelData.icon
                        border.width: 0
                        width: height
                        height: button.height
                        radius: 1
                    }

                    ScButton{
                        id: button
                        text: modelData.text
                        Layout.fillWidth: true
                        textAlignment: Text.AlignLeft
                        onClicked: {
                            menu.close()
                            control.currentMap = modelData.type;
                            control.text = modelData.text
                            if(modelData.type === "GAODE"){
                                chkGaodeStandard.checked = true;
                                chkGaodeLabel.checked = true;
                                chkGaodeTraffic.checked = false;
                                chkGaodeRoadNet.checked = false;
                                chkGaodeSatellite.checked = false;
                            }
                        }
                    }
                }
            }
        }
    }

    ScPopup{
        id: gaodeControls

        x: (parent.width - width)*0.5
        y: parent.height + 5
        visible: control.currentMap === "GAODE"
        height:  gaodeColumn.height + topPadding + bottomPadding
        width:  gaodeColumn.width + leftPadding + rightPadding
        closePolicy: Popup.NoAutoClose
        background: Rectangle{
            color: ScColors.grey_4
            opacity: 0.8
            border.color: ScColors.grey_8
            border.width: 1
        }
        padding: 0
        ColumnLayout{
            id: gaodeColumn
            ScCheckbox{
                id: chkGaodeLabel
                text: "Label & POI"
                Layout.fillWidth: true
                onCheckedChanged:{
                    // webMapControl.setGaodeLayerVisible("LABEL",checked)
                    if(checked){
                        webMapControl.runJavaScript(`
                                                    getLayerByClassName("AMap.Inner.LabelsLayer").show()
                                                    `)
                    }else{
                        webMapControl.runJavaScript(`
                                                    getLayerByClassName("AMap.Inner.LabelsLayer").hide()
                                                    `)
                    }
                }
            }
            ScCheckbox{
                id: chkGaodeStandard
                text: "Standard"
                Layout.fillWidth: true
                onCheckedChanged:{
                    if(checked){
                        webMapControl.runJavaScript(`
                                                    standardLayer.show();
                                                    `)
                        if(!chkGaodeLabel.checked){
                            webMapControl.runJavaScript(`
                                                        getLayerByClassName("AMap.Inner.LabelsLayer").hide()
                                                        `)
                        }
                    }else{
                        webMapControl.runJavaScript(`
                                                    standardLayer.hide();
                                                    `)
                        if(chkGaodeLabel.checked){
                            webMapControl.runJavaScript(`
                                                        getLayerByClassName("AMap.Inner.LabelsLayer").show()
                                                        `)
                        }
                    }
                }
            }
            ScCheckbox{
                id: chkGaodeSatellite
                text: "Satellite"
                Layout.fillWidth: true
                onCheckedChanged:{
                    if(checked){
                        webMapControl.runJavaScript(`
                                                    satelliteLayer.show();
                                                    `)
                    }else{
                        webMapControl.runJavaScript(`
                                                    satelliteLayer.hide();
                                                    `)
                    }
                }
            }

            ScCheckbox{
                id: chkGaodeTraffic
                text: "Traffic"
                Layout.fillWidth: true
                onCheckedChanged:{
                    if(checked){
                        webMapControl.runJavaScript(`
                                                    trafficLayer.show();
                                                    `)

                    }else{
                        webMapControl.runJavaScript(`
                                                    trafficLayer.hide();
                                                    `)
                    }
                }
            }

            ScCheckbox{
                id: chkGaodeRoadNet
                text: "Road Net"
                Layout.fillWidth: true
                onCheckedChanged:{
                    if(checked){
                        webMapControl.runJavaScript(`
                                                    roadNetLayer.show();
                                                    `)
                        if(!chkGaodeLabel.checked){
                            webMapControl.runJavaScript(`
                                                        getLayerByClassName("AMap.Inner.LabelsLayer").hide()
                                                        `)
                        }
                    }else{
                        webMapControl.runJavaScript(`
                                                    roadNetLayer.hide();
                                                    `)
                    }
                }
            }
        }
    }
}
// }


