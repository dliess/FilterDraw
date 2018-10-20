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
    title: qsTr("Filter Types")

    GridLayout {
        id: rootLayout
        anchors.fill: parent
        columns: 5
        Layout.margins: 30

        FilterControl {
            filterType: "onePoleLowPassFilter"
        }
        FilterControl {
            filterType: "onePoleHighPassFilter"
        }
        FilterControl {
            filterType: "twoPoleLowPassFilter"
        }
        FilterControl {
            filterType: "twoPoleHighPassFilter"
        }
        FilterControl {
            filterType: "twoPoleBandPassFilter"
        }
    }
}
