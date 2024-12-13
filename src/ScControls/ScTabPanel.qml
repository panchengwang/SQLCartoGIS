import QtQuick

Rectangle {

    id: tabPanel

    property string title: 'tabPanel'
    property bool closeable: true
    property string icon: ''

    clip: true


    signal activated()
    signal dataChanged()

    function activate(){
        tabPanel.activated()
    }

    onTitleChanged:{
        tabPanel.dataChanged()
    }

    onCloseableChanged:{
        tabPanel.dataChanged()
    }

}
