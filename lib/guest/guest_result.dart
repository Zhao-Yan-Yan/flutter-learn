import 'package:flutter/material.dart';

class GuestResult extends StatelessWidget {
  String title;
  Color color;
  AnimationController controller;

  GuestResult(
      {super.key,
      required this.title,
      required this.color,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            alignment: Alignment.center,
            color: color,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Text(
                  title,
                  style: TextStyle(
                      fontSize: 54 * (controller.value),
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                );
              },
            )));
  }
}
