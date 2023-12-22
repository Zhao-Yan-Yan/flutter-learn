import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class FishSoundItem extends StatelessWidget {
  final List<AudioOption> audioOptions;
  final ValueChanged<int> onSelect;
  final int activeIndex;

  const FishSoundItem(
      {super.key,
      required this.audioOptions,
      required this.activeIndex,
      required this.onSelect});

  @override
  Widget build(BuildContext context) {
    const TextStyle labelStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            height: 46,
            alignment: Alignment.center,
            child: const Text(
              "选择音效",
              style: labelStyle,
            )),
        ...List.generate(audioOptions.length, _buildByIndex)
      ],
    );
  }

  Widget _buildByIndex(int index) {
    bool active = index == activeIndex;
    return ListTile(
      selected: active,
      onTap: () => onSelect(index),
      title: Text(audioOptions[index].name),
      trailing: IconButton(
        splashRadius: 20,
        onPressed: () => _tempPlay(audioOptions[index].src),
        icon: const Icon(
          Icons.record_voice_over_rounded,
          color: Colors.blue,
        ),
      ),
    );
  }

  void _tempPlay(String src) async {
    AudioPool pool = await FlameAudio.createPool(src, maxPlayers: 1);
    pool.start();
  }
}

class AudioOption {
  final String name;
  final String src;

  const AudioOption(this.name, this.src);
}
