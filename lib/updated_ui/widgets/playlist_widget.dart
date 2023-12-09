import 'package:flutter/material.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
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
        final controller = ScrollController();
        return AnimatedPositioned(
            top: uxProvider.isOpenPlaylist ? AppConsts.playerHeight : AppConsts.pageSize(context).height,
            bottom: AppConsts.playerHeight,
            right: 0,
            duration: AppConsts.defaultAnimation,
            curve: AppConsts.defaultCurve,
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer, borderRadius: BorderRadius.circular(16), boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(.5), offset: Offset(0,4), blurRadius: 10)
              ]),
              margin: EdgeInsets.only(right: 16, bottom: 32, top: AppConsts.pageSize(context).height / 4),
              child: Column(
                children: [
                  if (uxProvider.isFullscreen)
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: FilledButton(
                          onPressed: () {
                            uxProvider.isOpenPlaylist = false;
                          },
                          child: const Text("CLOSE")),
                    )),
                  Expanded(
                    child: Container(
                      width: uxProvider.isFullscreen ? AppConsts.pageSize(context).width - 32 : 450,
                      padding: const EdgeInsets.all(8),
                      child: tracks.isNotEmpty
                          ? ReorderableListView.builder(
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
                            )
                          : const Center(child: Text("Ничего нет :(")),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
