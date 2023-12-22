import 'package:flutter/material.dart';
import 'package:my_app/fish/fish_type_ttem.dart';

import 'image_option.dart';

class FishPanel extends StatelessWidget {
  List<FishBean> options;
  final ValueChanged<int> onSelect;
  final int activeIndex;

  FishPanel({
    super.key,
    required this.options,
    required this.activeIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle labelStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    const EdgeInsets padding =
        EdgeInsets.symmetric(horizontal: 8.0, vertical: 16);
    return SizedBox(
        height: 340,
        child: Column(
          children: [
            Container(
                height: 46,
                alignment: Alignment.center,
                child: const Text("选择你的鱼", style: labelStyle)),
            Expanded(
                child: Padding(
              padding: padding,
              child: Row(
                children: [
                  Expanded(child: _buildByIndex(0)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildByIndex(1)),
                ],
              ),
            ))
          ],
        ));
  }

  Widget _buildByIndex(int index) {
    bool active = index == activeIndex;
    return GestureDetector(
      onTap: () => onSelect(index),
      child: FishTypeItem(
        option: options[index],
        active: active,
      ),
    );
  }
}
