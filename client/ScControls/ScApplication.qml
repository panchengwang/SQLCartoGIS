pragma Singleton
import QtQuick

QtObject
{

    property ScApplicationWindow appWin: null
    property ScSystemSettingPanel sysSettingPanel: null
    property ScTabView mainView: null
    property ScCatalog catalog: null
    property ScNotify notify: null
    property ScLogPanel logPanel: null

    property string user: ''
    property string token: ''
    property string masterUrl: "http://127.0.0.1/sqlcarto"
    property string nodeUrl: ''

    property bool hasLogin: token.trim() !== ''

    // function hasLogin(){
    //     return ScApplication.token.trim() !== ''
    // }
}
