import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/DesignWidget/Styles/ConstValue.dart';
import 'package:gibbon_music/Pages/AlbumPage.dart';
import 'package:gibbon_music/Pages/ArtistPage/ArtistPage.dart';
import 'package:gibbon_music/Pages/PlaylistPage.dart';
import 'package:gibbon_music/Pages/SearchPage.dart';
import 'package:gibbon_music/main.dart';

String linkImage(String url, int size) {
  if(url == imagePlaceholder || url.isEmpty) return imagePlaceholder;
  url = url.substring(0, url.indexOf("%"));

  return url = "https://$url${size}x$size";
}

String timeTrack(int ms) {
  Duration duration = Duration(milliseconds: ms);

  int minuteInt = duration.inSeconds ~/ 60;
  int secondsInt = (duration.inSeconds - (minuteInt * 60));

  String stM = minuteInt < 10 ? "0$minuteInt" : "$minuteInt";
  String stS = secondsInt < 10 ? "0$secondsInt" : "$secondsInt";

  return "$stM:$stS";
}

goToSearch(BuildContext context) {
  Navigator.push(context, FluentPageRoute(
    builder: (context) {
      return const SearchPage();
    },
  ));
  generalNotifyModel.backArrow = true;
  generalNotifyModel.addNavList("SearchPage");
}

goToArtist(BuildContext context, int artistId) {
  Navigator.push(context, FluentPageRoute(
    builder: (context) {
      return ArtistPage(artistId: artistId);
    },
  ));
  generalNotifyModel.backArrow = true;
  generalNotifyModel.addNavList("ArtistPage (id: $artistId)");
}

goToAlbum(BuildContext context, int albumId) {
  Navigator.push(context, FluentPageRoute(
    builder: (context) {
      return AlbumPage(albumId: albumId);
    },
  ));
  generalNotifyModel.backArrow = true;
  generalNotifyModel.addNavList("AlbumPage (id: $albumId)");
}

goToPlaylist(BuildContext context, String playlistId, int playlistKind) {
  Navigator.push(context, FluentPageRoute(
    builder: (context) {
      return PlaylistPage(
        playlistId: playlistId,
        playlistKind: playlistKind,
      );
    },
  ));
  generalNotifyModel.backArrow = true;
  generalNotifyModel.addNavList("PlaylistPage (id: $playlistId, kind: $playlistKind)");
}
