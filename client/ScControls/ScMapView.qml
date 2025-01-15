import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import cn.pc.controls

Rectangle {

    ScWebMapControl{
        id: bkWebMapControl
        anchors.fill: parent
        currentMap: switcher.currentMap
        // Component.onCompleted:{
        //     bkWebMapControl.setBackgroundMap('GAODE')
        // }

    }

    ScMapControl{
        id: mapControl
        anchors.fill: parent
        Component.onCompleted:{
            // timer.start();
            console.log("map: ", mapControl.width)
        }
        onMapClicked:(pixel,coord)=>{
            // let pt1 = (ScOGRPoint)pixel;
            console.log(coord.x,coord.y);
        }
    }


    ScWebMapSwitcher {
        id: switcher
        webMapControl: bkWebMapControl
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.rightMargin: 10
        // leftIcon: ScFontIcons.md_public
        // rightIcon: down ? ScFontIcons.md_arrow_right : ScFontIcons.md_arrow_drop_down

    }

    // Timer{
    //     id: timer
    //     interval: 1000
    //     repeat: false
    //     onTriggered:{
    //         mapControl.setInitialMapExtent(-180,-90,180,90);
    //     }
    // }

}
