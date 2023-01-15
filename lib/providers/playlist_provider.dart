import 'package:gibbon_music/api/mainYamFunction.dart';
import 'package:gibbon_music/api/models/PageModels/M_PageAlbum.dart';
import 'package:gibbon_music/api/models/PageModels/M_PagePlaylist.dart';

class PlaylistProvider {
  PlaylistProvider();

  MPagePlaylist _mPagePlaylist;

  MPagePlaylist get mPagePlaylist => _mPagePlaylist;

  set mPagePlaylist(MPagePlaylist value) {
    _mPagePlaylist = value;
  }

  Future<void> init(String id, String kind) async {
    mPagePlaylist  = await getPlaylist(id, kind);
  }

  Future<void> dispose() async {
    mPagePlaylist = null;
  }

}