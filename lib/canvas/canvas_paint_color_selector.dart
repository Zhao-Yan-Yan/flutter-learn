import 'package:flutter/material.dart';

class PaintColorSelector extends StatelessWidget {
  PaintColorSelector(
      {super.key,
      required this.supportPaintColor,
      required this.activeIndex,
      required this.onChangePaintColor});

  List<Color> supportPaintColor;
  int activeIndex;
  void Function(int value) onChangePaintColor;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(supportPaintColor.length, _buildByIndex),
    );
  }

  Widget _buildByIndex(int index) {
    var isActive = index == activeIndex;
    return GestureDetector(
      onTap: () {
        onChangePaintColor(index);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.all(2),
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: isActive ? Border.all(color: Colors.blue) : null),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: supportPaintColor[index],
          ),
        ),
      ),
    );
  }
}
