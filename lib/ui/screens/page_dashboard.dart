import 'package:darq/darq.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/providers/dashboard_provider.dart';
import 'package:gibbon_music/ui/widgets/album_card.dart';
import 'package:gibbon_music/ui/widgets/track_card.dart';
import 'package:provider/provider.dart';

import 'package:gibbon_music/ui/widgets/scroller_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import '../../api/models/M_Album.dart';
import '../../api/models/M_Artist.dart';
import '../../api/models/M_Entities.dart';
import '../../api/models/M_Playlist.dart';

class PageDashboard extends StatelessWidget {
  const PageDashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioProvider audioProvider = context.read();

    return ScaffoldPage(
        resizeToAvoidBottomInset: true,
        padding: const EdgeInsets.all(0),
        content: Consumer<DashboardProvider>(
          builder: (_, provider, __) {
            return FutureBuilder(
              future: provider.init(),
              builder: (_, snapshot) {
                bool hasData = provider.mPageDashboard != null;
                return ScaffoldScroller(slivers: [
                  const SliverToBoxAdapter(
                    child: Text("Вы недавно слушали", style: AppStyle.header1Style),
                  ),
                  PlayContextSection(
                    playContexts: provider.mPageDashboard.playContextList,
                  ),
                  const SliverToBoxAdapter(child: AppConsts.defaultVSpacer),
                  const SliverToBoxAdapter(
                    child: Text("Чарт", style: AppStyle.header1Style),
                  ),
                  const SliverToBoxAdapter(child: AppConsts.defaultVSpacer),
                  SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, mainAxisExtent: 56, crossAxisSpacing: 8, mainAxisSpacing: 8),
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => TrackCard(
                                track: provider.mPageDashboard.chartList[index].track,
                                onPressed: () {
                                  var tracks = provider.mPageDashboard.chartList.select((element, index) => element.track).toList();

                                  audioProvider.setPlaylist(tracks);
                                  audioProvider.playTrack(index);
                                },
                              ),
                          childCount: provider.mPageDashboard.chartList.length))
                ]);
              },
            );
          },
        ));
  }
}

class PlayContextSection extends StatelessWidget {
  const PlayContextSection({Key key, @required this.playContexts}) : super(key: key);

  final List<MEntities> playContexts;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: SizedBox(
      height: 250,
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

          return widget;
        },
        itemCount: playContexts.length,
      ),
    ));
  }
}
