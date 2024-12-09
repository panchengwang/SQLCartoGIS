import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

PcDialog {
    id: dialog
    height: 200 //column.height + panel.topPadding + panel.bottomPadding + panel.background.width * 2
    title: "Welcome to pcwang's GIS world!"
    content: ColumnLayout{
        id: column
        anchors.fill: parent
        spacing: PcStyles.spacing
        GridLayout{
            Layout.fillWidth: true
            columns: 2
            rowSpacing: 10
            PcText{
                text: "Account"
            }

            PcTextField{
                Layout.fillWidth: true
            }

            PcText{
                text: "Password"
            }

            PcTextField{
                Layout.fillWidth: true
            }
        }

        PcSeperator{
            Layout.fillWidth: true
            height: 1
        }

        PcOkCancelButtons{
            Layout.fillWidth : true
            okButtonText: "Sign in"
            cancelButtonText: "Close"

            onCancel: dialog.close()

        }

        RowLayout{
            Layout.fillWidth : true

            PcButton{
                flat: true
                text: "Create Account"
            }
            Item{
                Layout.fillWidth:true
            }
            PcButton{
                flat: true
                text: "Forget password?"
            }

        }

    }

}
