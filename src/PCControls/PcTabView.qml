import QtQuick
import QtQuick.Layouts
import QtQuick.Controls


ColumnLayout{

    id: tabView

    spacing: 0


    property var buttons: []
    property var panels: []
    property int currentIndex: -1

    Rectangle{
        Layout.fillWidth: true
        Layout.preferredHeight: PcStyles.button_implicit_height
        color: PcColors.grey_3
        RowLayout{
            anchors.fill: parent
            spacing: 0

            PcAvatar{
                fontIcon: PcFontIcons.md_arrow_left
                border.width: 0
                radius: 0
                Layout.preferredHeight: PcStyles.button_implicit_height
                Layout.preferredWidth: PcStyles.button_implicit_height

            }
            Flickable{
                id: flick
                Layout.fillWidth: true
                Layout.fillHeight: true
                contentWidth: rowButtons.width
                clip: true
                RowLayout{
                    id: rowButtons
                    spacing: 0
                }
            }

            PcAvatar{
                fontIcon: PcFontIcons.md_arrow_right
                border.width: 0
                radius: 0
                Layout.preferredHeight: PcStyles.button_implicit_height
                Layout.preferredWidth: PcStyles.button_implicit_height
            }
        }
    }

    StackLayout {
        id: stack
        Layout.fillWidth: true
        Layout.fillHeight: true
    }


    function add(panel){

        var component = Qt.createComponent("PcTabButton.qml");
        if (component.status == Component.Ready) {
            var btn = component.createObject();

            tabView.buttons.push(btn)
            tabView.panels.push(panel);
            tabView.currentIndex = tabView.buttons.length -1;

            btn.text = panel.title
            btn.closeable = panel.closeable
            btn.index = tabView.currentIndex

            btn.clicked.connect(()=>{
                                    tabView.currentIndex = btn.index;
                                    stack.currentIndex = tabView.currentIndex;
                                    for(var i=0; i<tabView.buttons.length; i++){
                                        tabView.buttons[i].isActivate = false;
                                    }
                                    btn.isActivate = true
                                })
            btn.closed.connect(()=>{
                                   tabView.currentIndex = btn.index;
                                   stack.currentIndex = tabView.currentIndex;
                                   var btns = rowButtons.children;
                                   if( btn.index === tabView.buttons.length-1){
                                       tabView.currentIndex --
                                   }
                                   stack.currentIndex = tabView.currentIndex

                                   for(var i=btn.index; i<btns.length; i++){
                                       btns[i].index --;
                                   }
                                   tabView.buttons.splice(tabView.buttons.indexOf(btn),1)
                                   tabView.panels.splice(tabView.panels.indexOf(panel),1)
                                   panel.destroy()
                                   btn.destroy()
                               })
            rowButtons.children.push(btn)
            for(var i=0; i<tabView.buttons.length; i++){
                tabView.buttons[i].isActivate = false;
            }
            btn.isActivate = true
        }
        stack.children.push(panel)
        stack.currentIndex = tabView.currentIndex

    }


    // TabBar {
    //     id: bar
    //     Layout.fillWidth: true
    //     background:Rectangle{
    //         border.width: 1
    //         border.color: PcColors.grey_5
    //     }

    //     TabButton {
    //         text: qsTr("Home")
    //         contentItem:PcButton{
    //             text: parent.text
    //             rightIcon: PcFontIcons.md_close
    //             onClicked:{
    //                 parent.click()
    //             }
    //         }
    //     }
    //     TabButton {
    //         text: qsTr("Discover")
    //     }
    //     TabButton {
    //         text: qsTr("Activity")
    //     }
    // }

    // StackLayout {
    //     Layout.fillWidth: true
    //     Layout.fillHeight: true
    //     currentIndex: bar.currentIndex
    //     Rectangle {
    //         id: homeTab
    //         color: "red"
    //     }
    //     Rectangle {
    //         id: discoverTab
    //         color: "green"
    //     }
    //     Rectangle {
    //         id: activityTab
    //         color: "blue"
    //     }
    // }
}
