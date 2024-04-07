import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts

import org.kde.kirigami as Kirigami
import org.kde.plasma.core 2.0 as PlasmaCore

import "../common" as UICommon

Item {
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

    GridLayout {
        columns: 1

        SectionHeader {
            text: "Animations"
        }

        CheckBox {
            id: animationsEnableCheckBox
            text: "Enable animations"
        }

        SectionHeader {
            text: "Block buttons"
        }

        RowLayout {
            Label {
                text: "Vertical margins:"
            }

            SuffixSpinBox {
                id: blockButtonsVerticalMarginSpinBox

                enabled: cfg_BlockIndicatorsStyle != 0 &&
                         cfg_BlockIndicatorsStyle != 4 &&
                         cfg_BlockIndicatorsStyle != 5

                value: cfg_BlockButtonsVerticalMargin
                from: 0
                to: 300
                suffix: "px"
            }

            HintIcon {
                visible: !blockButtonsVerticalMarginSpinBox.enabled
                tooltipText: "Not available for the selected indicator style"
            }
        }

        RowLayout {
            Label {
                text: "Horizontal margins:"
            }

            SuffixSpinBox {
                id: blockButtonsHorizontalMarginSpinBox
                enabled: cfg_BlockIndicatorsStyle != 5
                value: cfg_BlockButtonsHorizontalMargin
                from: 0
                to: 300
                suffix: "px"
            }

            HintIcon {
                visible: !blockButtonsHorizontalMarginSpinBox.enabled
                tooltipText: "Not available for the selected indicator style"
            }
        }

        RowLayout {
            Label {
                text: "Spacing between buttons:"
            }

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

        SectionHeader {
            text: "Block labels"
        }

        RowLayout {
            Label {
                text: "Maximum length:"
            }

            SuffixSpinBox {
                id: blockLabelsMaximumLengthSpinBox
                from: 3
                to: 100
                suffix: "chars"
            }
        }

        RowLayout {
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
                text: "Custom font:"
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
            spacing: 0

            CheckBox {
                id: blockLabelsCustomColorForStyleACheckBox
                enabled: cfg_BlockIndicatorsStyle != 5
                checked: cfg_BlockLabelsCustomColorForStyleA
                onCheckedChanged: cfg_BlockLabelsCustomColorForStyleA = checked ?
                                  blockLabelsCustomColorForStyleAButton.color : ""
                text: "Custom text color for style A:"
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
            spacing: 0

            CheckBox {
                id: blockLabelsCustomColorForStyleBCheckBox
                enabled: cfg_BlockIndicatorsStyle != 5
                checked: cfg_BlockLabelsCustomColorForStyleB
                onCheckedChanged: cfg_BlockLabelsCustomColorForStyleB = checked ?
                                  blockLabelsCustomColorForStyleBButton.color : ""
                text: "Custom text color for style B:"
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
            spacing: 0

            CheckBox {
                id: blockLabelsCustomColorForStyleCCheckBox
                enabled: cfg_BlockIndicatorsStyle != 5
                checked: cfg_BlockLabelsCustomColorForStyleC
                onCheckedChanged: cfg_BlockLabelsCustomColorForStyleC = checked ?
                                  blockLabelsCustomColorForStyleCButton.color : ""
                text: "Custom text color for style C:"
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

        SectionHeader {
            text: "Block indicators"
        }

        RowLayout {
            Label {
                text: "Style:"
            }

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
            spacing: 0

            CheckBox {
                id: blockIndicatorsInvertPositionCheckBox
                enabled: cfg_BlockIndicatorsStyle < 2
                text: "Invert indicator's position"
            }

            HintIcon {
                visible: !blockIndicatorsInvertPositionCheckBox.enabled
                tooltipText: "Not available for the selected indicator style"
            }
        }

        RowLayout {
            CheckBox {
                id: indicatorsCustomColorForStyleACheckBox
                checked: cfg_BlockIndicatorsCustomColorForStyleA
                onCheckedChanged: cfg_BlockIndicatorsCustomColorForStyleA = checked ?
                                  indicatorsCustomColorForStyleAButton.color : ""
                text: "Custom color for style A:"
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
            CheckBox {
                id: indicatorsCustomColorForStyleBCheckBox
                checked: cfg_BlockIndicatorsCustomColorForStyleB
                onCheckedChanged: cfg_BlockIndicatorsCustomColorForStyleB = checked ?
                                  indicatorsCustomColorForStyleBButton.color : ""
                text: "Custom color for style B:"
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
            CheckBox {
                id: indicatorsCustomColorForStyleCCheckBox
                checked: cfg_BlockIndicatorsCustomColorForStyleC
                onCheckedChanged: cfg_BlockIndicatorsCustomColorForStyleC = checked ?
                                  indicatorsCustomColorForStyleCButton.color : ""
                text: "Custom color for style C:"
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
