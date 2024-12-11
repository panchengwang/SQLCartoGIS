import QtQuick

Rectangle {

    id: tabPanel

    property string title: 'tabPanel'
    property bool closeable: true

    signal activated()

    function activate(){
        tabPanel.activated()
    }




    PcText{
        anchors.centerIn: parent
        text: tabPanel.title
        font.pointSize: 30
    }
}
