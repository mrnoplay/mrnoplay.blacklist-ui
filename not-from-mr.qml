import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    id: notFromMr
    visible: true
    width: 320
    height: 480
    title: "Oops!"

    Text {
        id: onlyfrommr
        x: 35
        y: 233
        text: qsTr("This app can only be opened from Mr Noplay")
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
