import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

import org.kde.kirigami as Kirigami

Button {
    id: button
    enabled: false
    implicitWidth: 25
    implicitHeight: 20
    opacity: enabled ? 1 : 0.3

    property string color
    property var colorAcceptedCallback

    property Window colorDialog: undefined

    background: Rectangle {
        radius: 4
        border.width: 1
        color: button.color
        border.color: "gray"
    }

    onClicked: function() {
        if (!colorDialog) {
            colorDialog = colorDialogWindowComponent.createObject(button)
        }
    }

    // Work around broken ColorDialog with Qt 6
    // https://invent.kde.org/plasma/kdeplasma-addons/-/commit/797cef06882acdf4257d8c90b8768a74fdef0955
    // https://bugs.kde.org/show_bug.cgi?id=476509
    // https://bugreports.qt.io/browse/QTBUG-119055
    Component {
        id: colorDialogWindowComponent

        Window {
            id: colorDialogWindow
            width: Kirigami.Units.gridUnit * 19
            height: Kirigami.Units.gridUnit * 23
            visible: true

            modality: Qt.WindowModal

            ColorDialog {
                id: colorDialog
                title: colorDialogWindow.title
                visible: false
                options: ColorDialog.ShowAlphaChannel
                selectedColor: button.color

                onAccepted: {
                    button.color = colorDialog.selectedColor
                    colorAcceptedCallback(button.color);
                    colorDialogWindow.destroy()
                    button.colorDialog = undefined
                }
                onRejected: {
                    colorDialogWindow.destroy()
                    button.colorDialog = undefined
                }
            }
            onClosing: destroy()
            Component.onCompleted: colorDialog.open()
        }
    }

}
