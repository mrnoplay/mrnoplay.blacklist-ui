import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import AddTransfer 1.0

Window {
    id: add
    visible: true
    width: 246
    height: 100
    title: qsTr("Mr Noplay Blacklist")

    property string bundleId: "com.scrisstudio.exampleapp";

    AddTransfer {
        id: addtrans
        onSig_getFromTerminal: {
            bundleId = shellresult;
            main.toAddName = bundleId;
            add.close();
        }
    }

    Column {
        id: container
        y: 4
        width: 320
        height: 400
        anchors.top: parent.top
        anchors.topMargin: 4

        Row {
            id: titlebar
            y: 10
            width: 320
            height: 20

            Text {
                id: label02
                height: 20
                text: qsTr("Add an App")
                font.bold: true
                rightPadding: 4
                topPadding: 0
                leftPadding: 15
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 14
            }
        }

        Column {
            id: column
            width: 320
            height: 400
            anchors.top: parent.top
            anchors.topMargin: 35

            Button {
                id: submit
                objectName: "submit"
                x: 110
                width: 80
                height: 30
                text: qsTr("Submit")
                anchors.top: parent.top
                anchors.topMargin: 0
                onClicked: {
                    if(result.text.indexOf("Mr Noplay") != -1 || result.text.indexOf("mrnoplay") != -1) result.text = qsTr("Invalid.");
                    else addtrans.slot_getFromTerminal(result.text);
                }
            }

            FileDialog {
                id: filedialog
                title: "Please choose a file"
                folder: shortcuts.home
                onAccepted: {
                    result.text = filedialog.fileUrl;
                    result.text = result.text.slice(7);
                }
                visible: false
            }

            Button {
                id: choose
                x: 15
                width: 80
                height: 30
                text: qsTr("Choose")
                anchors.top: parent.top
                anchors.topMargin: 0
                onClicked: filedialog.visible = true;
            }

            Text {
                id: result
                width: 210
                height: 26
                elide: Text.ElideNone
                anchors.left: parent.left
                anchors.leftMargin: 15
                renderType: Text.QtRendering
                anchors.top: parent.top
                anchors.topMargin: 35
                visible: true
                font.bold: false
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 12
                rightPadding: 0
                topPadding: 0
                leftPadding: 0
            }
        }
    }

}

/*##^##
Designer {
    D{i:1;anchors_y:15}D{i:7;anchors_y:0}D{i:8;anchors_x:15}D{i:5;anchors_y:0}
}
##^##*/
