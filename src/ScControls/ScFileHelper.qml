pragma Singleton

import QtQuick

QtObject
{

    property ScFileUtils utils: ScFileUtils{

    }

    function path(filename){
        return utils.path(filename);
    }

    function getLocalFilePathOfResource(resourcename){
        return  ScAppHelper.applicationDirPath() + "/" + ScFileHelper.path('' + Qt.resolvedUrl(resourcename))
    }

}
