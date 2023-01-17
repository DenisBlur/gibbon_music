import 'package:gibbon_music/main.dart';
import 'package:yam_api/landing/entitie.dart';
import 'package:yam_api/landing/landing.dart';
import 'package:yam_api/track/track.dart';

class LandingProvider {
  LandingProvider();

  Landing mLanding;
  List<Entities> playContext = [];
  List<Track> chart = [];
  List<Entities> promotions = [];

  Future<void> init() async {
    mLanding ??= await client.landing(blocks: ["play_contexts", "chart", "promotions", "mixes"]);
    for (var element in mLanding.blocks) {
      switch (element.type) {
        case "play-contexts":
          playContext = element.entities;
          break;
        case "chart":
          for (var element in element.entities) {
            chart.add(Track.fromJson(element.data["track"]));
          }
          break;
        case "promotions":
          promotions = element.entities;
          break;
      }
    }
  }

  Future<void> dispose() async {
    mLanding = null;
    playContext = [];
    chart = [];
    promotions = [];
  }
}
