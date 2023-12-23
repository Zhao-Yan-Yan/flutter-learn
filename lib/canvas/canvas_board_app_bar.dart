import 'package:flutter/material.dart';

class CanvasBoardAppBar extends StatelessWidget implements PreferredSizeWidget {
  VoidCallback onClearClick;
  VoidCallback? onBackward;
  VoidCallback? onForward;

  CanvasBoardAppBar(
      {super.key,
      required this.onClearClick,
      required this.onBackward,
      required this.onForward});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("画板"),
      actions: [
        IconButton(
            splashRadius: 20,
            onPressed: onBackward,
            icon: const Icon(Icons.arrow_circle_left_outlined)),
        IconButton(
            splashRadius: 20,
            onPressed: onForward,
            icon: const Icon(Icons.arrow_circle_right_outlined)),
        IconButton(onPressed: onClearClick, icon: const Icon(Icons.delete)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
