import QtQuick
import QtQuick.Layouts
import QtQuick.Controls


ColumnLayout{

    id: tabView

    spacing: 0


    property var buttons: []
    property var panels: []
    property int currentIndex: -1
    property int tabButtonWidth: 120
    Rectangle{
        Layout.fillWidth: true
        Layout.preferredHeight: ScStyles.button_implicit_height
        color: ScColors.grey_3
        RowLayout{
            anchors.fill: parent
            spacing: 0

            ScAvatar{
                fontIcon: ScFontIcons.md_arrow_left
                border.width: 0
                radius: 0
                Layout.preferredHeight: ScStyles.button_implicit_height
                Layout.preferredWidth: ScStyles.button_implicit_height

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

            ScAvatar{
                fontIcon: ScFontIcons.md_arrow_right
                border.width: 0
                radius: 0
                Layout.preferredHeight: ScStyles.button_implicit_height
                Layout.preferredWidth: ScStyles.button_implicit_height
            }
        }
    }

    StackLayout {
        id: stack
        Layout.fillWidth: true
        Layout.fillHeight: true
    }

    function addQmlPanel(qmlfile){
        var component = Qt.createComponent(qmlfile);
        var panel = null;
        if(component.status == Component.Ready){
            panel = component.createObject();
            add(panel);
        }
        return panel
    }

    function add(panel){

        var component = Qt.createComponent("ScTabButton.qml");
        if (component.status == Component.Ready) {
            var btn = component.createObject();

            tabView.buttons.push(btn)
            tabView.panels.push(panel);
            tabView.currentIndex = tabView.buttons.length -1;

            btn.text = panel.title
            btn.closeable = panel.closeable
            btn.index = tabView.currentIndex
            btn.leftIcon = panel.icon
            btn.Layout.preferredWidth = tabView.tabButtonWidth
            btn.background.topLeftRadius = 0.25 * btn.height
            btn.background.topRightRadius = 0.25 * btn.height

            btn.clicked.connect(()=>{
                                    tabView.currentIndex = btn.index;
                                    stack.currentIndex = tabView.currentIndex;
                                    for(var i=0; i<tabView.buttons.length; i++){
                                        tabView.buttons[i].isActivate = false;
                                    }
                                    btn.isActivate = true
                                })
            btn.closed.connect(()=>{
                                   var btns = rowButtons.children;
                                   if( btn.index === tabView.buttons.length-1){
                                       tabView.currentIndex = btn.index - 1
                                   }else if(btn.index < tabView.currentIndex){
                                       tabView.currentIndex --;
                                   }

                                   stack.currentIndex = tabView.currentIndex

                                   for(var i=btn.index; i<btns.length; i++){
                                       btns[i].index --;
                                   }
                                   tabView.buttons.splice(tabView.buttons.indexOf(btn),1)
                                   tabView.panels.splice(tabView.panels.indexOf(panel),1)
                                   panel.destroy()
                                   btn.destroy()
                                   for(var i=0; i<tabView.buttons.length; i++){
                                       tabView.buttons[i].isActivate = false;
                                   }
                                   if(tabView.currentIndex >= 0){
                                       tabView.buttons[tabView.currentIndex].isActivate = true;
                                   }
                               })
            rowButtons.children.push(btn)
            for(var i=0; i<tabView.buttons.length; i++){
                tabView.buttons[i].isActivate = false;
            }
            btn.isActivate = true

            panel.dataChanged.connect(()=>{
                                          btn.text = panel.title
                                          btn.closeable = panel.closeable
                                      })
            panel.closed.connect(()=>{
                                     var btns = rowButtons.children;
                                     if( btn.index === tabView.buttons.length-1){
                                         tabView.currentIndex = btn.index - 1
                                     }else if(btn.index < tabView.currentIndex){
                                         tabView.currentIndex --;
                                     }

                                     stack.currentIndex = tabView.currentIndex

                                     for(var i=btn.index; i<btns.length; i++){
                                         btns[i].index --;
                                     }
                                     tabView.buttons.splice(tabView.buttons.indexOf(btn),1)
                                     tabView.panels.splice(tabView.panels.indexOf(panel),1)
                                     panel.destroy()
                                     btn.destroy()
                                     for(var i=0; i<tabView.buttons.length; i++){
                                         tabView.buttons[i].isActivate = false;
                                     }
                                     if(tabView.currentIndex >= 0){
                                         tabView.buttons[tabView.currentIndex].isActivate = true;
                                     }
                                 })
        }
        stack.children.push(panel)
        stack.currentIndex = tabView.currentIndex

    }



}
