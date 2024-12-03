pragma Singleton

import QtQuick

QtObject
{

    property PcFileUtils utils: PcFileUtils{

    }

    function path(filename){
        return utils.path(filename);
    }

    function getLocalFilePathOfResource(resourcename){
        return PcAppHelper.applicationDirPath() + "/" + PcFileHelper.path('' + Qt.resolvedUrl(resourcename))
    }

}
