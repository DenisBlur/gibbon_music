import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
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
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            height: 100,
            color: FluentTheme.of(context).cardColor,
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
        );
      } else {
        return Container(padding: const EdgeInsets.only(left: 16, right: 16), height: 100, color: FluentTheme.of(context).cardColor);
      }
    });
  }
}
