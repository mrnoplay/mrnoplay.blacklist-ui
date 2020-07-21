import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Window {
    id: add
    visible: true
    width: 246
    height: 100
    title: qsTr("Mr Noplay Blacklist")

    Column {
        id: container
        y: 10
        width: 320
        height: 400
        anchors.top: parent.top
        anchors.topMargin: 10

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
                x: 160
                text: qsTr("Submit")
                anchors.top: parent.top
                anchors.topMargin: 0
                onClicked: {
                    if(textField.text.indexOf(" ") == -1 && textField.text.indexOf("'") == -1 && textField.text != ''){
                        main.toAddName = textField.text;
                        add.close();
                    } else {
                        illegalinput.visible = true;
                    }
                }
            }

            TextField {
                id: textField
                x: 15
                width: 140
                height: 26
                placeholderText: qsTr("Enter the Name Here")
            }
        }

        Text {
            id: illegalinput
            color: "#e31c1c"
            text: qsTr("Only supports letters and dots.")
            visible: false
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.top: parent.top
            anchors.topMargin: 64
            font.pixelSize: 12
        }
    }

}

/*##^##
Designer {
    D{i:5;anchors_y:0}D{i:1;anchors_y:15}
}
##^##*/
