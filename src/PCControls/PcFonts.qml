pragma Singleton

import QtQuick

QtObject {
    property FontLoader materialIconFont : FontLoader{
        source :  "file:///" + PcFileHelper.getLocalFilePathOfResource("./fonts/MaterialSymbolsOutlined-VariableFont_FILL,GRAD,opsz,wght.ttf")
    }

    property FontLoader notoSansSCFont : FontLoader{
        source :  "file:///" + PcFileHelper.getLocalFilePathOfResource("./fonts/NotoSansSC-Regular.ttf")
    }
}
