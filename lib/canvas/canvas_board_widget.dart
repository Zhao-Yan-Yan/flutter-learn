import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_app/canvas/line.dart';

class CanvasBoardWidget extends StatefulWidget {
  List<Line> lines;

  double strokeWidth;

  Color color;

  CanvasBoardWidget(
      {super.key,
      required this.lines,
      required this.strokeWidth,
      required this.color});

  @override
  State<CanvasBoardWidget> createState() => _CanvasBoardWidgetState();
}

class _CanvasBoardWidgetState extends State<CanvasBoardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      child: CustomPaint(
        painter: CanvasPainter(lines: widget.lines),
        child: ConstrainedBox(constraints: const BoxConstraints.expand()),
      ),
    );
  }

  void _onPanStart(DragStartDetails details) {
    widget.lines.add(Line(
        points: [details.localPosition],
        color: widget.color,
        strokeWidth: widget.strokeWidth));
  }

  void _onPanUpdate(DragUpdateDetails details) {
    widget.lines.last.points.add(details.localPosition);
    setState(() {});
  }
}

class CanvasPainter extends CustomPainter {
  CanvasPainter({required this.lines}) {
    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  List<Line> lines;
  late Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    for (var line in lines) {
      drawLine(canvas, line);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void drawLine(Canvas canvas, Line line) {
    _paint.color = line.color;
    _paint.strokeWidth = line.strokeWidth;
    canvas.drawPoints(PointMode.polygon, line.points, _paint);
  }
}
