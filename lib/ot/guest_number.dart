import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/ot/yan.dart';

class GuestNumberApp extends StatelessWidget {
  const GuestNumberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "猜数字 App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("猜数字 App"),
          backgroundColor: Colors.red[100],
        ),
        body: const GuestNumberBody(),
      ),
    );
  }
}

class GuestNumberBody extends StatefulWidget {
  const GuestNumberBody({super.key});

  @override
  State<GuestNumberBody> createState() => _GuestNumberBodyState();
}

class _GuestNumberBodyState extends State<GuestNumberBody> {
  int? answer;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              answer = Random().nextInt(100);
            });
          },
          child: const Text("点击生成随机数"),
        ),
        Text(answer == null ? "0" : "***"),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')) //设置只允许输入数字
          ],
          decoration:
          const InputDecoration.collapsed(hintText: "hintText", filled:
          true, floatingLabelBehavior:FloatingLabelBehavior.always,
            floatingLabelAlignment: FloatingLabelAlignment.start,enabled: true),
        ),
        TextButton(
            onPressed: () {
              var inputNumber = int.parse(controller.text);
              if (answer! > inputNumber) {
                showResultDialog("小了");
              } else if (answer! < inputNumber) {
                showResultDialog("大了");
              } else if (answer == inputNumber) {
                showResultDialog("猜对了");
              }
            },
            child: const Text("我猜")),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(CupertinoPageRoute(
                builder: (BuildContext context) {
                  return const YanApp();
                },
              ));
            },
            child: const Text("跳转测试"))
      ],
    );
  }

  void showResultDialog(String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("提示"),
            content: Text(text),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }
}
