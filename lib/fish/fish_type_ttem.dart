import 'package:flutter/material.dart';
import 'package:my_app/fish/image_option.dart';

class FishTypeItem extends StatelessWidget {
  final FishBean option;
  final bool active;

  const FishTypeItem({super.key, required this.option, required this.active});

  @override
  Widget build(BuildContext context) {
    const Border activeBorder =
        Border.fromBorderSide(BorderSide(color: Colors.blue));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: !active ? null : activeBorder),
      child: Column(
        children: [
          Text(option.name,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset(option.src),
            ),
          ),
          Text('每次功德 +${option.min}~${option.max}',
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
