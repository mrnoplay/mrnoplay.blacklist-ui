import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.LocalStorage 2.0
import AddTransfer 1.0

Window {
    id: blocking
    visible: true
    width: 320
    height: 480
    title: qsTr("Mr Noplay Blacklist")

    AddTransfer {
        id: addtrans
    }

    property int way: 0;
    property var db;
    property var listnames: [];
    function initDatabase() {
        db = LocalStorage.openDatabaseSync("mrnoplay-blacklist", "1.0", "The Blacklist", 100000);
        db.transaction( function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS blacklist(name TEXT)');
            tx.executeSql('CREATE TABLE IF NOT EXISTS way(selection INTEGER)');
        });
    }
    function readData() {
        if(!db) { return; }
        db.transaction(function(tx) {
            var result = tx.executeSql('select * from blacklist');
            for(var i = 0; i < result.rows.length; i++) {
                listnames.push(result.rows[i].name);
            }
            var wayresult = tx.executeSql('select * from way');
            way = wayresult.rows[0].selection;
            addtrans.slot_openBlocking(way == 0 ? "black" : "white", listnames);
        });
    }

    Component.onCompleted: {
        initDatabase();
        readData();
    }

    Text {
        id: blockingtext
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
