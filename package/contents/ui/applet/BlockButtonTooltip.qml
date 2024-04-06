import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import org.kde.plasma.plasmoid 2.0

import "../common" as UICommon

UICommon.TextTooltip {
    target: null
    location: plasmoid.location

    onVisibleChanged: {
        if (!visible) {
            Qt.callLater(function() {
                content = "";
            });
        }
    }

    function show(blockButton) {
        visualParent = blockButton;
        content = blockButton.tooltipText;
        visible = true;
    }
}
