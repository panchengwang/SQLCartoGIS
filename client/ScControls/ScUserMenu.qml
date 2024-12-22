import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ScPopup {
    id: userMenu

    signal signIn()
    signal signOut()
    signal createAccount()
    signal resetPassword()
    signal setAccountSettings()


    width: 250
    height: column.height + topPadding + bottomPadding
    y: parent.height + ScStyles.margin

    ColumnLayout{
        id: column
        width: parent.width
        spacing: 1
        ScButton{
            id: btnLogin
            leftIcon: ScFontIcons.md_login
            text: "Sign in"
            Layout.fillWidth: true
            textAlignment: Text.AlignLeft
            visible: !ScApplication.hasLogin
            onClicked: {
                userMenu.close()
                userMenu.signIn()
            }

        }

        ScButton{
            leftIcon: ScFontIcons.md_logout
            text: "Sign out"
            Layout.fillWidth: true
            textAlignment: Text.AlignLeft
            visible: ScApplication.hasLogin
            onClicked: {
                userMenu.close()
                userMenu.signOut()
                ScApplication.token = ''
                ScApplication.user = ''
            }
        }

        ScButton{
            leftIcon: ScFontIcons.md_person_add
            text: "Create Account"
            Layout.fillWidth: true
            textAlignment: Text.AlignLeft
            visible: !ScApplication.hasLogin
            property ScAccountPanel accountPanel: null
            onClicked: {
                userMenu.close()
                if(!accountPanel){
                    accountPanel = ScApplication.mainView.addQmlPanel("ScAccountPanel.qml")
                }
            }

        }

        ScButton{
            leftIcon: ScFontIcons.md_password
            text: "Reset password"
            Layout.fillWidth: true
            textAlignment: Text.AlignLeft
            visible: ScApplication.hasLogin
            onClicked: {
                userMenu.close()

            }
        }

        ScButton{
            leftIcon: ScFontIcons.md_password
            text: "Forget password"
            Layout.fillWidth: true
            textAlignment: Text.AlignLeft
            visible: !ScApplication.hasLogin
            onClicked: {
                userMenu.close()
                ScApplication.notify.type = 'error'
                ScApplication.notify.position = 'bottom'
                ScApplication.notify.message = 'This is forget password messageThis is forget password messageThis is forget password messageThis is forget password messageThis is forget password messageThis is forget password messageThis is forget password message '
                ScApplication.notify.open()
            }
        }


        ScButton{
            leftIcon: ScFontIcons.md_manage_accounts
            text: "Account Setting"
            Layout.fillWidth: true
            textAlignment: Text.AlignLeft
            onClicked: {
                userMenu.close()
                userMenu.setAccountSettings()
            }
            visible: ScApplication.hasLogin
        }



    }
}
