import 'package:animate_do/animate_do.dart';
import 'package:darq/darq.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/providers/playlist_provider.dart';
import 'package:gibbon_music/ui/widgets/content_loader.dart';
import 'package:gibbon_music/ui/widgets/loading_ring.dart';
import 'package:provider/provider.dart';
import 'package:yam_api/album/album.dart';
import 'package:yam_api/playlist/playlist.dart';

import '../../constants/style_consts.dart';
import '../../providers/audio_provider.dart';
import '../../providers/playlist_page_provider.dart';
import '../widgets/album_card.dart';
import '../widgets/scroller_scaffold.dart';
import '../widgets/track_card.dart';

class PagePlaylist extends StatelessWidget {
  const PagePlaylist({Key? key, required this.id, required this.kind}) : super(key: key);

  final String id;
  final String kind;

  @override
  Widget build(BuildContext context) {
    AudioProvider audioProvider = context.read();
    PlayListProvider playListProvider = context.read();
    PagePlaylistProvider pagePlaylistProvider = context.read();
    pagePlaylistProvider.dispose();

    return SafeArea(child:ScaffoldPage(
        padding: const EdgeInsets.all(0),
        content: ContentLoader(
          future: pagePlaylistProvider.init(id, kind),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              MPlaylist mPagePlaylist = pagePlaylistProvider.mPlaylist;
              return ScaffoldScroller(scrollHeaderModel: ScrollHeaderContent(pageModel: mPagePlaylist), slivers: [
                SliverToBoxAdapter(
                    child: FadeInUp(
                  delay: const Duration(milliseconds: 150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [AppConsts.defaultVSpacer, Text("Популярные треки", style: AppStyle.header1Style), AppConsts.defaultVSpacer],
                  ),
                )),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: TrackCard(
                                track: mPagePlaylist.tracks![index]!.track!,
                                onPressed: () {
                                  playListProvider.setPlaylist(mPagePlaylist.tracks!.select((e, _) => e?.track,).toList());
                                  playListProvider.setCurrentTrack(index);
                                  audioProvider.resume();
                                },
                              ),
                            ),
                        childCount: mPagePlaylist.tracks!.length)),
              ], padding: AppConsts.pageInsets,);
            } else {
              return const LoadingRing();
            }
          },
        )));
  }
}

class AlbumSection extends StatelessWidget {
  const AlbumSection({Key? key, required this.albums}) : super(key: key);

  final List<Album> albums;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
        delay: const Duration(milliseconds: 250),
        child: SizedBox(
          height: 186,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(padding: const EdgeInsets.only(right: 16), child: AlbumCard(album: albums[index]));
            },
            itemCount: albums.length,
          ),
        ));
  }
}

class PlaylistSection extends StatelessWidget {
  const PlaylistSection({Key? key, required this.playlist}) : super(key: key);

  final List<MPlaylist> playlist;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
        delay: const Duration(milliseconds: 400),
        child: SizedBox(
          height: 186,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(padding: const EdgeInsets.only(right: 16), child: PlaylistCard(playlist: playlist[index]));
            },
            itemCount: playlist.length,
          ),
        ));
  }
}
