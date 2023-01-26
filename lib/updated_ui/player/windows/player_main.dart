import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/updated_ui/player/windows/player_controls.dart';
import 'package:gibbon_music/updated_ui/player/windows/player_second_controls.dart';
import 'package:gibbon_music/updated_ui/utils/ui_utils.dart';
import 'package:provider/provider.dart';

import 'player_info.dart';

class PlayerMain extends StatelessWidget {
  const PlayerMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(builder: (_, value, __) {
      if (value.currentTrack != null) {
        return FadeInUp(
          child: Container(
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
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
