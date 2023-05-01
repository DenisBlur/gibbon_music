import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:gibbon_music/updated_ui/controls/buttons.dart';
import 'package:gibbon_music/updated_ui/widgets/track_card.dart';
import 'package:provider/provider.dart';
import 'package:yam_api/track/track.dart';

import '../../constants/app_consts.dart';
import '../../providers/ux_provider.dart';

class UPlaylistWidget extends StatelessWidget {
  const UPlaylistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NewPlaylist>(
      builder: (context, playListProvider, child) {
        UxProvider uxProvider = context.watch();
        List<Track?>? tracks = playListProvider.tracksQueue;
        var theme = FluentTheme.of(context);
        var backgroundColor = theme.cardColor;
        final controller = ScrollController();
        return AnimatedPositioned(
          top: AppConsts.windowHeader,
          bottom: uxProvider.isFullscreen ? AppConsts.windowHeader : AppConsts.playerHeight,
          right: uxProvider.isOpenPlaylist ? uxProvider.isFullscreen ? 16 : 0 : uxProvider.isFullscreen ? -(AppConsts.pageSize(context).width-32) : -450,
          duration: AppConsts.defaultAnimation,
          curve: AppConsts.defaultCurve,
          child: Container(
            color: backgroundColor,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(uxProvider.isFullscreen ? 16 : 0),
              child: Column(
                children: [
                  if(uxProvider.isFullscreen) Center(child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GButton(onPressed: () {
                      uxProvider.isOpenPlaylist = false;
                    }, title: "CLOSE"),
                  )),
                  Expanded(child: Container(
                    width: uxProvider.isFullscreen ? AppConsts.pageSize(context).width-32 : 450,
                    padding: const EdgeInsets.all(8),
                    child: tracks.isNotEmpty
                        ? ImprovedScrolling(
                      scrollController: controller,
                      enableCustomMouseWheelScrolling: true,
                      customMouseWheelScrollConfig: const CustomMouseWheelScrollConfig(
                        scrollAmountMultiplier: AppConsts.scrollMultiplier,
                      ),
                      child: ReorderableListView.builder(
                        onReorder: (int oldIndex, int newIndex) {
                          playListProvider.reorder(oldIndex, newIndex < oldIndex ? newIndex : newIndex - 1);
                        },
                        itemBuilder: (context, index) {
                          return Padding(
                              key: ValueKey(index),
                              padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 32),
                              child: TrackCard(
                                track: tracks[index]!,
                                onPressed: () {
                                  playListProvider.currentTrackIndex = index;
                                },
                              ));
                        },
                        itemCount: tracks.length,
                        scrollController: controller,
                        physics: !context.watch<UxProvider>().smoothScroll ? const ScrollPhysics() : const NeverScrollableScrollPhysics(),
                      ),
                    )
                        : const Center(child: Text("Ничего нет :(")),
                  ),),
                ],
              ),
            ),
          )
        );
      },
    );
  }
}