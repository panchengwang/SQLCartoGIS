import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ScTabPanel {
    id: panel
    title: "Create account"
    icon: ScFontIcons.md_person_add
    closeable: true

    property string okButtonText: 'Create'
    Rectangle{

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.6 < 300 ? 300 : parent.width * 0.6
        anchors.margins: ScStyles.margin

        Flickable{
            id: flick
            anchors.fill: parent
            contentHeight: grid.height
            contentWidth: grid.width
            GridLayout{
                id: grid
                width: flick.width

                anchors.margins: ScStyles.margin

                columns: 1

                // ScText{
                //     Layout.columnSpan: 2
                //     text: '  '
                //     font.pointSize: 13
                // }

                ScText{
                    text: 'Username: '
                }

                ScTextField{
                    id: txtUsername
                    Layout.fillWidth: true
                    placeholderText: 'Username must be a valid email address: '
                    text: "wang_wang_lao@163.com"
                }

                ScText{
                    text: 'Password: '
                }

                ScTextField{
                    id: txtPassword
                    Layout.fillWidth: true
                    echoMode: TextField.Password
                    placeholderText: '8-16 characters, at least one uppercase letter, one lowercase letter, one number and one special character'
                    text: "123qwe@@"
                }

                ScText{
                    text: 'Input password again: '
                }

                ScTextField{
                    id: txtPassword2
                    Layout.fillWidth: true
                    echoMode: TextField.Password
                    placeholderText: 'Same as password above '
                    text: "123qwe@@"
                }

                ScText{
                    text: 'Verify code: '
                }

                RowLayout{
                    Layout.fillWidth: true

                    ScTextField{
                        id: txtVerifyCode
                        Layout.fillWidth: true
                    }
                    ScButton{
                        text: "Get verify code"
                        onClicked:{

                            if(!panel.checkUserName()){
                                return ;
                            }
                            if(connector.running){
                                return
                            }
                            connector.success = (response)=>{
                                ScApplication.notify.message = response.message
                                ScApplication.notify.open()
                            }
                            connector.failure = (response)=>{
                                ScApplication.notify.message = response.message
                                ScApplication.notify.open()
                                ScApplication.logPanel.appendLog(response.message)
                            }
                            connector.post({"request":JSON.stringify({
                                                                         "type": "USER_GET_VERIFY_CODE",
                                                                         "data": {
                                                                             "username": txtUsername.text.trim()
                                                                         }
                                                                     })})
                        }
                    }
                }


                Item{
                    Layout.preferredHeight: 10
                }

                ScOkCancelButtons{
                    okButtonText: panel.okButtonText
                    cancelButtonVisible: false
                    onOk:{
                        if(!panel.checkUserName()){
                            return;
                        }

                        if(!panel.checkPassword()){
                            return;
                        }

                        if(connector.running){
                            return
                        }

                        connector.success = (response)=>{
                            ScApplication.notify.message = response.message
                            ScApplication.notify.open()
                            panel.closed()
                        }
                        connector.failure = (response)=>{
                            ScApplication.notify.message = response.message
                            ScApplication.notify.open()
                            ScApplication.logPanel.appendLog(response.message)

                        }
                        var request = JSON.stringify({
                                                                     "type": "USER_CREATE",
                                                                     "data": {
                                                                         "username": txtUsername.text.trim(),
                                                                         "password": txtPassword.text.trim(),
                                                                         "verify_code": txtVerifyCode.text.trim()
                                                                     }
                                                                 });
                        console.log(request);
                        connector.post({"request": request})
                    }
                }
            }
        }
    }

    ScConnector{
        id: connector
    }

    function checkUserName(){
        const re = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/g;
        if(!txtUsername.text.trim().match(re)){
            ScApplication.notify.message = "Invalid email address";
            ScApplication.notify.open()
            return false;
        }
        return true
    }

    function checkPassword(){
        const re = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/g;
        if(!txtPassword.text.trim().match(re)){
            ScApplication.notify.message = "Invalid password. An valid password must include eight characters, at least one uppercase letter, one lowercase letter, one number and one special character";
            ScApplication.notify.open()
            return false;
        }
        if(txtPassword.text.trim() !== txtPassword2.text.trim()){
            ScApplication.notify.message = "The password does not match the re-typed password.";
            ScApplication.notify.open()
            return false;
        }
        if(txtVerifyCode.text.trim() === ''){
            ScApplication.notify.message = "Please input verify code.";
            ScApplication.notify.open()
            return false;
        }
        return true
    }
}
