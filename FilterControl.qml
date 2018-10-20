import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

Item {
    id: item
    implicitWidth: rootLayout.implicitWidth
    implicitHeight: rootLayout.implicitHeight

    property alias filterType: filterCurve.type

    ColumnLayout{
        id: rootLayout

        Rectangle{
            implicitHeight: label.implicitHeight

            Layout.fillWidth: true;
            color: "blue"
            opacity: 0.7
            Text{id: label; text: item.filterType; anchors.centerIn: parent; color:"white"; font.bold: true}
        }
        FilterCurve {
            id: filterCurve
        }
        RowLayout {
            Text {text: "CutoffF"; Layout.preferredWidth: 60}
            Slider {
                Layout.alignment: Qt.AlignHCenter
                onPositionChanged: {
                    filterCurve.cutoffFreq = position * filterCurve.width;
                }
            }
        }
        RowLayout {
            Text {text: "Res"; Layout.preferredWidth: 60}
            Slider {
                Layout.alignment: Qt.AlignHCenter
                onPositionChanged: {
                    filterCurve.resonance = position * 100;
                }
            }
        }
        RowLayout {
            Text {text: "Zoom"; Layout.preferredWidth: 60}
            Slider {
                Layout.alignment: Qt.AlignHCenter
                onPositionChanged: {
                    filterCurve.zoomIn = position * filterCurve.width + 1;
                }
            }
        }
    }
}
