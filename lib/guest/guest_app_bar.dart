import 'package:flutter/material.dart';

class GuestAppBar extends StatelessWidget implements PreferredSizeWidget {
  TextEditingController controller;
  VoidCallback onSubmit;

  GuestAppBar({super.key, required this.controller, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(Icons.menu),
      titleSpacing: 0,
      title: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        onSubmitted: (_) {
          onSubmit();
        },
        decoration: const InputDecoration(
            filled: true,
            fillColor: Color(0xffF3F6F9),
            border: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(6))),
            hintText: "请输入 0 - 99 的数字",
            hintStyle: TextStyle(fontSize: 14)),
      ),
      actions: [
        IconButton(
            onPressed: onSubmit,
            splashRadius: 20,
            icon: const Icon(Icons.ac_unit))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
