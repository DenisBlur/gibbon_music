import 'dart:io';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:darq/darq.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/main.dart';
import 'package:gibbon_music/providers/playlist_provider.dart';
import 'package:gibbon_music/providers/ux_provider.dart';
import 'package:gibbon_music/router.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/ui/controls/buttons.dart';
import 'package:provider/provider.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:yam_api/album/album.dart';
import 'package:yam_api/artist/brief_info.dart';
import 'package:yam_api/playlist/playlist.dart';

import '../../updated_ui/widgets/image_hoverd.dart';
import '../other/music_visualizer.dart';
import '../widgets/ImageThumbnail.dart';

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
      uri: artist.ogImage!,
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

    PlayListProvider playListProvider = context.read();
    UxProvider ux = context.watch();

    Future<void> getTracks() async {
      var result = await client.playlist(uid, kind);
      var tracks = result.tracks!.select((e, _) => e!.track).toList();
      playListProvider.setPlaylist(tracks);
      playListProvider.setCurrentTrack(0);
      ux.currentPlaylist = "$uid:$kind";
    }

    return CardContent(
      isPlaying: ux.currentPlaylist == "$uid:$kind",
      uri: playlist.cover!.uri,
      title: playlist.title,
      subtitle: playlist.owner == null ? "${playlist.trackCount} Треков" : playlist.owner!.name,
      onPressed: () {
        AppRouter().gotoPlaylist(context, uid, kind);
      },
      upTitle: 'Playlist',
      onPlay: () => getTracks(),
    );
  }
}

class CardContent extends StatelessWidget {
  const CardContent({Key? key, required this.uri, required this.title, required this.subtitle, required this.onPressed, required this.upTitle, required this.onPlay, this.isPlaying = false}) : super(key: key);

  final String? uri, title, subtitle, upTitle;
  final bool? isPlaying;
  final VoidCallback onPressed;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppConsts.standartCardHeight,
      width: AppConsts.standartCardWidth,
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
                  FadeInUp(
                    duration: AppConsts.defaultAnimation,
                    animate: isPlaying == false ? state.isHovering : isPlaying as bool,
                    child: Container(
                      width: AppConsts.standartCardWidth,
                      height: AppConsts.standartCardWidth,
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
                              icon: isPlaying == true ? m.Icons.pause : m.Icons.play_arrow,
                              contrastBackground: true,
                              size: 26),
                          AppConsts.smallHSpacer,
                          GIconButton(onPressed: () {}, icon: m.Icons.more_horiz_rounded)
                        ],
                      ),
                    ),
                  )
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
