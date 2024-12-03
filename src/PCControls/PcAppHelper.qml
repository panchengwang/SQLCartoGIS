pragma Singleton
import QtQuick

QtObject
{

    property PcAppUtils appUtils: PcAppUtils{

    }


    function applicationFilePath(){
        return appUtils.applicationFilePath()
    }

    function applicationDirPath(){
        return appUtils.applicationDirPath()
    }
}
