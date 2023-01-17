import 'package:yam_api/playlist/playlist.dart';

import '../main.dart';

class PagePlaylistProvider {
  PagePlaylistProvider();

  MPlaylist mPlaylist;

  Future<void> init(String uid, String kind) async {
    mPlaylist = await client.playlist(uid, kind);
  }

  Future<void> dispose() async {
    mPlaylist = null;
  }
}