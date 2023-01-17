import 'package:yam_api/album/album.dart';

import '../main.dart';

class PageAlbumProvider {
  PageAlbumProvider();

  Album mAlbum;

  Future<void> init(int id) async {
    mAlbum  = await client.getAlbumWithTracks(id);
  }

  Future<void> dispose() async {
    mAlbum = null;
  }

}