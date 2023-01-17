import 'package:darq/darq.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/providers/landing_provider.dart';
import 'package:gibbon_music/providers/playlist_provider.dart';
import 'package:gibbon_music/providers/navigator_provider.dart';
import 'package:gibbon_music/ui/widgets/album_card.dart';
import 'package:gibbon_music/ui/widgets/content_loader.dart';
import 'package:gibbon_music/ui/widgets/loading_ring.dart';
import 'package:gibbon_music/ui/widgets/track_card.dart';
import 'package:provider/provider.dart';

import 'package:gibbon_music/ui/widgets/scroller_scaffold.dart';
import 'package:yam_api/album/album.dart';
import 'package:yam_api/artist/artist.dart';
import 'package:yam_api/artist/brief_info.dart';
import 'package:yam_api/landing/entitie.dart';
import 'package:yam_api/landing/landing.dart';
import 'package:yam_api/playlist/playlist.dart';
import 'package:yam_api/track/track.dart';
import 'package:yam_api/yam_api.dart';

import '../../providers/playlist_page_provider.dart';

class PageLanding extends StatelessWidget {
  const PageLanding({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioProvider audioProvider = context.read();
    PagePlaylistProvider pagePlaylistProvider = context.read();
    PlayListProvider playlistProvider = context.read();
    LandingProvider landingProvider = context.read();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<NavigatorProvider>().showOverlay(context));

    return ScaffoldPage(
        resizeToAvoidBottomInset: true,
        padding: const EdgeInsets.all(0),
        content: ContentLoader(
          future: landingProvider.init(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ScaffoldScroller(
                slivers: [
                  SliverToBoxAdapter(
                      child: Column(
                    children: [
                      const Text("Вы недавно слушали", style: AppStyle.header1Style),
                      AppConsts.defaultVSpacer,
                      PlayContextSection(
                        entities: landingProvider.playContext,
                      ),
                      AppConsts.defaultVSpacer,
                      const Text("Чарт", style: AppStyle.header1Style),
                    ],
                  )),
                  const SliverToBoxAdapter(child: AppConsts.defaultVSpacer),
                  SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, mainAxisExtent: 56, crossAxisSpacing: 8, mainAxisSpacing: 8),
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => TrackCard(
                                track: landingProvider.chart[index],
                                onPressed: () {
                                  // TODO: application logic in UI?
                                  playlistProvider.setPlaylist(landingProvider.chart);
                                  playlistProvider.setCurrentTrack(index);
                                  // audioProvider.resume();
                                },
                              ),
                          childCount: landingProvider.chart.length)),
                ],
                padding: AppConsts.pageInsets,
              );
            } else {
              return const LoadingRing();
            }
          },
        ));
  }
}

class PlayContextSection extends StatelessWidget {
  const PlayContextSection({Key key, @required this.entities}) : super(key: key);

  final List<Entities> entities;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 186,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          Widget widget;

          switch (entities[index].data["context"]) {
            case "album":
              Album data = Album.fromJson(entities[index].data["payload"]);
              widget = AlbumCard(album: data);
              break;
            case "playlist":
              MPlaylist data = MPlaylist.fromJson(entities[index].data["payload"]);
              widget = PlaylistCard(playlist: data);
              break;
            case "artist":
              BriefInfo data = BriefInfo.fromJson(entities[index].data["payload"]);
              widget = ArtistCard(artist: data);
              break;
            default:
              break;
          }

          return Padding(padding: const EdgeInsets.only(right: 16), child: widget);
        },
        itemCount: entities.length,
      ),
    );
  }
}
