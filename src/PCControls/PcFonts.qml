pragma Singleton

import QtQuick

QtObject {
    property FontLoader materialIconFont : FontLoader{
        source : "./fonts/MaterialSymbolsOutlined-Regular.ttf"
    }

    property FontLoader notoSansSCFont : FontLoader{
        source : "./fonts/NotoSansSC-Regular.ttf"
    }
}
