import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_app/guest/guest_app_bar.dart';
import 'package:my_app/guest/guest_result.dart';

class GuestMainPage extends StatefulWidget {
  const GuestMainPage({super.key});

  @override
  State<GuestMainPage> createState() => _GuestMainPageState();
}

class _GuestMainPageState extends State<GuestMainPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  var _guessing = false;
  var _answer = 0;
  bool? _isBig;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GuestAppBar(
        controller: _controller,
        onSubmit: _guest,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_guessing) const Text("点击生成随机数值"),
                Text(
                  _guessing ? "**" : _answer.toString(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          _buildGuestResult()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateNumber,
        child: const Icon(Icons.account_balance_wallet_outlined),
      ),
    );
  }

  void _generateNumber() {
    var random = Random();
    setState(() {
      _answer = random.nextInt(100);
      _guessing = true;
    });
  }

  void _guest() {
    var inputNumber = int.parse(_controller.text);
    if (inputNumber > _answer) {
      setState(() {
        _isBig = true;
      });
    } else if (inputNumber < _answer) {
      setState(() {
        _isBig = false;
      });
    } else if (inputNumber == _answer) {
      setState(() {
        _guessing = false;
        _isBig = null;
      });
    }
    animationController.forward(from: 0);
    print("答案=${_answer} -- 输入=${_controller.text}");
  }

  _buildGuestResult() {
    if (_isBig != null) {
      return Column(
        children: [
          if (_isBig == true)
            GuestResult(
              title: "大了",
              color: Colors.lightBlue,
              controller: animationController,
            ),
          const Spacer(),
          if (_isBig == false)
            GuestResult(
              title: "小了",
              color: Colors.red,
              controller: animationController,
            )
        ],
      );
    } else {
      return const Spacer();
    }
  }
}
