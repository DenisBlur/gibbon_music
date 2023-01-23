import 'package:audioplayers/audioplayers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:gibbon_music/extensions/duration.dart';
import 'package:gibbon_music/providers/playlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:yam_api/track/track.dart';

import '../../../providers/audio_provider.dart';
import '../controls/buttons.dart';

class PlayerMainControl extends StatelessWidget {
  const PlayerMainControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioProvider provider = context.watch();
    NewPlaylist playList = context.watch();
    Track? track = playList.currentTrack;
    double position = 0.0;

    return SizedBox(
      width: AppConsts.pageSize(context).width / 2.5,
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
              GIconButton(
                  onPressed: () {
                    playList.previousTrack();
                  },
                  icon: m.Icons.skip_previous_rounded,
                  size: 24),
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
              GIconButton(
                  onPressed: () {
                    playList.nextTrack();
                  },
                  icon: m.Icons.skip_next_rounded,
                  size: 24),
              AppConsts.defaultHSpacer,
              GIconButton(onPressed: () =>  playList.shuffle = !playList.shuffled, icon: m.Icons.shuffle, size: 24)
            ],
          ),
          AppConsts.smallVSpacer,
          StreamBuilder(
              stream: provider.onPositionChanged,
              initialData: const Duration(milliseconds: 0),
              builder: (context, snapshot) {
                Duration? data = snapshot.data as Duration?;
                position = data!.inMilliseconds.toDouble();
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return Row(
                      children: [
                        Text(data.toHms()),
                        AppConsts.defaultHSpacer,
                        Expanded(
                          child: Slider(
                            label: data.toHms(),
                            min: 0,
                            style: SliderThemeData(
                              labelBackgroundColor: FluentTheme.of(context).accentColor,
                              trackHeight: ButtonState.all(2),
                            ),
                            max: track!.durationMs!.toDouble(),
                            value: position,
                            onChanged: (value) {
                              provider.setSeek(value);
                            },
                          ),
                        ),
                        AppConsts.defaultHSpacer,
                        Text(Duration(milliseconds: track.durationMs!.toInt()).toHms()),
                      ],
                    );
                  case ConnectionState.none:
                  case ConnectionState.done:
                  default:
                    return const Text("None");
                }
              }),
        ],
      ),
    );
  }
}
