import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;

import 'AndAudioPlayer.dart';

class AudioSecondControl extends StatefulWidget {
  const AudioSecondControl({Key key}) : super(key: key);

  @override
  State<AudioSecondControl> createState() => _AudioSecondControlState();
}

class _AudioSecondControlState extends State<AudioSecondControl> {
  double volume = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(m.Icons.volume_up_rounded, size: 24),
          onPressed: () {},
        ),
        const SizedBox(
          width: 8,
        ),
        SizedBox(
          width: 100,
          child: Slider(
            min: 0,
            max: 1,
            value: volume,
            onChanged: (value) {
              setState(() {
                volume = value;
                player.setVolume(volume);
              });
            },
          ),
        )
      ],
    );
  }
}
