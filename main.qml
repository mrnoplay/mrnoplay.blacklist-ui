import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.LocalStorage 2.0

Window {
    id: main
    visible: true
    width: 320
    height: 480
    title: qsTr("Mr Noplay Blacklist")

    property string toAddName: "appname.app";
    onToAddNameChanged: {
        listnames.append({name: toAddName})
        for (var i = 0; i <= listnames.count; i++) {
          if(listnames.get(i).name === toAddName) {
              listnames.remove(i);
          }
        }
        listnames.append({name: toAddName})
    }

    property var db;
    function initDatabase() {
        db = LocalStorage.openDatabaseSync("mrnoplay-blacklist", "1.0", "The Blacklist", 100000);
        db.transaction( function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS blacklist(name TEXT)');
        });
    }
    function readData() {
        if(!db) { return; }
        db.transaction(function(tx) {
            var result = tx.executeSql('select * from blacklist');
            for(var i = 0; i < result.rows.length; i++) {
                listnames.append({name: result.rows[i].name});
            }
        });
    }
    function storeData() {
        if(!db) { return; }
        db.transaction(function(tx) {
            tx.executeSql('DROP TABLE blacklist');
            tx.executeSql('CREATE TABLE IF NOT EXISTS blacklist(name TEXT)');
            for (var i = 0; i <= listnames.count; i++) {
              tx.executeSql("INSERT INTO blacklist VALUES ('" + listnames.get(i).name + "')");
            }
        });
    }

    Component.onCompleted: {
        initDatabase();
        readData();
    }
    Component.onDestruction: {
        storeData();
    }

    Column {
        id: container
        width: 320
        height: 400
        anchors.top: parent.top
        anchors.topMargin: 15

        Row {
            id: titlebar
            y: 10
            width: 320
            height: 20

            Text {
                id: label01
                height: 20
                text: qsTr("Only Selected Apps are: ")
                rightPadding: 4
                topPadding: 0
                leftPadding: 15
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 14
            }

            ComboBox {
                id: combo
                width: 100
                height: 20
                model: [qsTr("Forbidden"), qsTr("Allowed")]
            }
        }

        Column {
            id: listfather
            y: 60
            width: 320
            height: 380

            ListView {
                id: list
                width: 290
                height: 360
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 20
                model: ListModel {
                    id: listnames
                }
                delegate: Item {
                    x: 5
                    width: 290
                    height: 30
                    Row {
                        id: rowinlist

                        Text {
                            text: name
                            font.bold: true
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Button {
                            height: 20
                            width: 20

                            Image {
                                id: imgdelete
                                source: "assets/delete.png"
                                height: 12
                                width: 12
                                anchors.left: parent.left
                                anchors.leftMargin: 4
                                anchors.top: parent.top
                                anchors.topMargin: 4
                            }

                            onClicked: {
                                for (var i = 0; i <= listnames.count; i++) {
                                  if(listnames.get(i).name === name) {
                                      listnames.remove(i);
                                  }
                                }
                            }
                        }
                        spacing: 20
                    }
                }
            }
        }

        Row {
            id: addfather
            x: 15
            y: 400
            width: 290
            height: 60

            Button {
                id: add
                width: 110
                text: qsTr("Add an App")
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 15
                onClicked: {
                    var component = Qt.createComponent("add.qml");
                    component.createObject(add).show();
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:1;anchors_y:15}
}
##^##*/
