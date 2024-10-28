import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts

import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM
import org.kde.plasma.core 2.0 as PlasmaCore

import "../common" as UICommon

KCM.SimpleKCM {
    // Animations
    property alias cfg_AnimationsEnable: animationsEnableCheckBox.checked

    // Block buttons
    property alias cfg_BlockButtonsVerticalMargin: blockButtonsVerticalMarginSpinBox.value
    property alias cfg_BlockButtonsHorizontalMargin: blockButtonsHorizontalMarginSpinBox.value
    property alias cfg_BlockButtonsSpacing: blockButtonsSpacingSpinBox.value
    property alias cfg_BlockButtonsSetCommonSizeForAll: blockButtonsSetCommonSizeForAllCheckBox.checked

    // Block labels
    property alias cfg_BlockLabelsMaximumLength: blockLabelsMaximumLengthSpinBox.value
    property string cfg_BlockLabelsCustomFont
    property int cfg_BlockLabelsCustomFontSize
    property string cfg_BlockLabelsCustomColorForStyleA
    property string cfg_BlockLabelsCustomColorForStyleB
    property string cfg_BlockLabelsCustomColorForStyleC

    // Block indicators
    property alias cfg_BlockIndicatorsStyle: blockIndicatorsStyleComboBox.currentIndex
    property alias cfg_BlockIndicatorsStyleBlockRadius: blockIndicatorsStyleBlockRadiusSpinBox.value
    property alias cfg_BlockIndicatorsInvertPosition: blockIndicatorsInvertPositionCheckBox.checked
    property string cfg_BlockIndicatorsCustomColorForStyleA
    property string cfg_BlockIndicatorsCustomColorForStyleB
    property string cfg_BlockIndicatorsCustomColorForStyleC

    Kirigami.FormLayout {
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Animations"
        }

        CheckBox {
            id: animationsEnableCheckBox
            Kirigami.FormData.label: "Enable animations"
        }

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Block buttons"
        }

        RowLayout {
            Kirigami.FormData.label: "Vertical margins:"

            SuffixSpinBox {
                id: blockButtonsVerticalMarginSpinBox

                value: cfg_BlockButtonsVerticalMargin
                from: 0
                to: 300
                suffix: "px"
            }
        }

        RowLayout {
            Kirigami.FormData.label: "Horizontal margins:"

            SuffixSpinBox {
                id: blockButtonsHorizontalMarginSpinBox

                value: cfg_BlockButtonsHorizontalMargin
                from: 0
                to: 300
                suffix: "px"
            }
        }

        RowLayout {
            Kirigami.FormData.label: "Spacing between buttons:"

            SuffixSpinBox {
                id: blockButtonsSpacingSpinBox
                value: cfg_BlockButtonsSpacing
                from: 0
                to: 100
                suffix: "px"
            }
        }

        RowLayout {
            spacing: 0

            CheckBox {
                id: blockButtonsSetCommonSizeForAllCheckBox
                text: "Set common size for all buttons"
            }

            HintIcon {
                tooltipText: "The size is based on the largest button"
            }
        }

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Block labels"
        }

        RowLayout {
            Kirigami.FormData.label: "Maximum length:"

            SuffixSpinBox {
                id: blockLabelsMaximumLengthSpinBox
                from: 3
                to: 100
                suffix: "chars"
            }
        }

        RowLayout {
            Kirigami.FormData.label: "Custom font:"
            spacing: 0

            CheckBox {
                id: blockLabelsCustomFontCheckBox
                checked: cfg_BlockLabelsCustomFont
                onCheckedChanged: {
                    if (!checked) {
                        cfg_BlockLabelsCustomFont = ""
                        cfg_BlockLabelsCustomFontSize = 0
                    }
                }
            }

            FontDialog {
                id: fontDialog
                visible: false
            }

            Button {
                icon.name: 'configure'
                enabled: blockLabelsCustomFontCheckBox.checked

                onClicked: {
                    fontDialog.selectedFont = Qt.font({
                        family: cfg_BlockLabelsCustomFont,
                        pointSize: cfg_BlockLabelsCustomFontSize
                    })
                    fontDialog.onAccepted.connect(onAccepted)
                    fontDialog.visible = true
                }

                function onAccepted() {
                    cfg_BlockLabelsCustomFont = fontDialog.selectedFont.family
                    cfg_BlockLabelsCustomFontSize = fontDialog.selectedFont.pointSize
                    fontDialog.visible = false
                    fontDialog.onAccepted.disconnect(onAccepted)
                }
            }

            Label {
                visible: cfg_BlockLabelsCustomFont
                text: cfg_BlockLabelsCustomFont + " " + cfg_BlockLabelsCustomFontSize
            }
        }

        RowLayout {
            Kirigami.FormData.label: "Custom text color for style A:"
            spacing: 0

            CheckBox {
                id: blockLabelsCustomColorForStyleACheckBox
                enabled: cfg_BlockIndicatorsStyle != 5
                checked: cfg_BlockLabelsCustomColorForStyleA
                onCheckedChanged: cfg_BlockLabelsCustomColorForStyleA = checked ?
                                  blockLabelsCustomColorForStyleAButton.color : ""
            }

            ColorButton {
                id: blockLabelsCustomColorForStyleAButton
                enabled: blockLabelsCustomColorForStyleACheckBox.checked
                color: cfg_BlockLabelsCustomColorForStyleA || Kirigami.Theme.textColor

                colorAcceptedCallback: function(color) {
                    cfg_BlockLabelsCustomColorForStyleA = color;
                }
            }

            Item {
                width: 8
            }

            HintIcon {
                visible: blockLabelsCustomColorForStyleACheckBox.checked ||
                         !blockLabelsCustomColorForStyleACheckBox.enabled
                tooltipText: cfg_BlockIndicatorsStyle != 5 ?
                             "Click the colored box to choose a different color" :
                             "Not available if labels are used as indicators"
            }
        }

        RowLayout {
            Kirigami.FormData.label: "Custom text color for style B:"
            spacing: 0

            CheckBox {
                id: blockLabelsCustomColorForStyleBCheckBox
                enabled: cfg_BlockIndicatorsStyle != 5
                checked: cfg_BlockLabelsCustomColorForStyleB
                onCheckedChanged: cfg_BlockLabelsCustomColorForStyleB = checked ?
                                  blockLabelsCustomColorForStyleBButton.color : ""
            }

            ColorButton {
                id: blockLabelsCustomColorForStyleBButton
                enabled: blockLabelsCustomColorForStyleBCheckBox.checked
                color: cfg_BlockLabelsCustomColorForStyleB || Kirigami.Theme.textColor

                colorAcceptedCallback: function(color) {
                    cfg_BlockLabelsCustomColorForStyleB = color;
                }
            }

            Item {
                width: 8
            }

            HintIcon {
                visible: blockLabelsCustomColorForStyleBCheckBox.checked ||
                         !blockLabelsCustomColorForStyleBCheckBox.enabled
                tooltipText: cfg_BlockIndicatorsStyle != 5 ?
                             "Click the colored box to choose a different color" :
                             "Not available if labels are used as indicators"
            }
        }

        RowLayout {
            Kirigami.FormData.label: "Custom text color for style C:"
            spacing: 0

            CheckBox {
                id: blockLabelsCustomColorForStyleCCheckBox
                enabled: cfg_BlockIndicatorsStyle != 5
                checked: cfg_BlockLabelsCustomColorForStyleC
                onCheckedChanged: cfg_BlockLabelsCustomColorForStyleC = checked ?
                                  blockLabelsCustomColorForStyleCButton.color : ""
            }

            ColorButton {
                id: blockLabelsCustomColorForStyleCButton
                enabled: blockLabelsCustomColorForStyleCCheckBox.checked
                color: cfg_BlockLabelsCustomColorForStyleC || Kirigami.Theme.textColor

                colorAcceptedCallback: function(color) {
                    cfg_BlockLabelsCustomColorForStyleC = color;
                }
            }

            Item {
                width: 8
            }

            HintIcon {
                visible: blockLabelsCustomColorForStyleCCheckBox.checked ||
                         !blockLabelsCustomColorForStyleCCheckBox.enabled
                tooltipText: cfg_BlockIndicatorsStyle != 5 ?
                             "Click the colored box to choose a different color" :
                             "Not available if labels are used as indicators"
            }
        }

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Block indicators"
        }

        RowLayout {
            Kirigami.FormData.label: "Style:"

            ComboBox {
                id: blockIndicatorsStyleComboBox
                implicitWidth: 100
                model: [
                    "Edge line",
                    "Side line",
                    "Block",
                    "Rounded",
                    "Full size",
                    "Use labels"
                ]

                onCurrentIndexChanged: {
                    if (cfg_BlockIndicatorsStyle == 2) {
                        cfg_BlockIndicatorsStyleBlockRadius = blockIndicatorsStyleBlockRadiusSpinBox.value;
                    } else {
                        cfg_BlockIndicatorsStyleBlockRadius = 2;
                    }
                }

                Component.onCompleted: {
                    if (cfg_BlockIndicatorsStyle != 2) {
                        cfg_BlockIndicatorsStyleBlockRadius = 2;
                    }
                }
            }

            SuffixSpinBox {
                id: blockIndicatorsStyleBlockRadiusSpinBox
                visible: cfg_BlockIndicatorsStyle == 2
                value: cfg_BlockIndicatorsStyleBlockRadius
                from: 0
                to: 300
                suffix: " px corner radius"
            }
        }

        RowLayout {
            Kirigami.FormData.label: "Invert indicator's position"
            spacing: 0

            CheckBox {
                id: blockIndicatorsInvertPositionCheckBox
                enabled: cfg_BlockIndicatorsStyle < 2
            }

            HintIcon {
                visible: !blockIndicatorsInvertPositionCheckBox.enabled
                tooltipText: "Not available for the selected indicator style"
            }
        }

        RowLayout {
            Kirigami.FormData.label: "Custom color for style A:"

            CheckBox {
                id: indicatorsCustomColorForStyleACheckBox
                checked: cfg_BlockIndicatorsCustomColorForStyleA
                onCheckedChanged: cfg_BlockIndicatorsCustomColorForStyleA = checked ?
                                  indicatorsCustomColorForStyleAButton.color : ""
            }

            ColorButton {
                id: indicatorsCustomColorForStyleAButton
                enabled: indicatorsCustomColorForStyleACheckBox.checked
                color: cfg_BlockIndicatorsCustomColorForStyleA || Kirigami.Theme.textColor

                colorAcceptedCallback: function(color) {
                    cfg_BlockIndicatorsCustomColorForStyleA = color;
                }
            }
        }

        RowLayout {
            Kirigami.FormData.label: "Custom color for style B:"

            CheckBox {
                id: indicatorsCustomColorForStyleBCheckBox
                checked: cfg_BlockIndicatorsCustomColorForStyleB
                onCheckedChanged: cfg_BlockIndicatorsCustomColorForStyleB = checked ?
                                  indicatorsCustomColorForStyleBButton.color : ""
            }

            ColorButton {
                id: indicatorsCustomColorForStyleBButton
                enabled: indicatorsCustomColorForStyleBCheckBox.checked
                color: cfg_BlockIndicatorsCustomColorForStyleB || Kirigami.Theme.highlightColor

                colorAcceptedCallback: function(color) {
                    cfg_BlockIndicatorsCustomColorForStyleB = color;
                }
            }
        }

        RowLayout {
            Kirigami.FormData.label: "Custom color for style C:"

            CheckBox {
                id: indicatorsCustomColorForStyleCCheckBox
                checked: cfg_BlockIndicatorsCustomColorForStyleC
                onCheckedChanged: cfg_BlockIndicatorsCustomColorForStyleC = checked ?
                                  indicatorsCustomColorForStyleCButton.color : ""
            }

            ColorButton {
                id: indicatorsCustomColorForStyleCButton
                enabled: indicatorsCustomColorForStyleCCheckBox.checked
                color: cfg_BlockIndicatorsCustomColorForStyleC || "#e34a4a"

                colorAcceptedCallback: function(color) {
                    cfg_BlockIndicatorsCustomColorForStyleC = color;
                }
            }
        }
    }
}
