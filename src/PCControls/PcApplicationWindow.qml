import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow{
    id: appWin
    title:  "PcWang GIS Editor"
    // flags: Qt.FramelessWindowHint
    color: PcColors.grey_2

    function center(){
        console.log("desktopAvailableWidth: ",Qt.application.screens[0].desktopAvailableWidth)
        x= (Qt.application.screens[0].desktopAvailableWidth - width)  * 0.5
        y= (Qt.application.screens[0].desktopAvailableHeight - height)  * 0.5
    }



    Rectangle{
        id: leftSidePanel
        width: 200
        color: PcColors.indigo_1
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        RowLayout{

            anchors.top : parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 5
            anchors.rightMargin: 10
            PcAvatar{
                // image: PcFileHelper.getLocalFilePathOfResource("./images/pcwang.png")
                fontIcon: PcFontIcons.md_account_circle
            }
            ColumnLayout{
                Layout.fillWidth: true
                Layout.fillHeight: true
                Text{
                    Layout.fillWidth: true
                    text: "未登录"
                }
                Text{
                    Layout.fillWidth: true
                    text: "注册"
                }
            }

            PcButton{

            }
        }


    }

    Rectangle{
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: leftSidePanel.right
        anchors.right: parent.right


        // GridLayout{
        //     anchors.centerIn: parent
        //     columns: 2
        //     PcAvatar{
        //         width: 100
        //         height: 100
        //         image: PcFileHelper.getLocalFilePathOfResource("./images/pcwang.png")

        //     }
        //     PcAvatar{
        //         width: 100
        //         height: 100
        //         image: PcFileHelper.getLocalFilePathOfResource("./images/seagull.png")

        //     }
        //     PcAvatar{
        //         width: 100
        //         height: 100
        //         image: PcFileHelper.getLocalFilePathOfResource("./images/seagull.png")

        //     }
        //     PcAvatar{
        //         width: 100
        //         height: 100
        //         image: PcFileHelper.getLocalFilePathOfResource("./images/pcwang.png")

        //     }
        // }
    }




    Component.onCompleted: {
        center()
    }
}
