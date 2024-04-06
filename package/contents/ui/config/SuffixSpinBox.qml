import QtQuick
import QtQuick.Controls

SpinBox {

    required property string suffix

    textFromValue: function(value, locale) {
        return qsTr("%1 %2").arg(value).arg(suffix)
    }
    valueFromText: function(text) {
        let data = text.split(" ")
        if (data.length < 1) {
            return 0
        }
        return data[0]
    }
}
