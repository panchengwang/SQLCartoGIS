import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
    id: systembar
    signal changeSettings()

    implicitHeight: PcStyles.header_implicit_height
    color: PcColors.grey_4

    RowLayout{
        anchors.fill: parent
        anchors.rightMargin: PcStyles.margin
        anchors.leftMargin: 2 * PcStyles.margin

        // PcAvatar{
        //     id: avatarSettings
        //     // image: PcFileHelper.getLocalFilePathOfResource("./images/pcwang.png")
        //     fontIcon: PcFontIcons.md_settings
        //     // iconColor: PcColors.grey_9
        //     border.width: 0
        //     onClicked:{
        //         systembar.changeSettings()
        //     }
        // }

        PcText{
            // Layout.fillWidth: true
            text: "Welcome to PCWang's GIS world !" //appWin.title
            font.pointSize: 13
            color: PcColors.grey_9
        }

        PcButton{
            leftIcon: PcFontIcons.md_settings
            text: "System"
        }
        PcButton{
            leftIcon: PcFontIcons.md_grid_view
            text: "View"
        }

        PcButton{
            leftIcon: PcFontIcons.md_newspaper
            text: "News"
        }

        PcButton{
            leftIcon: PcFontIcons.md_manage_accounts
            text: "Author"
        }

        // PcTextInput{

        // }


        Item{
            Layout.fillWidth: true
        }

        PcAvatar{
            id: userAvatar
            image: PcFileHelper.getLocalFilePathOfResource("./images/pcwang.png")
            fontIcon: PcFontIcons.md_account_circle
            onClicked:{
                if(!PcApplication.hasLogin()){
                    const loginPanel = Qt.createQmlObject(
                                         `
                                         import QtQuick
                                         import QtQuick.Controls
                                         import QtQuick.Layouts
                                         import cn.pc.controls

                                         PcLoginDialog{
                                         id: loginPanel
                                         visible: true
                                         modal: false
                                         minWidth: 300
                                         maxWidth: 600
                                         closePolicy: modal ? Popup.CloseOnEscape : Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
                                         }
                                         `,
                                         PcApplication.appWin.contentItem,
                                         "myDynamicSnippet"
                                         );
                    loginPanel.closed.connect(()=>{
                                                  loginPanel.destroy()
                                              } )
                }

            }
        }
    }
}
