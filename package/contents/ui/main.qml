import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import org.kde.kquickcontrolsaddons
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

import org.kde.plasma.doityourselfbar 1.0

import "applet"


PlasmoidItem {
    id: root

    BlockButtonTooltip { id: tooltip }

    fullRepresentation: Container {
        Component.onCompleted: {
            backend.cfg_DBusInstanceId = config.DBusInstanceId
            backend.cfg_StartupScriptPath = config.StartupScriptPath
        }
    }
    preferredRepresentation: root.fullRepresentation

    property QtObject config: plasmoid.configuration
    property Item container: root.fullRepresentationItem

    property bool isTopLocation: plasmoid.location == PlasmaCore.Types.TopEdge
    property bool isVerticalOrientation: plasmoid.formFactor == PlasmaCore.Types.Vertical

    DoItYourselfBar {
        id: backend

    }

    Connections {
        target: backend

        // Because plasmoid.nativeInterface is unavailable for this kind
        // of a plugin (must be a Plasma::Applet library or something),
        // a hack is needed to be able to detect the success in the config
        // dialog, so I use an additional config property and update it
        // with a value received from the C++ backend. This causes the config
        // dialog to read this property and show D-Bus service status.
        function onDbusSuccessChanged(dbusSuccess) {
            config.DBusSuccess = dbusSuccess
        }

        function onInvalidDataFormatDetected() {
            container.addErrorBlockButton()
        }

        function onBlockInfoListSent (blockInfoList) {
            container.update(blockInfoList)
        }
    }
}
