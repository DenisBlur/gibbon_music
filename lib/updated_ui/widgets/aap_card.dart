import 'package:darq/darq.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:gibbon_music/main.dart';
import 'package:gibbon_music/router.dart';
import 'package:provider/provider.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:yam_api/album/album.dart';
import 'package:yam_api/artist/brief_info.dart';
import 'package:yam_api/playlist/playlist.dart';

import '../controls/buttons.dart';
import 'image_hovered.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({Key? key, required this.album}) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    return CardContent(
      uri: album.ogImage!,
      title: album.title!,
      subtitle: album.artists!.first.name,
      onPressed: () {
        AppRouter().gotoAlbum(context, album.id!.toInt());
      },
      upTitle: 'Album',
      onPlay: () {},
    );
  }
}

class ArtistCard extends StatelessWidget {
  const ArtistCard({Key? key, required this.artist}) : super(key: key);

  final BriefInfo artist;

  @override
  Widget build(BuildContext context) {
    return CardContent(
      uri: artist.cover!.uri,
      title: artist.name!,
      subtitle: artist.genres!.isEmpty ? "" : artist.genres!.first,
      onPressed: () {
        AppRouter().gotoArtist(context, artist.id!);
      },
      upTitle: 'Artist',
      onPlay: () {},
    );
  }
}

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({Key? key, required this.playlist}) : super(key: key);

  final MPlaylist playlist;

  @override
  Widget build(BuildContext context) {
    String uid = playlist.owner == null ? playlist.uid.toString() : playlist.owner!.uid.toString();
    String kind = playlist.kind.toString();

    NewPlaylist playListProvider = context.read();

    Future<void> getTracks() async {
      var result = await client.playlist(uid, kind);
      var tracks = result.tracks!.select((e, _) => e!.track).toList();
      playListProvider.tracks = tracks;
      playListProvider.currentTrackIndex = 0;
    }

    return CardContent(
      uri: playlist.cover!.uri,
      title: playlist.title,
      subtitle: "${playlist.trackCount} Треков",
      onPressed: () {
        AppRouter().gotoPlaylist(context, uid, kind, false);
      },
      upTitle: 'Playlist',
      onPlay: () => getTracks(),
    );
  }
}

class CardContent extends StatelessWidget {
  const CardContent(
      {Key? key,
      required this.uri,
      required this.title,
      required this.subtitle,
      required this.onPressed,
      required this.upTitle,
      required this.onPlay})
      : super(key: key);

  final String? uri, title, subtitle, upTitle;
  final VoidCallback onPressed;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppConsts.defaultCardHeight,
      width: AppConsts.defaultCardWidth,
      child: HoverButton(
        onPressed: () => onPressed(),
        builder: (p0, state) {
          double imageState = 1.0;
          if (state.isPressing) {
            imageState = 0.9;
          } else if (state.isHovering) {
            imageState = 0.98;
          } else {
            imageState = .95;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ImageHovered(imageState: imageState, uri: uri!),
                  Container(
                    width: AppConsts.defaultCardWidth,
                    height: AppConsts.defaultCardWidth,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(colors: [
                        FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(1),
                        FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(0),
                      ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                      shape: SmoothRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        smoothness: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GIconButton(onPressed: () {}, icon: m.Icons.favorite_border_rounded),
                        AppConsts.smallHSpacer,
                        GIconButton(
                            onPressed: () {
                              onPlay();
                            },
                            icon: m.Icons.play_arrow,
                            contrastBackground: true,
                            size: 26),
                        AppConsts.smallHSpacer,
                        GIconButton(onPressed: () {}, icon: m.Icons.more_horiz_rounded)
                      ],
                    ),
                  ).animate(target: state.isHovering ? 1 : 0)
                      .fadeIn(duration: AppConsts.defaultAnimation, curve: AppConsts.defaultCurve)
                      .moveY(begin: 150, end: 0, duration: AppConsts.defaultAnimation, curve: AppConsts.defaultCurve),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(upTitle!.toUpperCase(), maxLines: 1, overflow: TextOverflow.clip, style: AppStyle.upCardHeaderStyle(context)),
                    Text(title!, maxLines: 1, overflow: TextOverflow.clip, style: AppStyle.cardHeaderStyle),
                    Text(subtitle!, maxLines: 1, overflow: TextOverflow.clip, style: AppStyle.subTrackHeaderStyle(context)),
                  ]))
            ],
          );
        },
      ),
    );
  }
}
