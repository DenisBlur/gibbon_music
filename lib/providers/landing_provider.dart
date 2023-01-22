import 'package:darq/darq.dart';
import 'package:gibbon_music/main.dart';
import 'package:yam_api/album/album.dart';
import 'package:yam_api/landing/entities.dart';
import 'package:yam_api/landing/landing.dart';
import 'package:yam_api/landing/promotion.dart';
import 'package:yam_api/playlist/playlist.dart';
import 'package:yam_api/track/track.dart';

class LandingProvider {
  LandingProvider();

  late Landing mLanding = Landing();
  late List<Entities> playContext = [];
  late List<Track> chart = [];
  late List<Promotion> promotions = [];
  late List<MPlaylist> newPlaylists = [];
  late List<Album> newReleases = [];

  Future<void> init() async {
    mLanding = await client.landing(blocks: ["play_contexts", "chart", "promotions"]);
    for (var element in mLanding.blocks!) {
      switch (element.type) {
        case "play-contexts":
          playContext = element.entities!;
          break;
        case "chart":
          for (var element in element.entities!) {
            chart.add(Track.fromJson(element.data["track"]));
          }
          break;
        case "promotions":
          promotions = element.entities!.select((element, _) => Promotion.fromJson(element.data)).toList();
          break;
      }
      newReleases = await client.newReleases();
      newPlaylists = await client.newPlaylists();
    }
  }

  Future<void> dispose() async {
    mLanding = Landing();
    playContext = [];
    chart = [];
    promotions = [];
    newPlaylists = [];
  }
}
