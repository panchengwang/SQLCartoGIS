pragma Singleton
import QtQuick

QtObject
{

    property ScAppUtils appUtils: ScAppUtils{

    }


    function applicationFilePath(){
        return appUtils.applicationFilePath()
    }

    function applicationDirPath(){
        return appUtils.applicationDirPath()
    }
}
