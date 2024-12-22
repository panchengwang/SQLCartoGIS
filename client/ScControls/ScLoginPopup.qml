import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ScPopup {
    id: popup
    clip: true
    height: 130
    parent: Overlay.overlay
    ColumnLayout{
        id: column
        width: parent.width
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.margins: ScStyles.margin

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
                echoMode:TextInput.Password
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
            onCancel: popup.close()
            onOk: {
                ScApplication.token = 'asddsf';
                popup.close()
            }
        }

        // RowLayout{
        //     Layout.fillWidth : true

        //     ScButton{
        //         flat: true
        //         text: "Create Account"
        //     }
        //     Item{
        //         Layout.fillWidth:true
        //     }
        //     ScButton{
        //         flat: true
        //         text: "Forget password?"
        //     }

        // }

    }
}
