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

        function log10Axes(fun, xAxisArgs) {
            var expXAxisArgs = [];
            for(var argOnXAxis in xAxisArgs){
                expXAxisArgs.push( Math.pow(10, argOnXAxis / filter.zoomIn) );
            }

            Math.log10 = Math.log10 || function(x) {
              return Math.log(x) * Math.LOG10E;
            };
            return Math.log10(fun.apply(this, expXAxisArgs)) * filter.zoomIn;
        }

        function fun(x) {
            var A = 1.0;

            var freq = Math.pow(10, x / filter.zoomIn);
            var cutoff = Math.pow(10, filter.cutoffFreq / filter.zoomIn);

            var amp = A / Math.sqrt(1 + ( (freq * freq) / (cutoff * cutoff) ));


            Math.log10 = Math.log10 || function(x) {
              return Math.log(x) * Math.LOG10E;
            };
            return Math.log10(amp) * filter.zoomIn + 100;
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
                ctx.lineTo(x, fun(x));
            }

            ctx.resetTransform();
            ctx.stroke()
        }
    }

}

