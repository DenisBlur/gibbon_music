import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/providers/ux_provider.dart';
import 'package:provider/provider.dart';
import '../../../providers/audio_provider.dart';
import '../../controls/buttons.dart';

class PlayerSecondControl extends StatelessWidget {
  const PlayerSecondControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;
    AudioProvider provider = context.watch();

    return SizedBox(
        width: pageSize.width,
        height: AppConsts.playerHeight,
        child: Consumer<UxProvider>(
          builder: (context, ux, child) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GIconButton(
                    onPressed: () {
                      context.read<UxProvider>().changePlaylistState();
                    },
                    icon: m.Icons.playlist_play_rounded,
                    size: 24),
                GIconButton(onPressed: () {}, icon: m.Icons.volume_up_rounded, size: 24),
                AppConsts.smallHSpacer,
                SizedBox(
                  width: 100,
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
                ),
                AppConsts.smallHSpacer,
                GIconButton(onPressed: () {}, icon: m.Icons.fullscreen, size: 24),
              ],
            );
          },
        ));
  }
}
