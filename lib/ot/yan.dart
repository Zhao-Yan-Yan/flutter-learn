import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class YanApp extends StatelessWidget {
  const YanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Yan App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
        useMaterial3: true,
      ),
      home: const YanHome("HA"),
    );
  }
}

class YanHome extends StatefulWidget {
  const YanHome(String s, {super.key});

  @override
  State<YanHome> createState() => _YanHomeState();
}

class _YanHomeState extends State<YanHome> with TickerProviderStateMixin {
  var _cont = 0;
  var widgets = [];
  late AnimationController animatedContainer;

  @override
  void initState() {
    super.initState();
    fetchData().then((value) => {});
    animatedContainer =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yan Title"),
        backgroundColor: Colors.red[100],
      ),
      body: Column(
        children: <Widget>[
          const Text("点击+加号"),
          Text("当前是第 $_cont 次"),
          FadeTransition(opacity: animatedContainer, child: const Text("渐变动画")),
          Expanded(
              child: ListView.builder(
                  itemCount: widgets.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widgets[index]['title']),
                      ),
                      onTap: () {
                        print("点击了第 $index 个");
                      },
                    );
                  })),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          animatedContainer.forward();
          setState(() {
            _cont++;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> fetchData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    http.Response response = await http.get(url);
    setState(() {
      widgets = jsonDecode(response.body);
    });
  }
}