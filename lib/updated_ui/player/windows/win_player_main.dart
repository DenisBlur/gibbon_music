import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/updated_ui/player/windows/win_player_controls.dart';
import 'package:gibbon_music/updated_ui/player/windows/win_player_second_controls.dart';
import 'package:gibbon_music/updated_ui/utils/ui_utils.dart';
import 'package:provider/provider.dart';

import 'win_player_info.dart';

class PlayerMain extends StatelessWidget {
  const PlayerMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(builder: (_, value, __) {
      if (value.currentTrack != null) {
        return Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          width: AppConsts.pageSize(context).width,
          height: AppConsts.playerHeight,
          color: FluentTheme.of(context).cardColor,
          child: Stack(
            children: const [
              PlayerInfo(),
              Center(
                child: PlayerMainControl(),
              ),
              PlayerSecondControl(),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: AppConsts.slowAnimation, curve: AppConsts.defaultCurve)
            .moveY(begin: 150, end: 0, duration: AppConsts.defaultAnimation, curve: AppConsts.defaultCurve)
            .then()
            .shimmer(duration: 2500.ms, color: FluentTheme.of(context).accentColor.withOpacity(.2));
      } else {
        return const SizedBox();
      }
    });
  }
}
