import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/main.dart';
import 'package:yam_api/artist/artist.dart';

class PageArtistProvider{
  PageArtistProvider();

  Artist mArtist;

  Future<void> init(String id) async {
    mArtist  = await client.getArtistPage(id);
  }

  Future<void> dispose() async {
    mArtist = null;
  }
}
