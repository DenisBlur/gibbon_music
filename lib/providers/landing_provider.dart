import 'package:darq/darq.dart';
import 'package:gibbon_music/main.dart';
import 'package:yam_api/album/album.dart';
import 'package:yam_api/genres/genres.dart';
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
  late List<MPlaylist> collections = [];
  late List<MPlaylist> userPlaylists = [];
  late List<Genres> genres = [];

  Future<void> init() async {
    var futureLanding = client.landing(blocks: ["play_contexts", "chart", "promotions", "mixes"]).then((value) {
      mLanding = value;
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
      }
    });

    var futureNewReleases = client.newReleases().then((value) {
      newReleases = value;
    });
    var futureNewPlaylists = client.newPlaylists().then((value) {
      newPlaylists = value;
    });

    var futureFeed = client.feed().then((value) {
      var feed = value;
      collections = feed.generatedPlaylists!
          .select(
            (element, index) => element.data!,
          )
          .toList();
    });

    var futureGenres = client.genres().then((value) {
      genres = value;
    });

    userPlaylists = await client.userPlaylists();

    await Future.wait([futureLanding, futureNewReleases, futureNewPlaylists, futureFeed, futureGenres]);
  }

  Future<void> dispose() async {
    mLanding = Landing();
    playContext = [];
    chart = [];
    promotions = [];
    newPlaylists = [];
  }
}
