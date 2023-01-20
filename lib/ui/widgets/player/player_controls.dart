import 'dart:io';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/extensions/duration.dart';
import 'package:gibbon_music/providers/playlist_provider.dart';
import 'package:gibbon_music/ui/controls/buttons.dart';
import 'package:flutter/material.dart' as m;
import 'package:provider/provider.dart';
import 'package:yam_api/track/track.dart';

import '../../../providers/audio_provider.dart';

class PlayerMainControl extends StatelessWidget {
  const PlayerMainControl({Key? key, this.animationCoef}) : super(key: key);

  final double? animationCoef;

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;
    AudioProvider provider = context.watch();
    PlayListProvider playList = context.watch();
    Track? track = playList.currentTrack;

    double position = 0.0;

    double? coef = animationCoef ?? 0;

    double y = lerpDouble(126, 0, coef)!.toDouble();

    return Transform.translate(offset: Offset(0, Platform.isAndroid ? y : 0), child: SizedBox(
      width: pageSize.width / (Platform.isWindows ? 2.5 : 1),
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
                    playList.previous();
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
                    playList.next();
                  },
                  icon: m.Icons.skip_next_rounded,
                  size: 24),
              AppConsts.defaultHSpacer,
              GIconButton(onPressed: () => playList.toggleShuffle(), icon: m.Icons.shuffle, size: 24)
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
                    break;
                }
              }),
        ],
      ),
    ),);
  }
}
