import 'package:yam_api/landing/chart.dart';
import 'package:yam_api/playlist/playlist.dart';

import '../main.dart';

class PagePlaylistProvider {
  PagePlaylistProvider();

  MPlaylist mPlaylist = MPlaylist();
  Chart chart = Chart();

  Future<void> init({required String uid, required String kind, bool? isChart = false}) async {
    if(!isChart!) {
      mPlaylist = await client.playlist(uid, kind);
    } else {
      chart = await client.chart();
      mPlaylist = chart.chart!;
    }
  }

  Future<void> dispose() async {
    mPlaylist = MPlaylist();
  }
}