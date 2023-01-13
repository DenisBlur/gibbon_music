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
    return GCardView(
      onPressed: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ImageThumbnail(url: album.coverUri.linkImage(200), width: 150, height: 150),
          AppConsts.smallVSpacer,
          Text(album.title, style: AppStyle.trackHeaderStyle),
          ArtistsListWidgets(mInnerArtistList: album.artists)
        ],
      ),
    );
  }
}

class ArtistCard extends StatelessWidget {
  const ArtistCard({Key key, this.artist}) : super(key: key);

  final MArtist artist;

  @override
  Widget build(BuildContext context) {
    return GCardView(
      onPressed: () {
        AppRouter().gotoArtist(context, int.parse(artist.id));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ImageThumbnail(url: artist.ogImage.linkImage(200), width: 150, height: 150),
          AppConsts.smallVSpacer,
          Text(artist.name, style: AppStyle.trackHeaderStyle),
          Text(artist.genres.first, style: AppStyle.subTrackHeaderStyle(context)),
        ],
      ),
    );
  }
}

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({Key key, this.playlist}) : super(key: key);

  final MPlaylist playlist;

  @override
  Widget build(BuildContext context) {
    return GCardView(
      onPressed: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ImageThumbnail(url: playlist.cover.uri.linkImage(200), width: 150, height: 150),
          AppConsts.smallVSpacer,
          Text(playlist.title, style: AppStyle.trackHeaderStyle),
          Text(playlist.owner.name, style: AppStyle.subTrackHeaderStyle(context)),
        ],
      ),
    );
  }
}
