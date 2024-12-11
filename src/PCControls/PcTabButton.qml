import QtQuick

PcButton {
    id: button

    signal closed();

    property bool closeable: true
    property int index: 0

    implicitWidth: 100

    rightIcon: button.closeable ? PcFontIcons.md_close : ''
    rightIconClickStandalone: true

    borderWidth: 1
    borderColor: PcColors.grey_5


    onRightIconClicked:{
        button.closed();
    }

}
