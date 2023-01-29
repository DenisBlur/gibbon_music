import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:darq/darq.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/extensions/duration.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/providers/ux_provider.dart';
import 'package:gibbon_music/updated_ui/widgets/ImageThumbnail.dart';
import 'package:gibbon_music/updated_ui/widgets/card_view.dart';
import 'package:provider/provider.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:yam_api/artist/brief_info.dart';
import 'package:yam_api/track/track.dart';
import 'package:yam_api/yam_api.dart';

import '../../constants/style_consts.dart';
import '../../domain/models/playlist.dart';
import '../../providers/yandex_provider.dart';
import '../../router.dart';
import '../controls/buttons.dart';
import '../other/music_visualizer.dart';

class TrackCard extends StatelessWidget {
  const TrackCard({Key? key, required this.track, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;
  final Track track;

  //final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    YandexProvider yandexProvider = context.watch();
    bool isPlay = false;
    bool isSelected = false;
    bool isLike = yandexProvider.trackIsLiked(track.id.toString());
    String image = track.coverUri != null ? track.coverUri!.linkImage(100) : AppConsts.imageEmptyLink;

    if (context.watch<NewPlaylist>().currentTrack != null) {
      isSelected = track.id == context.watch<NewPlaylist>().currentTrack!.id;
      isPlay = context.watch<AudioProvider>().playerState == PlayerState.playing;
    }

    return GestureDetector(
        onSecondaryTapUp: (details) {
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) {
              return Stack(
                children: [
                  Center(child: SmoothContainer(
                    constraints: const BoxConstraints(
                      maxWidth: 250,
                      maxHeight: 450,
                    ),
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                    smoothness: 1,
                    borderRadius: BorderRadius.circular(16),
                    color: FluentTheme.of(context).cardColor,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(.1), offset: const Offset(0, 4), blurRadius: 5)]),
                                child: ImageThumbnail(
                                  url: track.ogImage.toString().linkImage(100),
                                  height: 56,
                                  width: 56,
                                  radius: 16,
                                ),
                              ),
                              AppConsts.defaultHSpacer,
                              Expanded(
                                child: Text(track.title.toString(), style: AppStyle.subTitle(context), maxLines: 1),
                              ),
                            ],
                          ),
                          AppConsts.defaultVSpacer,
                          GButton(
                              onPressed: () {
                                Navigator.pop(context);
                                context.read<NewPlaylist>().removeTrack(track);
                              },
                              title: "Удалить из очереди"),
                          AppConsts.smallVSpacer,
                          GButton(
                              onPressed: () {
                                Navigator.pop(context);
                                context.read<NewPlaylist>().addTrackToEnd(track);
                              },
                              title: "Добавить в конец"),
                          AppConsts.smallVSpacer,
                          GButton(
                              onPressed: () {
                                Navigator.pop(context);
                                context.read<NewPlaylist>().addTrackAfterCurrent(track);
                              },
                              title: "Добавить после текущего"),
                          AppConsts.smallVSpacer,
                          GButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              title: "Моя волна по треку"),
                          AppConsts.defaultHSpacer,
                          Text(
                            "Исполнители",
                            style: AppStyle.subTitle(context),
                          ),
                          AppConsts.smallVSpacer,
                          for (var e in track.artists!)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: GButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    AppRouter().gotoArtist(context, e.id);
                                  },
                                  title: e.name!),
                            ),
                          AppConsts.defaultHSpacer,
                          Text(
                            "Альбомы",
                            style: AppStyle.subTitle(context),
                          ),
                          AppConsts.smallVSpacer,
                          for (var e in track.albums!)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: GButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    AppRouter().gotoAlbum(context, e.id!.toInt());
                                  },
                                  title: e.title!),
                            ),
                        ],
                      ),
                    )
                  ),),
                ],
              );
            },
          );

          // UxProvider ux = context.read();
          // ux.onChangeDetails.add(TrackContextDetail(details: details, track: track));
          // ux.isContextMenu = true;
        },
        child: GCardView(
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
                  ImageThumbnail(url: image, height: 44, width: 44),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      track.title.toString(),
                      maxLines: 1,
                      style: AppStyle.trackHeaderStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    ArtistsListWidgets(
                      mInnerArtistList: track.artists,
                    )
                  ],
                ),
              ),
              AppConsts.fillSpacer,
              TrackCommandBar(isLike: isLike, id: track.id),
              Text(track.durationMs == null ? "" : Duration(milliseconds: track.durationMs!.toInt()).toHms()),
            ],
          ),
        ));
  }
}

class ArtistsListWidgets extends StatelessWidget {
  const ArtistsListWidgets({Key? key, required this.mInnerArtistList}) : super(key: key);

  final List<BriefInfo>? mInnerArtistList;

  @override
  Widget build(BuildContext context) {
    List<String> artistButtonList = [];

    artistButtonList = mInnerArtistList!.select((element, index) => element.name.toString()).toList();

    return GTextButton(onPressed: () {}, title: artistButtonList.join(", "));
  }
}

class TrackCommandBar extends StatelessWidget {
  const TrackCommandBar({Key? key, this.isLike = false, this.id}) : super(key: key);

  final String? id;
  final bool isLike;

  @override
  Widget build(BuildContext context) {
    likeAction() async {
      await context.read<YandexProvider>().trackActionLike(id.toString());
    }

    return Row(
      children: [
        GIconButton(
          onPressed: () {
            likeAction();
          },
          icon: isLike ? m.Icons.favorite : m.Icons.favorite_border_rounded,
          iconColor: isLike ? FluentTheme.of(context).accentColor : Colors.transparent,
        ),
        AppConsts.defaultHSpacer,
      ],
    );
  }
}
