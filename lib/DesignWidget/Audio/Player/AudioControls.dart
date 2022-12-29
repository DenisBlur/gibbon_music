import 'package:audioplayers/audioplayers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mIcon;
import 'package:gibbon_music/API/MainMethod/GMethod.dart';

import 'AudioPlayer.dart';

class AudioControl extends StatefulWidget {
  const AudioControl({Key key}) : super(key: key);

  @override
  State<AudioControl> createState() => _AudioControlState();
}

class _AudioControlState extends State<AudioControl> {
  IconData mainIcon = mIcon.Icons.cabin;
  int position = 0;
  int duration = 0;

  @override
  void initState() {
    super.initState();

    player.player.onPositionChanged.listen((event) {
      setState(() {
        position = event.inMilliseconds;
      });
    });

    player.player.onDurationChanged.listen((event) {
      setState(() {
        duration = event.inMilliseconds;
      });
    });

    player.player.onPlayerStateChanged.listen((event) {
      setState(() {
        switch (event) {
          case PlayerState.paused:
            mainIcon = mIcon.Icons.play_arrow_rounded;
            break;
          case PlayerState.playing:
            mainIcon = mIcon.Icons.pause;
            break;
          case PlayerState.completed:
            mainIcon = mIcon.Icons.play_arrow_rounded;
            break;
          case PlayerState.stopped:
            mainIcon = mIcon.Icons.stop;
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
              icon: const Icon(mIcon.Icons.skip_previous_rounded, size: 28),
              onPressed: () {},
            ),
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
              icon: const Icon(mIcon.Icons.skip_next_rounded, size: 28),
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Row(
            children: [
              Text(timeTrack(position)),
              const SizedBox(width: 16,),
              Expanded(child: Slider(
                label: timeTrack(position),
                value: position.toDouble(),
                max: duration.toDouble(),
                min: 0,
                onChanged: (value) {
                  player.setSeek(value.toInt());
                },
              ),),
              const SizedBox(width: 16,),
              Text(timeTrack(duration)),
            ],
          )
        ),
      ],
    );
  }
}
