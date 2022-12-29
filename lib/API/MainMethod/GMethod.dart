String linkImage(String url, int sizeX, int sizeY) {
  url = url.substring(0, url.indexOf("%"));
  return url = "https://$url${sizeX}x$sizeY";
}

String timeTrack(int ms) {

  Duration duration = Duration(milliseconds: ms);

  int minuteInt = duration.inSeconds ~/ 60;
  int secondsInt = (duration.inSeconds - (minuteInt * 60));

  String stM = minuteInt < 10 ? "0$minuteInt" : "$minuteInt";
  String stS = secondsInt < 10 ? "0$secondsInt" : "$secondsInt";

  return "$stM:$stS";

}