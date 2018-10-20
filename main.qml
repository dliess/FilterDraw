import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Window {
    visible: true
    width: rootLayout.implicitWidth
    height: rootLayout.implicitHeight
    minimumWidth: rootLayout.Layout.minimumWidth
    minimumHeight: rootLayout.Layout.minimumHeight
    maximumWidth: width
    maximumHeight: rootLayout.Layout.maximumHeight
    title: qsTr("Hello World")

    ColumnLayout {
        id: rootLayout
        anchors.fill: parent

        CircularValueBar {
            id: circularValueBar
        }
        FilterCurve {
            id: filterCurve
        }

        RowLayout {
            Text {text: "Freq"}
            Slider {
                Layout.alignment: Qt.AlignHCenter
                onPositionChanged: {
                    circularValueBar.value = position * 100
                    filterCurve.cutoffFreq = position * filterCurve.width;
                }
            }
        }
        RowLayout {
            Text {text: "Zoom"}
            Slider {
                Layout.alignment: Qt.AlignHCenter
                onPositionChanged: {
                    filterCurve.zoomIn = position * filterCurve.width + 1;
                }
            }
        }
    }
}
