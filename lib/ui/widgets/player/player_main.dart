import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/ui/widgets/player/player_controls.dart';
import 'package:provider/provider.dart';

import 'player_info.dart';

class PlayerMain extends StatelessWidget {
  const PlayerMain({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(builder: (_, value, __) {
      if (value.playlist.tracks.isNotEmpty) {
        return FadeInUp(
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 25, sigmaX: 25),
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                height: AppConsts.playerHeight,
                color: FluentTheme.of(context).cardColor.withOpacity(.4),
                child: Stack(
                  children: const [
                    PlayerInfo(),
                    Align(
                      alignment: Alignment.center,
                      child: PlayerMainControl(),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
