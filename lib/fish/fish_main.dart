import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:my_app/fish/bless_animate.dart';
import 'package:my_app/fish/fish.dart';
import 'package:my_app/fish/fish_panel.dart';
import 'package:my_app/fish/image_option.dart';

import 'fish_sound.dart';

class FishMain extends StatefulWidget {
  const FishMain({super.key});

  @override
  State<FishMain> createState() => _FishMainState();
}

class _FishMainState extends State<FishMain> {
  var _blessCount = 0;
  var _currentBlessCount = 1;
  AudioPool? pool;
  var random = Random();
  var _activeIndex = 0;
  final List<FishBean> imageOptions = const [
    FishBean('基础版', 'assets/images/muyu.png', 1, 3),
    FishBean('尊享版', 'assets/images/muyu2.png', 3, 6),
  ];
  final List<AudioOption> audioOptions = const [
    AudioOption('音效1', 'muyu_1.mp3'),
    AudioOption('音效2', 'muyu_2.mp3'),
    AudioOption('音效3', 'muyu_3.mp3'),
  ];

  int _activeAudioIndex = 0;

  String get activeFishImage => imageOptions[_activeIndex].src;

  String get activeAudio => audioOptions[_activeAudioIndex].src;

  @override
  void initState() {
    super.initState();
    _initAudioPool();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("赛博木鱼"),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      body: Column(
        children: [
          Expanded(child: _buildCountContent()),
          Expanded(child: _buildFish()),
        ],
      ),
    );
  }

  _buildCountContent() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Text(
            "🙏🏻🙏🏻🙏🏻 功德数 $_blessCount 🙏🏻🙏🏻🙏🏻",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
            right: 10,
            top: 10,
            child: Wrap(
              spacing: 8,
              direction: Axis.vertical,
              children: [
                IconButton(
                  onPressed: onSwitchAudio,
                  icon: const Icon(Icons.music_note_outlined),
                ),
                IconButton(
                  onPressed: onSwitchFish,
                  icon: const Icon(Icons.image),
                )
              ],
            )),
      ],
    );
  }

  _buildFish() {
    var fish = imageOptions[_activeIndex];
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        FishAssetsImage(
          image: fish.src,
          onTap: () {
            pool?.start();
            setState(() {
              int min = fish.min;
              int max = fish.max;
              _currentBlessCount = min + random.nextInt(max + 1 - min);
              _blessCount += _currentBlessCount;
            });
          },
        ),
        BlessAnimateText(
          text: "🙏🏻功德+$_currentBlessCount 🙏🏻\ngod bless you",
        )
      ],
    );
  }

  onSwitchAudio() {
    showSheet(
        context,
        FishSoundItem(
          audioOptions: audioOptions,
          activeIndex: _activeAudioIndex,
          onSelect: _onAudioSelected,
        ));
  }

  onSwitchFish() {
    showSheet(
        context,
        FishPanel(
          options: imageOptions,
          activeIndex: _activeIndex,
          onSelect: _onFishSelected,
        ));
  }

  _onFishSelected(int index) {
    setState(() {
      Navigator.of(context).pop();
      _activeIndex = index;
    });
  }

  _onAudioSelected(int index) async {
    Navigator.of(context).pop();
    _activeAudioIndex = index;

    pool = await FlameAudio.createPool(
      activeAudio,
      maxPlayers: 1,
    );
  }

  _initAudioPool() async {
    pool = await FlameAudio.createPool(
      activeAudio,
      maxPlayers: 1,
    );
  }

  Future<T?> showSheet<T>(
    BuildContext context,
    Widget body, {
    bool scrollControlled = false,
    Color bodyColor = Colors.white,
    EdgeInsets? bodyPadding,
    BorderRadius? borderRadius,
  }) {
    const radius = Radius.circular(16);
    borderRadius ??= const BorderRadius.only(topLeft: radius, topRight: radius);
    bodyPadding ??= const EdgeInsets.all(20);
    return showModalBottomSheet(
        context: context,
        elevation: 0,
        backgroundColor: bodyColor,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        barrierColor: Colors.black.withOpacity(0.25),
        // A处
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewPadding.top),
        isScrollControlled: scrollControlled,
        builder: (ctx) => Padding(
              padding: EdgeInsets.only(
                left: bodyPadding!.left,
                top: bodyPadding.top,
                right: bodyPadding.right,
                // B处
                bottom:
                    bodyPadding.bottom + MediaQuery.of(ctx).viewPadding.bottom,
              ),
              child: body,
            ));
  }
}
