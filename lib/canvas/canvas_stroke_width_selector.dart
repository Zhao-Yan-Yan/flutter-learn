import 'package:flutter/material.dart';

class StrokeWidthSelector extends StatelessWidget {
  StrokeWidthSelector(
      {super.key,
      required this.supportStrokeWidth,
      required this.activeIndex,
      required this.color,
      required this.onChangeStrokeWidth});

  List<double> supportStrokeWidth;
  int activeIndex;
  ValueChanged<int> onChangeStrokeWidth;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      children: List.generate(
          supportStrokeWidth.length, (index) => _buildByIndex(index)),
    );
  }

  Widget _buildByIndex(int index) {
    var isActive = index == activeIndex;
    return GestureDetector(
      onTap: () {
        onChangeStrokeWidth(index);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: isActive ? Border.all(color: Colors.blue) : null),
        child: Container(
          height: supportStrokeWidth[index],
          color: color,
          width: 100,
        ),
      ),
    );
  }
}
