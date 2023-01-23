import 'dart:io';
import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:gibbon_music/providers/playlist_provider.dart';
import 'package:gibbon_music/updated_ui/widgets/track_card.dart';
import 'package:provider/provider.dart';
import 'package:yam_api/track/track.dart';

import '../../constants/ui_consts.dart';
import '../../providers/ux_provider.dart';

class UPlaylistWidget extends StatelessWidget {
  const UPlaylistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UxProvider uxProvider = context.watch();
    NewPlaylist playListProvider = context.watch();

    List<Track?>? tracks = playListProvider.tracksQueue;

    var theme = FluentTheme.of(context);
    var backgroundColor = theme.cardColor.withOpacity(.65);
    final controller = ScrollController();

    return AnimatedPositioned(
      top: AppConsts.windowHeader,
      bottom: AppConsts.playerHeight,
      right: uxProvider.isOpenPlaylist ? 0 : -450,
      duration: AppConsts.defaultAnimation,
      curve: AppConsts.defaultCurve,
      child: ClipRRect(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: AnimatedContainer(
                width: 450,
                curve: AppConsts.defaultCurve,
                padding: const EdgeInsets.all(8),
                duration: AppConsts.defaultAnimation,
                decoration: BoxDecoration(
                  color: backgroundColor,
                ),
                child: ImprovedScrolling(
                  scrollController: controller,
                  enableCustomMouseWheelScrolling: true,
                  customMouseWheelScrollConfig: const CustomMouseWheelScrollConfig(
                    scrollAmountMultiplier: AppConsts.scrollMultiplier,
                  ),
                  child: ListView.builder(
                  controller: controller,
                  physics: Platform.isAndroid ? const ScrollPhysics() : const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TrackCard(
                      track: tracks[index]!,
                      onPressed: () => playListProvider.currentTrackIndex = index,
                    ),
                  ),
                  itemCount: tracks.length,
                ),
              ),
            )),
      ),
    );
  }
}
