import 'package:audioplayers/audioplayers.dart';
import 'package:darq/darq.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/API/Interfaces/IQueueStrategy.dart';
import 'package:gibbon_music/API/MainMethod/GMethod.dart';
import 'package:gibbon_music/API/MainMethod/Player/BoundedQueue.dart';
import 'package:gibbon_music/API/MainMethod/Player/QueueStrategy.dart';
import 'package:gibbon_music/main.dart';
import 'package:gibbon_music/DesignWidget/Styles/ConstValue.dart';
import 'package:provider/provider.dart';

import '../../API/NotifyModels/GeneralNotifyModel.dart';

class AudioControl extends StatefulWidget {
  const AudioControl({Key key}) : super(key: key);

  @override
  State<AudioControl> createState() => _AudioControlState();
}

class _AudioControlState extends State<AudioControl> {
  IconData mainIcon = m.Icons.cabin;
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

  Map<IQueueStrategy, Icon> queueIcons = {};
  List<Tuple2<IQueueStrategy, IconData>> queueStrategies = <Tuple2<IQueueStrategy, IconData>>[
    Tuple2(QueueStrategy(), FluentIcons.repeat_one),
    Tuple2(BoundedQueueStrategy(), FluentIcons.repeat_all),
  ];

  int currentQueueStrategy = 0;

  int getNextStrategy() {
    currentQueueStrategy = currentQueueStrategy + 1;
    currentQueueStrategy %= queueStrategies.length;
    generalNotifyModel.queueStrategy = queueStrategies[currentQueueStrategy].item0;
    return currentQueueStrategy;
  }

  @override
  Widget build(BuildContext context) {
    bool canPrevious = context.watch<GeneralNotifyModel>().canPrevious();
    bool canNext = context.watch<GeneralNotifyModel>().canNext();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          IconButton(
              icon: const Icon(m.Icons.skip_previous_rounded, size: 28),
              onPressed: canPrevious
                  ? () {
                      player.previousAudio();
                    }
                  : null),
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
            onPressed: canNext
                ? () {
                    player.nextAudio();
                  }
                : null,
          ),
          IconButton(
              icon: Icon(queueStrategies[currentQueueStrategy].item1, size: 22),
              onPressed: () {
                getNextStrategy();
              }),
        ]),
        SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Row(
              children: [
                Text(timeTrack(position)),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Slider(
                    label: timeTrack(position),
                    value: position.toDouble(),
                    max: duration.toDouble(),
                    min: 0,
                    onChanged: (value) {
                      player.setSeek(value.toInt());
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(timeTrack(duration)),
              ],
            )),
      ],
    );
  }
}
