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


    property var gaode_api:{
        "key": "d27242255dfd0152233a1023c4ea0ecb",
        "password": "99be80ec0f86d6dec388057d0133f8e2"
    }

    property var bing_api: {
        "key": "Aq6fXDMn4ZhWgOlk3IWUKC1EJnflPHuC1IRK38FDjuUSlQEOsm9DAKuLSZEaxIoQ"
    }

    property var tianditu_api:{
        "key": "2e1e0958d50f81774142f573f690f97d"
    }
}
