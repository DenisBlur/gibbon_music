import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/domain/interfaces/iplaylist_loop_strategy.dart';
import 'package:gibbon_music/domain/models/loop_strategy/loop_strategies.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:gibbon_music/extensions/duration.dart';
import 'package:gibbon_music/providers/ux_provider.dart';
import 'package:provider/provider.dart';
import 'package:yam_api/track/track.dart';

import '../../../providers/audio_provider.dart';
import '../../../router.dart';
import '../../controls/buttons.dart';

class PlayerMainControl extends StatelessWidget {
  const PlayerMainControl({Key? key}) : super(key: key);

  IconData _getIconForLoop(IPlaylistLoopStrategy loopS) {
    if (loopS is OneTrackLoopStrategy) return m.Icons.repeat_one_on_rounded;
    if (loopS is PlaylistLoopStrategy) return m.Icons.repeat_on_rounded;
    if (loopS is NoLoopStrategy) return m.Icons.repeat_rounded;

    return m.Icons.repeat_rounded;
  }

  @override
  Widget build(BuildContext context) {
    AudioProvider provider = context.watch();
    NewPlaylist playList = context.watch();
    Track? track = playList.currentTrack;
    double position = 0.0;
    bool isFullscreen = context.watch<UxProvider>().isFullscreen;
    FlyoutController controller = FlyoutController();

    return Container(
      padding: EdgeInsets.all(isFullscreen ? 16 : 0),
      width: AppConsts.pageSize(context).width / (isFullscreen ? 1.5 : 2.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GIconButton(onPressed: () => playList.nextLoop(), icon: _getIconForLoop(playList.loopStrategy), size: Platform.isAndroid ? 36 : 24),
                  AppConsts.defaultHSpacer,
                  GIconButton(
                      onPressed: () {
                        playList.previousTrack();
                      },
                      icon: m.Icons.skip_previous_rounded,
                      size: Platform.isAndroid ? 36 : 24),
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
                      size: Platform.isAndroid ? 38 : 26),
                  AppConsts.defaultHSpacer,
                  GIconButton(
                      onPressed: () {
                        playList.nextTrack();
                      },
                      icon: m.Icons.skip_next_rounded,
                      size: Platform.isAndroid ? 36 : 24),
                  AppConsts.defaultHSpacer,
                  GIconButton(onPressed: () => playList.shuffle = !playList.shuffled, icon: m.Icons.shuffle, size: Platform.isAndroid ? 36 : 24),
                ],
              ),
              Row(
                children: [
                  if (isFullscreen) AppConsts.fillSpacer,
                  if (isFullscreen)
                    GIconButton(
                        onPressed: () {
                          context.read<UxProvider>().changePlaylistState();
                        },
                        icon: m.Icons.playlist_play_rounded,
                        size: 24),
                  if (isFullscreen) AppConsts.defaultHSpacer,
                  if (isFullscreen)
                    FlyoutTarget(
                      controller: controller,
                      child: GIconButton(
                          onPressed: () {
                            controller.showFlyout(
                                builder: (context) {
                                  return FlyoutContent(child: Consumer<UxProvider>(builder: (context, ux, child) {
                                    return Container(
                                      padding: const EdgeInsets.all(8),
                                      width: 100,
                                      height: 20,
                                      child: Slider(
                                        label: (ux.playerVolume * 100).toInt().toString(),
                                        min: 0,
                                        style: SliderThemeData(
                                          labelBackgroundColor: FluentTheme.of(context).accentColor,
                                          trackHeight: ButtonState.all(2),
                                        ),
                                        max: 1,
                                        value: ux.playerVolume,
                                        onChanged: (value) {
                                          provider.setVolume(value);
                                          ux.playerVolume = value;
                                        },
                                      ),
                                    );
                                  }));
                                },
                                dismissWithEsc: true,
                                barrierColor: Colors.black.withOpacity(0.01),
                                barrierDismissible: true);
                          },
                          icon: m.Icons.volume_up_rounded,
                          size: 24),
                    ),
                  if (isFullscreen) AppConsts.defaultHSpacer,
                  if (isFullscreen)
                    GIconButton(
                        onPressed: () {
                          AppRouter().closeFullscreen(context);
                        },
                        icon: m.Icons.close_fullscreen_rounded,
                        size: 24),
                ],
              )
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
                            value: position > track.durationMs!.toDouble() ? 0 : position,
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
