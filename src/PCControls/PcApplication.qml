pragma Singleton
import QtQuick

QtObject
{

    property PcApplicationWindow appWin: null

    property string user: ''
    property string token: ''


    function hasLogin(){
        return PcApplication.token.trim() !== ''
    }
}
