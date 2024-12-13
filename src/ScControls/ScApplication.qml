pragma Singleton
import QtQuick

QtObject
{

    property ScApplicationWindow appWin: null
    property ScSystemSettingPanel sysSettingPanel: null
    property ScTabView mainView: null
    property ScCatalog catalog: null

    property string user: ''
    property string token: ''


    function hasLogin(){
        return ScApplication.token.trim() !== ''
    }
}
