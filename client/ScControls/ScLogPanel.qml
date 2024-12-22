import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ScTabPanel{
    id: panel
    title: "Logs"
    icon: ScFontIcons.md_message
    closeable: false

    Flickable {
        id: flick

        anchors.fill: parent
        contentWidth: edit.contentWidth
        contentHeight: edit.contentHeight
        ScrollBar.vertical: ScrollBar{

        }
        clip: true

        function ensureVisible(r)
        {
            if (contentX >= r.x)
                contentX = r.x;
            else if (contentX+width <= r.x+r.width)
                contentX = r.x+r.width-width;
            if (contentY >= r.y)
                contentY = r.y;
            else if (contentY+height <= r.y+r.height)
                contentY = r.y+r.height-height;
        }

        TextEdit {
            id: edit
            width: flick.width
            focus: true
            padding: ScStyles.padding
            rightPadding: flick.ScrollBar.vertical.visible ? flick.ScrollBar.vertical.width + ScStyles.padding : ScStyles.padding
            wrapMode: TextEdit.WordWrap
            // onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
        }
    }

    function appendLog(log){
        edit.insert(edit.length, log.trim()+"\n")
    }
}
