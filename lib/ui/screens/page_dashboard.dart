import 'package:darq/darq.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/api/models/PageModels/M_PageDashboard.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/providers/dashboard_provider.dart';
import 'package:gibbon_music/providers/playlist_provider.dart';
import 'package:gibbon_music/providers/navigator_provider.dart';
import 'package:gibbon_music/ui/widgets/album_card.dart';
import 'package:gibbon_music/ui/widgets/content_loader.dart';
import 'package:gibbon_music/ui/widgets/loading_ring.dart';
import 'package:gibbon_music/ui/widgets/track_card.dart';
import 'package:provider/provider.dart';

import 'package:gibbon_music/ui/widgets/scroller_scaffold.dart';
import 'package:yam_api/yam_api.dart';
import '../../api/models/M_Album.dart';
import '../../api/models/M_Artist.dart';
import '../../api/models/M_Entities.dart';
import '../../api/models/M_Playlist.dart';

class PageDashboard extends StatelessWidget {
  const PageDashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioProvider audioProvider = context.read();
    PagePlaylistProvider pagePlaylistProvider = context.read();
    PlayListProvider playlistProvider = context.read();
    DashboardProvider dashboardProvider = context.read();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<NavigatorProvider>().showOverlay(context));

    return ScaffoldPage(
        resizeToAvoidBottomInset: true,
        padding: const EdgeInsets.all(0),
        content: ContentLoader(
          future: dashboardProvider.init(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              MPageDashboard mPageDashboard = dashboardProvider.mPageDashboard;
              return ScaffoldScroller(
                slivers: [
                  SliverToBoxAdapter(
                      child: Column(
                    children: [
                      const Text("Вы недавно слушали", style: AppStyle.header1Style),
                      AppConsts.defaultVSpacer,
                      PlayContextSection(
                        playContexts: mPageDashboard.playContextList,
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
                                track: mPageDashboard.chartList[index].track,
                                onPressed: () {
                                  // TODO: application logic in UI?
                                  var tracks = mPageDashboard.chartList.select((element, index) => element.track).toList();

                                  playlistProvider.setPlaylist(tracks);
                                  playlistProvider.setCurrentTrack(index);
                                  // audioProvider.resume();
                                },
                              ),
                          childCount: mPageDashboard.chartList.length)),
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
  const PlayContextSection({Key key, @required this.playContexts}) : super(key: key);

  final List<MEntities> playContexts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 186,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          Widget widget;

          switch (playContexts[index].data["context"]) {
            case "album":
              MAlbum data = MAlbum.fromJson(playContexts[index].data["payload"]);
              widget = AlbumCard(album: data);
              break;
            case "playlist":
              MPlaylist data = MPlaylist.fromJson(playContexts[index].data["payload"]);
              widget = PlaylistCard(playlist: data);
              break;
            case "artist":
              MArtist data = MArtist.fromJson(playContexts[index].data["payload"]);
              widget = ArtistCard(artist: data);
              break;
            default:
              break;
          }

          return Padding(padding: const EdgeInsets.only(right: 16), child: widget);
        },
        itemCount: playContexts.length,
      ),
    );
  }
}
