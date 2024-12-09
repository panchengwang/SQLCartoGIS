import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
    implicitHeight: PcStyles.header_implicit_height
    color: PcColors.indigo_5

    RowLayout{
        anchors.fill: parent
        anchors.rightMargin: PcStyles.margin
        anchors.leftMargin: 2 * PcStyles.margin

        PcAvatar{
            id: avatarSettings
            // image: PcFileHelper.getLocalFilePathOfResource("./images/pcwang.png")
            fontIcon: PcFontIcons.md_settings
            iconColor: PcColors.white
            border.width: 0
            onClicked:{
            }
        }

        // PcText{
        //     Layout.fillWidth: true
        //     text: appWin.title
        //     font.pointSize: 13
        //     color: PcColors.white
        // }

        Rectangle{
            id: searchRect
            radius: height * 0.5
            border.width: 1
            border.color: PcColors.grey_8
            Layout.fillHeight: true
            Layout.preferredWidth: 200
            Layout.margins: PcStyles.margin-2
            clip: true
            RowLayout{
                anchors.fill: parent
                PcAvatar{
                    fontIcon: PcFontIcons.md_search
                    iconColor: PcColors.grey_8
                    Layout.leftMargin: 3
                    Layout.preferredWidth: Layout.preferredHeight
                    Layout.preferredHeight: searchRect.height - 3
                    border.width: 0
                }

                PcTextField{
                    placeholderText:"Search"
                    borderWidth: 0
                    backgroundColor: "transparent"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.rightMargin: searchRect.height*0.5

                }
            }
        }


        Item{
            Layout.fillWidth: true
        }

        PcAvatar{
            id: userAvatar
            image: PcFileHelper.getLocalFilePathOfResource("./images/pcwang.png")
            fontIcon: PcFontIcons.md_account_circle
            onClicked:{
                if(!PcApplication.hasLogin()){
                    loginPanel.y = 120
                    loginPanel.open()
                }
            }
        }
    }
}
