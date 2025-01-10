pragma Singleton
import QtQuick
import QtCore

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
        "key": "",
        "password": ""
    }

    property var bing_api: {
        "key": ""
    }

    property var tianditu_api:{
        "key": ""
    }

    property var google_api:{
        "key": ""
    }



    property ScFileUtils fileUtils: ScFileUtils{}

    function loadConfiguration(){
        let configfilename = (StandardPaths.writableLocation(StandardPaths.AppConfigLocation)+"/scconfig.json").replace("file:///","");
        console.log(configfilename);
        var config;
        if(!fileUtils.exist(configfilename)){
            config = {
                "gaode_api":{
                    "key": "",
                    "password": ""
                },
                "bing_api":{
                    "key": ""
                },
                "tianditu_api":{
                    "key": ""
                },
                "google_api":{
                    "key": ""
                }
            }

            fileUtils.write(configfilename,JSON.stringify(config));
        }

        config = JSON.parse(fileUtils.read(configfilename));
        ScApplication.gaode_api = config.gaode_api
        ScApplication.bing_api = config.bing_api
        ScApplication.tianditu_api = config.tianditu_api
        ScApplication.google_api = config.google_api
    }
}
