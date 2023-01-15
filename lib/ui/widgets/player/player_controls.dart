import 'package:audioplayers/audioplayers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/extensions/duration.dart';
import 'package:gibbon_music/ui/controls/buttons.dart';
import 'package:flutter/material.dart' as m;
import 'package:provider/provider.dart';

import '../../../api/models/M_Track.dart';
import '../../../providers/audio_provider.dart';

class PlayerMainControl extends StatelessWidget {
  const PlayerMainControl({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;
    AudioProvider provider = context.watch();
    MTrack track = provider.playlist.currentTrack;

    double position = 0.0;

    return SizedBox(
      width: pageSize.width / 2.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GIconButton(onPressed: () {}, icon: m.Icons.loop_rounded, size: 24),
              AppConsts.defaultHSpacer,
              GIconButton(onPressed: () {}, icon: m.Icons.skip_previous_rounded, size: 24),
              AppConsts.defaultHSpacer,
              GIconButton(
                  onPressed: () {
                    if (provider.playerState == PlayerState.playing) {
                      provider.pause();
                    } else {
                      provider.resume();
                    }
                  },
                  icon: provider.icon(),
                  contrastBackground: true,
                  size: 26),
              AppConsts.defaultHSpacer,
              GIconButton(onPressed: () => provider.canNext(), icon: m.Icons.skip_next_rounded, size: 24),
              AppConsts.defaultHSpacer,
              GIconButton(onPressed: () {}, icon: m.Icons.shuffle, size: 24)
            ],
          ),
          AppConsts.smallVSpacer,
          StreamBuilder(
              stream: provider.onPositionChanged,
              initialData: const Duration(milliseconds: 0),
              builder: (context, snapshot) {
                Duration data = snapshot.data;
                position = data.inMilliseconds.toDouble();
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return Slider(
                      label: data.toHms(),
                      min: 0,
                      style: SliderThemeData(
                        labelBackgroundColor: FluentTheme.of(context).accentColor,
                        trackHeight: ButtonState.all(2),
                      ),
                      max: track.durationMs.toDouble(),
                      value: position,
                      onChanged: (value) {
                        provider.setSeek(value);
                      },
                    );
                  case ConnectionState.none:
                  case ConnectionState.done:
                  default:
                    print("NONE");
                    return Text("None");
                    break;
                }
              }),
        ],
      ),
    );
  }
}
