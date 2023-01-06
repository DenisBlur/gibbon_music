import 'package:audioplayers/audioplayers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/main.dart';

class MiniAudioControl extends StatefulWidget {
  const MiniAudioControl({Key key}) : super(key: key);

  @override
  State<MiniAudioControl> createState() => _MiniAudioControlState();
}

class _MiniAudioControlState extends State<MiniAudioControl> {
  IconData mainIcon = m.Icons.cabin;
  @override
  void initState() {
    super.initState();
    player.player.onPlayerStateChanged.listen((event) {
      setState(() {
        switch (event) {
          case PlayerState.paused:
            mainIcon = m.Icons.play_arrow_rounded;
            break;
          case PlayerState.playing:
            mainIcon = m.Icons.pause;
            break;
          case PlayerState.completed:
            mainIcon = m.Icons.play_arrow_rounded;
            break;
          case PlayerState.stopped:
            mainIcon = m.Icons.stop;
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(mainIcon, size: 28),
              onPressed: () {
                if (player.getState() == PlayerState.paused) {
                  player.playAudio();
                } else {
                  player.pauseAudio();
                }
              },
            ),
            IconButton(
              icon: const Icon(m.Icons.skip_next_rounded, size: 28),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
