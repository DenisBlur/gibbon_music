import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
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

class PlayerMainControl extends StatelessWidget {
  const PlayerMainControl({Key? key}) : super(key: key);

  IconData _getIconForLoop(IPlaylistLoopStrategy loopS) {
    if (loopS is OneTrackLoopStrategy) return Icons.repeat_one_on_rounded;
    if (loopS is PlaylistLoopStrategy) return Icons.repeat_on_rounded;
    if (loopS is NoLoopStrategy) return Icons.repeat_rounded;

    return Icons.repeat_rounded;
  }

  @override
  Widget build(BuildContext context) {
    AudioProvider provider = context.watch();
    NewPlaylist playList = context.watch();
    Track? track = playList.currentTrack;
    double position = 0.0;
    bool isFullscreen = context.watch<UxProvider>().isFullscreen;

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
                  context.watch<NewPlaylist>().radio ? const SizedBox() : IconButton(onPressed: () => playList.nextLoop(), icon: Icon(_getIconForLoop(playList.loopStrategy), size: 24)),
                  AppConsts.defaultHSpacer,
                  IconButton(
                      onPressed: () {
                        playList.previousTrack();
                      },
                      icon: const Icon(Icons.skip_previous_rounded, size: 24)),
                  AppConsts.defaultHSpacer,
                  IconButton(
                      onPressed: () {
                        if (provider.playerState == PlayerState.playing) {
                          provider.pause();
                        } else {
                          provider.resume();
                        }
                      },
                      icon: Icon(
                        provider.icon(),
                        size: 26,
                      )),
                  AppConsts.defaultHSpacer,
                  IconButton(
                      onPressed: () {
                        playList.nextTrack();
                      },
                      icon: const Icon(Icons.skip_next_rounded, size: 24)),
                  AppConsts.defaultHSpacer,
                  context.watch<NewPlaylist>().radio ? const SizedBox() : IconButton(onPressed: () => playList.shuffle = !playList.shuffled, icon: const Icon(Icons.shuffle, size: 24)),
                ],
              ),
              Row(
                children: [
                  if (isFullscreen) AppConsts.fillSpacer,
                  if (isFullscreen)
                    IconButton(
                        onPressed: () {
                          context.read<UxProvider>().changePlaylistState();
                        },
                        icon: const Icon(Icons.playlist_play_rounded, size: 24)),
                  if (isFullscreen) AppConsts.defaultHSpacer,
                  if (isFullscreen)
                    IconButton(
                        onPressed: () {
                          AppRouter().closeFullscreen(context);
                        },
                        icon: const Icon(Icons.close_fullscreen_rounded, size: 24)),
                ],
              )
            ],
          ),
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
                          child: SizedBox(
                            child: Slider(
                              label: data.toHms(),
                              min: 0,
                              max: track!.durationMs!.toDouble(),
                              value: position > track.durationMs!.toDouble() ? 0 : position,
                              onChanged: (value) {
                                provider.setSeek(value);
                              },
                            ),
                            height: 16,
                          )
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
