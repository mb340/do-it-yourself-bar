import QtQuick
import QtQuick.Controls

import org.kde.kirigami as Kirigami
import org.kde.plasma.core 2.0 as PlasmaCore

PlasmaCore.Dialog {
    visualParent: target
    type: PlasmaCore.Dialog.Tooltip
    flags: Qt.WindowDoesNotAcceptFocus
    location: PlasmaCore.Types.LeftEdge

    property Item target
    property string content

    mainItem: Text {
        width: implicitWidth
        height: implicitHeight

        text: content
        textFormat: Text.RichText
        color: Kirigami.Theme.textColor
    }
}
