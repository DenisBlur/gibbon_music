import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/api/models/M_Artist.dart';
import 'package:gibbon_music/api/models/M_Playlist.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/providers/dashboard_provider.dart';
import 'package:gibbon_music/router.dart';
import 'package:gibbon_music/ui/widgets/card_view.dart';
import 'package:gibbon_music/ui/widgets/track_card.dart';
import 'package:provider/provider.dart';

import '../../api/models/M_Album.dart';
import '../widgets/ImageThumbnail.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({Key key, this.album}) : super(key: key);

  final MAlbum album;

  @override
  Widget build(BuildContext context) {
    return CardContent(
      uri: album.ogImage,
      title: album.title,
      subtitle: album.artists.first.name,
      onPressed: () {
        AppRouter().gotoAlbum(context, album.id);
      },
      upTitle: 'Album',
    );
  }
}

class ArtistCard extends StatelessWidget {
  const ArtistCard({Key key, this.artist}) : super(key: key);

  final MArtist artist;

  @override
  Widget build(BuildContext context) {
    return CardContent(
      uri: artist.ogImage,
      title: artist.name,
      subtitle: artist.genres.first,
      onPressed: () {
        AppRouter().gotoArtist(context, int.parse(artist.id));
      },
      upTitle: 'Artist',
    );
  }
}

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({Key key, this.playlist}) : super(key: key);

  final MPlaylist playlist;

  @override
  Widget build(BuildContext context) {
    return CardContent(
      uri: playlist.cover.uri,
      title: playlist.title,
      subtitle: playlist.owner == null ? "${playlist.trackCount} Треков" : playlist.owner.name,
      onPressed: () {
        AppRouter().gotoPlaylist(context, playlist.owner.uid.toString(), playlist.kind.toString());
      },
      upTitle: 'Playlist',
    );
  }
}

class CardContent extends StatelessWidget {
  const CardContent({Key key, @required this.uri, @required this.title, @required this.subtitle, @required this.onPressed, @required this.upTitle})
      : super(key: key);

  final String uri, title, subtitle, upTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 186,
      width: 186,
      child: HoverButton(
        onPressed: () => onPressed(),
        builder: (p0, state) => ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              AnimatedScale(
                scale: state.isPressing
                    ? 0.9
                    : state.isHovering
                        ? 0.98
                        : 0.95,
                duration: AppConsts.defaultAnimation,
                curve: AppConsts.defaultCurve,
                child: ImageThumbnail(url: uri.linkImage(200), width: 186, height: 186, radius: 16),
              ),
              Container(
                width: 186,
                height: 186,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(1),
                  FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(0),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
              ),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(upTitle.toUpperCase(), style: AppStyle.upCardHeaderStyle(context)),
                      Text(title, style: AppStyle.cardHeaderStyle, maxLines: 1),
                      Text(subtitle, style: AppStyle.subTrackHeaderStyle(context)),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
