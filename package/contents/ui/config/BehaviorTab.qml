import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

import "../common" as UICommon

KCM.SimpleKCM {
    // D-Bus service
    property alias cfg_DBusInstanceId: dbusInstanceIdSpinBox.value

    // Startup script
    property string cfg_StartupScriptPath

    Kirigami.FormLayout {

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "D-Bus service"
        }

        RowLayout {
            Kirigami.FormData.label: "Instance ID:"

            SpinBox {
                id: dbusInstanceIdSpinBox
                from: 0
                to: 999
            }

            HintIcon {
                visible: cfg_DBusInstanceId == 0
                tooltipText: "The ID must be a NON-ZERO number"
            }
        }

        RowLayout {
            Kirigami.FormData.label: "D-Bus service status:"

            Label {
                text: plasmoid.configuration.DBusSuccess ? "OK" : "NOT OK"
                color: plasmoid.configuration.DBusSuccess ? "green" : "red"
            }

            HintIcon {
                tooltipText: {
                    if (plasmoid.configuration.DBusSuccess) {
                        return "You can now pass data to this applet instance"
                    }
                    return plasmoid.configuration.DBusInstanceId == 0 ?
                           "The ID must be a NON-ZERO number" :
                           "There might be a collision, try with a different ID number"
                }
            }
        }

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Startup script"
        }

        RowLayout {
            Kirigami.FormData.label: "Run this script at startup:"

            spacing: 0

            CheckBox {
                id: startupScriptPathCheckBox
                checked: cfg_StartupScriptPath
                onCheckedChanged: {
                    if (!checked) {
                        cfg_StartupScriptPath = "";
                    }
                }
            }

            UICommon.GrowingTextField {
                id: startupScriptPathTextField
                enabled: startupScriptPathCheckBox.checked
                text: cfg_StartupScriptPath || ""
                onTextChanged: cfg_StartupScriptPath = text
                onEditingFinished: cfg_StartupScriptPath = text
            }

            Item {
                width: 5
            }

            HintIcon {
                visible: startupScriptPathCheckBox.checked
                tooltipText: "Provide a FULL path to the script (no <tt>~</tt> or <tt>$HOME</tt>)<br><br>
                             An argument containing the ID will be passed to the script<br>
                             You can access it within the script by reading the <tt>$1</tt> variable"
            }
        }
    }
}
