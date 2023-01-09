import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/Pages/ArtistPage/ArtistPage.dart';
import 'package:gibbon_music/main.dart';

String linkImage(String url, int size) {
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

goToArtist(BuildContext context, int artistId) {
  Navigator.push(context, FluentPageRoute(
    builder: (context) {
      return ArtistPage(artistId: artistId);
    },
  ));
  generalNotifyModel.backArrow = true;
  generalNotifyModel.addNavList("ArtistPage");
}
