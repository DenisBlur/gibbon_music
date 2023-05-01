import 'package:audioplayers/audioplayers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/updated_ui/widgets/Image_thumbnail.dart';
import 'package:gibbon_music/updated_ui/widgets/track_card.dart';
import 'package:provider/provider.dart';
import 'package:yam_api/track/track.dart';

import '../../../constants/app_consts.dart';
import '../../../domain/models/playlist.dart';
import '../../../providers/audio_provider.dart';
import '../../../providers/ux_provider.dart';
import '../../controls/buttons.dart';
import '../../widgets/playlist_widget.dart';
import '../windows/win_player_controls.dart';

class AndPlayerInfo extends StatelessWidget {
  const AndPlayerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioProvider provider = context.watch();
    if (provider.currentTrack != null) {
      Size phoneSize = MediaQuery.of(context).size;

      if (phoneSize.width > phoneSize.height) {
        return const TabledPlayerInfo();
      } else {
        return const PhonePlayerInfo();
      }
    } else {
      return const SizedBox();
    }
  }
}

class TabledPlayerInfo extends StatelessWidget {
  const TabledPlayerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewPlaylist playList = context.watch();
    Track? track = playList.currentTrack;
    return SizedBox(
      width: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<NewPlaylist>(builder: (context, playListProvider, child) {
            List<Track?>? tracks = playListProvider.tracksQueue;
            return Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration:
                    BoxDecoration(color: FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(.5), borderRadius: BorderRadius.circular(16)),
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
                      )
                    : const Center(child: Text("Ничего нет :(")),
              ),
            );
          }),
          AppConsts.smallVSpacer,
          ImageThumbnail(
            url: track!.ogImage!.linkImage(200),
            width: 156,
            height: 156,
          ),
          AppConsts.smallVSpacer,
          Text(
            track.title!,
            style: AppStyle.trackHeaderStyle,
          ),
          ArtistsListWidgets(track: track),
          AppConsts.smallVSpacer,
          const Padding(
            padding: EdgeInsets.all(32),
            child: PlayerMainControl(),
          )
        ],
      ),
    );
  }
}

class PhonePlayerInfo extends StatelessWidget {
  const PhonePlayerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConsts.pageSize(context).width,
      height: 56,
    );
  }
}
