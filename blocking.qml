import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    id: notFromMr
    visible: true
    width: 320
    height: 480
    title: qsTr("Mr Noplay Blacklist")

    Text {
        id: onlyfrommr
        x: 0
        y: 233
        width: 320
        height: 15
        text: qsTr("App blocking is running now.")
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 12
    }

    Image {
        id: mrlogo
        x: 110
        y: 126
        width: 100
        height: 100
        fillMode: Image.PreserveAspectFit
        source: "assets/logo.png"
    }
}
