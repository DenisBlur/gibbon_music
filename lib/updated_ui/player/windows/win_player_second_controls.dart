import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/main.dart';
import 'package:gibbon_music/providers/ux_provider.dart';
import 'package:gibbon_music/router.dart';
import 'package:provider/provider.dart';

import '../../../providers/audio_provider.dart';

class PlayerSecondControl extends StatelessWidget {
  const PlayerSecondControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;
    AudioProvider provider = context.watch();

    FlyoutController controller = FlyoutController();

    return SizedBox(
      width: pageSize.width,
      height: AppConsts.playerHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () async {
                provider.lyric = await client.getTrackLyric(provider.currentTrack!);
              },
              icon: const Icon(m.Icons.text_fields_rounded,
                  size: 24)),
          IconButton(
              onPressed: () {
                context.read<UxProvider>().changePlaylistState();
              },
              icon: const Icon(m.Icons.playlist_play_rounded,
                  size: 24)),
          AppConsts.smallHSpacer,
          FlyoutTarget(
            controller: controller,
            child: IconButton(
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
                icon: const Icon(m.Icons.volume_up_rounded,
                    size: 24)),
          ),
          AppConsts.smallHSpacer,
          IconButton(
              onPressed: () {
                AppRouter().openFullscreen(context);
              },
              icon: const Icon(m.Icons.fullscreen,
                  size: 24)),
        ],
      ),
    );
  }
}
