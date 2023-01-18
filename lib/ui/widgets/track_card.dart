import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/extensions/duration.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/providers/playlist_provider.dart';
import 'package:gibbon_music/router.dart';
import 'package:gibbon_music/ui/controls/buttons.dart';
import 'package:gibbon_music/ui/other/music_visualizer.dart';
import 'package:gibbon_music/ui/widgets/ImageThumbnail.dart';
import 'package:gibbon_music/ui/widgets/card_view.dart';
import 'package:gibbon_music/ui/widgets/context_menu.dart';
import 'package:provider/provider.dart';
import 'package:yam_api/artist/brief_info.dart';
import 'package:yam_api/track/track.dart';
import 'package:yam_api/yam_api.dart';

import '../../constants/style_consts.dart';

class TrackCard extends StatelessWidget {
  const TrackCard({Key? key, required this.track, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;
  final Track track;

  @override
  Widget build(BuildContext context) {
    ///YandexProvider yandexProvider = context.watch();
    AudioProvider audioProvider = context.watch();
    PlayListProvider playListProvider = context.watch();

    bool isPlay = false;
    bool isSelected = false;
    bool isLike = false;

    /// isLike = yandexProvider.checkLike(track.id);

    if (playListProvider.queue!.isNotEmpty) {
      isPlay = audioProvider.currentTrack!.id == track.id && audioProvider.playerState == PlayerState.playing;
      isSelected = audioProvider.currentTrack!.id == track.id;
    }

    return GCardView(
      onPressed: () {
        onPressed();
        YamApi().getTrack(track.id);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              ImageThumbnail(url: track.coverUri!.linkImage(100), height: 44, width: 44),
              AnimatedScale(
                scale: isSelected ? 1 : 0,
                duration: AppConsts.slowAnimation,
                curve: AppConsts.defaultCurve,
                child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: FluentTheme.of(context).cardColor.withOpacity(.4)),
                    child: Center(
                      child: MiniMusicVisualizer(
                        color: Colors.red,
                        active: isPlay,
                        width: 4,
                        height: 15,
                      ),
                    )),
              ),
            ],
          ),
          AppConsts.defaultHSpacer,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                track.title.toString(),
                maxLines: 1,
                style: AppStyle.trackHeaderStyle,
              ),
              ArtistsListWidgets(
                mInnerArtistList: track.artists,
              )
            ],
          ),
          AppConsts.fillSpacer,
          TrackCommandBar(isLike: isLike, id: track.id),
          Text(track.durationMs == null ? "" : Duration(milliseconds: track.durationMs!.toInt()).toHms()),
        ],
      ),
    );
  }
}

class ArtistsListWidgets extends StatelessWidget {
  const ArtistsListWidgets({Key? key, required this.mInnerArtistList}) : super(key: key);

  final List<BriefInfo>? mInnerArtistList;

  @override
  Widget build(BuildContext context) {
    List<Widget> artistButtonList = [];
    String fullTitle = "";

    for (int i = 0; i < mInnerArtistList!.length; i++) {
      String title = "";
      var element = mInnerArtistList![i];
      if (i == 0) {
        title = element.name!;
        fullTitle = element.name!;
      } else {
        title = ", ${element.name!}";
        fullTitle = fullTitle + title;
      }
      artistButtonList.add(GTextButton(
        onPressed: () {
          if (fullTitle.length > 20) Navigator.pop(context);
          AppRouter().gotoArtist(context, element.id);
        },
        title: title,
      ));
    }

    if (fullTitle.length > 20) {
      fullTitle = "${fullTitle.substring(0, 17)}...";
      return GestureDetector(
          onTapDown: (details) {
            AppContext.showContext(context, details, artistButtonList);
          },
          child: GTextButton(onPressed: () {}, title: fullTitle));
    } else {
      return Row(
        children: artistButtonList,
      );
    }
  }
}

class TrackCommandBar extends StatelessWidget {
  const TrackCommandBar({Key? key, this.isLike = false, this.id}) : super(key: key);

  final String? id;
  final bool isLike;

  @override
  Widget build(BuildContext context) {
    /// setLike() async {
    ///   context.read<YandexProvider>().addLike(id);
    /// }
    ///
    /// removeLike() async {
    ///   context.read<YandexProvider>().removeLike(id);
    /// }

    return Row(
      children: [
        GIconButton(
          onPressed: () {
            /// if (!isLike) {
            ///   setLike();
            /// } else {
            ///   removeLike();
            /// }
          },
          icon: isLike ? m.Icons.favorite : m.Icons.favorite_border_rounded,
          iconColor: isLike ? FluentTheme.of(context).accentColor : Colors.transparent,
        ),
        AppConsts.smallHSpacer,
        GestureDetector(
          onTapDown: (details) => AppContext.showContext(context, details, [const Text("Hello!")]),
          child: GIconButton(
            onPressed: () {},
            icon: m.Icons.more_horiz_rounded,
          ),
        ),
        AppConsts.defaultHSpacer,
      ],
    );
  }
}
