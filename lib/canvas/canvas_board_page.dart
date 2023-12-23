import 'package:flutter/material.dart';
import 'package:my_app/canvas/canvas_stroke_width_selector.dart';

import 'canvas_board_app_bar.dart';
import 'canvas_board_widget.dart';
import 'canvas_paint_color_selector.dart';
import 'line.dart';

class CanvasBoardPage extends StatefulWidget {
  CanvasBoardPage({super.key});

  @override
  State<CanvasBoardPage> createState() => _CanvasBoardPageState();
}

class _CanvasBoardPageState extends State<CanvasBoardPage> {
  List<Line> _lines = [];
  List<Line> _historyLines = [];

  final List<double> _supportStrokeWidth = [1, 2, 4, 8, 16];

  int _activeStrokeWidthIndex = 0;

  double get _activeStrokeWidth => _supportStrokeWidth[_activeStrokeWidthIndex];

  final List<Color> _supportPaintColor = [
    Colors.black,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  int _activePaintColorIndex = 0;

  Color get _activePaintColor => _supportPaintColor[_activePaintColorIndex];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CanvasBoardAppBar(
        onClearClick: onClearClick,
        onBackward: _lines.isEmpty ? null : _onBackwardClick,
        onForward: _historyLines.isEmpty ? null : _onForwardClick,
      ),
      body: Stack(
        children: [
          CanvasBoardWidget(
              lines: _lines,
              strokeWidth: _activeStrokeWidth,
              color: _activePaintColor),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StrokeWidthSelector(
                supportStrokeWidth: _supportStrokeWidth,
                activeIndex: _activeStrokeWidthIndex,
                onChangeStrokeWidth: _onChangeStrokeWidth,
                color: _activePaintColor,
              ),
              PaintColorSelector(
                  supportPaintColor: _supportPaintColor,
                  activeIndex: _activePaintColorIndex,
                  onChangePaintColor: _onChangePaintColor)
            ],
          )
        ],
      ),
    );
  }

  void onClearClick() {
    _lines.clear();
    setState(() {});
  }

  void _onChangeStrokeWidth(int value) {
    setState(() {
      _activeStrokeWidthIndex = value;
    });
  }

  void _onChangePaintColor(int value) {
    setState(() {
      _activePaintColorIndex = value;
    });
  }

  void _onForwardClick() {
    var lastLine = _historyLines.removeLast();
    _lines.add(lastLine);
    setState(() {});
  }

  void _onBackwardClick() {
    var lastLine = _lines.removeLast();
    _historyLines.add(lastLine);
    setState(() {});
  }
}
