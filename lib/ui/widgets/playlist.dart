import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/providers/playlist_provider.dart';
import 'package:gibbon_music/ui/widgets/scroller_scaffold.dart';
import 'package:gibbon_music/ui/widgets/track_card.dart';
import 'package:provider/provider.dart';
import 'package:yam_api/track/track.dart';

import '../../constants/ui_consts.dart';
import '../../providers/ux_provider.dart';
import '../controls/buttons.dart';

class PlaylistWidget extends StatelessWidget {
  const PlaylistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UxProvider uxProvider = context.watch();
    AudioProvider audioProvider = context.watch();
    PlayListProvider playListProvider = context.watch();

    List<Track?> tracks = playListProvider.queue;

    double width = uxProvider.isOpenDrawer ? 450 : 60;

    var theme = FluentTheme.of(context);
    var backgroundColor = uxProvider.isOpenDrawer ? theme.cardColor.withOpacity(.65) : theme.scaffoldBackgroundColor;

    return AnimatedPadding(
      padding: const EdgeInsets.all(0),
      duration: AppConsts.defaultAnimation,
      curve: AppConsts.defaultCurve,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: AnimatedContainer(
              width: width,
              curve: AppConsts.defaultCurve,
              padding: const EdgeInsets.all(8),
              duration: AppConsts.defaultAnimation,
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              child: ListView.builder(
                itemBuilder: (context, index) => Padding(padding: const EdgeInsets.only(bottom: 8), child: TrackCard(
                  track: tracks[index]!,
                  onPressed: () => playListProvider.setCurrentTrack(index),
                ),),
                itemCount: tracks.length,
              ),
            )),
      ),
    );
  }
}
