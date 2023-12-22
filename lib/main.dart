import 'package:flutter/material.dart';
import 'package:my_app/fish/fish_main.dart';
import 'package:my_app/guest/guest_main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter",
      home: const FishMain(),
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
