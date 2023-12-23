import 'package:flutter/material.dart';

import 'canvas/canvas_board_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter",
      home: CanvasBoardPage(),
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
