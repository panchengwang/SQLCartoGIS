
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import cn.pc.controls

ApplicationWindow{
    id: appWin
    title:  "GIS World"
    // flags: Qt.FramelessWindowHint
    color: ScColors.white


    property int currentIndex: 0

    function center(){
        x= (Qt.application.screens[0].desktopAvailableWidth - width)  * 0.5
        y= (Qt.application.screens[0].desktopAvailableHeight - height)  * 0.5
    }

    header: ScSystemBar{
        onShowSystemSettings:{
            // const newObject = Qt.createQmlObject(`
            //                                      import QtQuick

            //                                      ScSystemSettingPanel{
            //                                      anchors.margins: ScStyles.margin
            //                                      anchors.top: parent.top
            //                                      anchors.horizontalCenter: parent.horizontalCenter
            //                                      width: parent.width * 0.6
            //                                      }
            //                                      `,
            //                                      appWin.contentItem,
            //                                      "myDynamicSnippet"
            //                                      );
            if(!ScApplication.sysSettingPanel){
                ScApplication.sysSettingPanel = ScApplication.mainView.addQmlPanel("ScSystemSettingPanel.qml")
            }
        }
    }

    SplitView{
        anchors.fill: parent
        // visible: false
        orientation: Qt.Horizontal
        ScCatalog{
            id: catalog
            SplitView.fillHeight: true
            SplitView.preferredWidth: 300
            ScButton{
                Layout.fillWidth: true
                text: 'create table panel'
                onClicked:{
                    var panel= ScApplication.mainView.addQmlPanel("ScTabPanel.qml")
                    var num = Math.random();
                    panel.title = 'Panel ' + num;
                    panel.closeable = true; // num > 0.5
                    // var component = Qt.createComponent("ScTabPanel.qml");
                    // if (component.status == Component.Ready) {
                    //     var panel = component.createObject();
                    //     var num = Math.random();
                    //     panel.title = 'Panel ' + num;
                    //     panel.closeable = true; // num > 0.5
                    //     tabView.add(panel)
                    // }
                }
            }

            Component.onCompleted:{
                ScApplication.catalog = catalog;
            }

            // Item{
            //     Layout.fillHeight: true
            // }
        }

        // Rectangle{
        //             SplitView.fillWidth: true
        //             SplitView.fillHeight: true
        //             color: "#88FF0000"
        //             }

        SplitView{
            SplitView.fillWidth: true
            SplitView.fillHeight: true
            orientation: Qt.Vertical
            ScTabView{
                id: tabView
                anchors.margins: 0
                SplitView.fillWidth: true
                SplitView.fillHeight: true
                Component.onCompleted:{
                    ScApplication.mainView = tabView
                }
            }

            ScTabView{
                id: bottomTabView
                SplitView.preferredHeight: 200
                SplitView.fillWidth: true
                tabButtonWidth: 80
                Component.onCompleted: {
                    if(!ScApplication.logPanel){
                        ScApplication.logPanel = bottomTabView.addQmlPanel("ScLogPanel.qml")
                    }
                }
            }
        }

        SplitView{
            SplitView.fillHeight: true
            SplitView.preferredWidth: 300
            orientation: Qt.Vertical
            Rectangle{
                SplitView.fillHeight: true
                SplitView.fillWidth: true
                clip: true
                ColumnLayout{
                    anchors.top: parent.top;
                    anchors.left: parent.left;
                    anchors.right: parent.right

                    Rectangle{
                        Layout.fillWidth: true
                        Layout.preferredHeight: 300
                        Layout.margins: 5
                        border.width: 1
                        border.color: ScColors.grey_5
                        radius: 5
                        TextEdit{
                            id: params
                            anchors.fill: parent
                            text:
                                `{
                            "name":"pcwang"
                            }`
                        }
                    }

                    ScButton{
                        Layout.fillWidth: true
                        text: "test ajax"
                        onClicked:{
                            var obj = JSON.parse(params.text)
                            ajax.post(obj,"e:/Untitled-1.json")
                        }
                    }

                    ScAjax{
                        id: ajax
                        url: "http://127.0.0.1/sqlcarto/service.php"
                        onFinished: (response)=>{
                                        try{
                                            var resobj = JSON.parse(response)
                                            ScApplication.logPanel.appendLog((new Date()).toLocaleString() + ": " + resobj.message)
                                        }catch(error){
                                            console.log(response);
                                            console.log(error);
                                        }
                                    }
                        onError:(message)=>{
                                    ScApplication.logPanel.appendLog(message)
                                }
                    }
                }
            }


        }




    }

    ScNotify{
        id: notify

        Component.onCompleted: {
            ScApplication.notify = notify
        }
    }






    Component.onCompleted: {
        center()
        ScApplication.appWin = appWin

    }
}
