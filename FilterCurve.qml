import QtQuick 2.0

Item {
    id: filter
    implicitWidth: 240
    implicitHeight: 240

    property real cutoffFreq: 20
    property real resonance: 0.0
    property real zoomIn: 50

    onCutoffFreqChanged: canvas.requestPaint()
    onResonanceChanged: canvas.requestPaint()
    onZoomInChanged: canvas.requestPaint()

    Canvas {
        id: canvas
        anchors.fill: parent
        antialiasing: true

        function log10Axes() {
            var theFunction;
            var args = [];
            for(var i = 0; i < arguments.length; ++i) {
                if(0 == i) {
                    theFunction = arguments[i];
                }
                else {
                    args.push(Math.pow(10, arguments[i] / filter.zoomIn));
                }
            }
            Math.log10 = Math.log10 || function(x) {
              return Math.log(x) * Math.LOG10E;
            };
            return Math.log10(theFunction.apply(this, args)) * filter.zoomIn; // expand array as function argument list
        }

        function onePoleFilterAmpTransfer(freq, cutoff) {
            var A = 1.0;
            return A / Math.sqrt(1 + ( (freq * freq) / (cutoff * cutoff) ));
        }

        onPaint: {
            var ctx = getContext("2d")
            ctx.setTransform(1, 0, 0, -1, 0, canvas.height);

            ctx.clearRect(0, 0, canvas.width, canvas.height);


            ctx.lineWidth = 2
            ctx.strokeStyle = "blue"

            ctx.fillStyle = "red"


            ctx.beginPath()
            ctx.moveTo(0,0)

            for (var x = 0; x < canvas.width; ++x){
                ctx.lineTo(x, log10Axes( onePoleFilterAmpTransfer, x, filter.cutoffFreq) + 100 );
            }

            ctx.resetTransform();
            ctx.stroke()
        }
    }

}

