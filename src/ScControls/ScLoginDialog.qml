import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ScDialog {
    id: dialog
    height: 210 //column.height + panel.topPadding + panel.bottomPadding + panel.background.width * 2
    title: "Welcome to pcwang's GIS world!"

    content: ColumnLayout{
        id: column
        anchors.fill: parent
        spacing: ScStyles.spacing
        GridLayout{
            Layout.fillWidth: true
            columns: 2
            rowSpacing: 10
            ScText{
                text: "Account"
            }

            ScTextField{
                Layout.fillWidth: true
            }

            ScText{
                text: "Password"
            }

            ScTextField{
                Layout.fillWidth: true
            }
        }

        ScSeperator{
            Layout.fillWidth: true
            height: 1
        }

        ScOkCancelButtons{
            Layout.fillWidth : true
            okButtonText: "Sign in"
            cancelButtonText: "Close"

            onCancel: dialog.close()

        }

        RowLayout{
            Layout.fillWidth : true

            ScButton{
                flat: true
                text: "Create Account"
            }
            Item{
                Layout.fillWidth:true
            }
            ScButton{
                flat: true
                text: "Forget password?"
            }

        }

    }

}
