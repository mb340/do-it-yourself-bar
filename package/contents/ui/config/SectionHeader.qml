import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    spacing: 0

    property string text

    Item {
        height: 10
    }

    Label {
        font.pixelSize: theme.defaultFont.pixelSize + 4
        text: parent.text
    }

    Item {
        height: 1
    }
}
