import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/main.dart';
import 'package:gibbon_music/router.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:yam_api/album/album.dart';
import 'package:yam_api/artist/brief_info.dart';
import 'package:yam_api/playlist/playlist.dart';

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
      uri: artist.cover != null ? artist.cover!.uri : null,
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
    String? uri = playlist.cover!.uri ?? playlist.ogImage;

    NewPlaylist playListProvider = context.read();

    Future<void> getTracks() async {
      var result = await client.playlist(uid, kind);
      var tracks = result.tracks!.select((e, _) => e!.track).toList();
      playListProvider.tracks = tracks;
      playListProvider.currentTrackIndex = 0;
    }

    return CardContent(
      uri: uri,
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
    return InkWell(
      borderRadius: BorderRadius.circular(16),
        onTap: () => onPressed(),
        child: AnimatedScale(
          scale: 1,
          duration: Animate.defaultDuration,
          curve: AppConsts.defaultCurve,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: AppConsts.defaultCardHeight,
              width: AppConsts.defaultCardWidth,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: uri != null ? uri!.linkImage(200) : AppConsts.imageEmptyLink,
                        height: AppConsts.defaultCardHeight,
                        width: AppConsts.defaultCardWidth/2,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: AppConsts.defaultCardHeight,
                        width: AppConsts.defaultCardWidth,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Theme.of(context).colorScheme.secondaryContainer,
                            Theme.of(context).colorScheme.secondaryContainer,
                            Theme.of(context).colorScheme.secondaryContainer.withOpacity(0),
                          ], begin: Alignment.centerRight, end: Alignment.centerLeft),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(title!, maxLines: 1, overflow: TextOverflow.clip),
                            Text(subtitle!, maxLines: 1, overflow: TextOverflow.clip),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),);
  }
}
