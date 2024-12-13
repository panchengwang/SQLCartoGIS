
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import cn.pc.controls

ApplicationWindow{
    id: appWin
    title:  "ScWang GIS Editor"
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
        ScTabView{
            id: tabView
            SplitView.fillWidth: true
            SplitView.fillHeight: true
            anchors.margins: 0
            Component.onCompleted:{
                ScApplication.mainView = tabView
            }
        }


        // Rectangle{
        //     SplitView.fillHeight: true
        //     SplitView.preferredWidth: 200
        //     color: "blue"
        // }
    }

    // ScSystemSettingPanel{
    //     anchors.margins: ScStyles.margin
    //     anchors.top: parent.top
    //     anchors.horizontalCenter: parent.horizontalCenter
    //     width: parent.width * 0.6
    // }

    // header: Rectangle{
    //     implicitHeight: ScStyles.header_implicit_height
    //     color: ScColors.indigo_5

    //     RowLayout{
    //         anchors.fill: parent
    //         anchors.rightMargin: ScStyles.margin
    //         anchors.leftMargin: 2 * ScStyles.margin

    //         ScAvatar{
    //             id: avatarSettings
    //             // image: ScFileHelper.getLocalFilePathOfResource("./images/pcwang.png")
    //             fontIcon: ScFontIcons.md_settings
    //             iconColor: ScColors.white
    //             border.width: 0
    //             onClicked:{
    //             }
    //         }

    //         ScText{
    //             Layout.fillWidth: true
    //             text: appWin.title
    //             font.pointSize: 13
    //             color: ScColors.white
    //         }

    //         ScAvatar{
    //             id: userAvatar
    //             image: ScFileHelper.getLocalFilePathOfResource("./images/pcwang.png")
    //             fontIcon: ScFontIcons.md_account_circle
    //             onClicked:{
    //                 if(!ScApplication.hasLogin()){
    //                     loginPanel.y = 120
    //                     loginPanel.open()
    //                 }
    //             }
    //         }
    //     }
    // }




    // ScLoginDialog{
    //     id: loginPanel
    //     visible: false
    //     z: 1024
    //     minWidth: 300
    //     maxWidth: 600
    //     modal: true
    //     closePolicy: modal ? Popup.CloseOnEscape : Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    // }

    // Rectangle{
    //     id: leftSidePanel
    //     width: 160
    //     color: ScColors.indigo_1
    //     anchors.top: parent.top
    //     anchors.bottom: parent.bottom
    //     ColumnLayout{
    //         anchors.fill: parent
    //         anchors.margins: ScStyles.margin
    //         spacing: ScStyles.spacing
    //         RowLayout{
    //             Layout.fillWidth: true
    //             spacing: ScStyles.spacing
    //             ScAvatar{
    //                 id: userAvatar
    //                 image: ScFileHelper.getLocalFilePathOfResource("./images/pcwang.png")
    //                 fontIcon: ScFontIcons.md_account_circle
    //                 onClicked:{
    //                     if(!ScApplication.hasLogin()){
    //                         loginPanel.visible = true
    //                         var pos = mapToItem(appWin.contentItem, userAvatar.width, userAvatar.height)
    //                         loginPanel.x = pos.x + 5
    //                         loginPanel.y = pos.y + 5
    //                         loginPanel.open()
    //                     }
    //                 }
    //             }
    //             ColumnLayout{
    //                 Layout.fillWidth: true
    //                 Layout.fillHeight: true
    //                 // ScButton{
    //                 //     Layout.fillWidth: true
    //                 //     flat: true
    //                 //     // outlined: true
    //                 //     text: ScApplication.user.trim() !== '' ? ScApplication.user : 'Sign In'
    //                 //     // color: "transparent"
    //                 //     // border.width: 0
    //                 //     // radius: 0
    //                 // }
    //                 // Text{
    //                 //     Layout.fillWidth: true
    //                 //     font.pointSize: 8
    //                 //     text: ""
    //                 //     visible: text.trim() !== ''
    //                 // }
    //             }

    //             ScAvatar{
    //                 Layout.alignment: Qt.AlignVCenter
    //                 fontIcon: ScFontIcons.md_add_circle
    //                 Layout.preferredWidth: 28
    //                 Layout.preferredHeight: 28
    //                 border.width: 0
    //             }
    //         }

    //         ScSeperator{
    //             Layout.fillWidth: true
    //             Layout.preferredHeight: 1
    //         }

    //         Item{
    //             Layout.fillHeight : true
    //         }
    //     }




    // }

    // Rectangle{
    //     anchors.top: parent.top
    //     anchors.bottom: parent.bottom
    //     anchors.left: leftSidePanel.right
    //     anchors.right: parent.right


    //     // GridLayout{
    //     //     anchors.centerIn: parent
    //     //     columns: 2
    //     //     ScAvatar{
    //     //         width: 100
    //     //         height: 100
    //     //         image: ScFileHelper.getLocalFilePathOfResource("./images/pcwang.png")

    //     //     }
    //     //     ScAvatar{
    //     //         width: 100
    //     //         height: 100
    //     //         image: ScFileHelper.getLocalFilePathOfResource("./images/seagull.png")

    //     //     }
    //     //     ScAvatar{
    //     //         width: 100
    //     //         height: 100
    //     //         image: ScFileHelper.getLocalFilePathOfResource("./images/seagull.png")

    //     //     }
    //     //     ScAvatar{
    //     //         width: 100
    //     //         height: 100
    //     //         image: ScFileHelper.getLocalFilePathOfResource("./images/pcwang.png")

    //     //     }
    //     // }
    // }




    Component.onCompleted: {
        center()
        ScApplication.appWin = appWin

    }
}
