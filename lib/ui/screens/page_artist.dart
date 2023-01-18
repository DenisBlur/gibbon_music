import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/providers/playlist_provider.dart';
import 'package:gibbon_music/ui/widgets/content_loader.dart';
import 'package:gibbon_music/ui/widgets/loading_ring.dart';
import 'package:provider/provider.dart';
import 'package:yam_api/album/album.dart';
import 'package:yam_api/artist/artist.dart';
import 'package:yam_api/playlist/playlist.dart';

import '../../constants/style_consts.dart';
import '../../providers/artist_page_provider.dart';
import '../../providers/audio_provider.dart';
import '../widgets/album_card.dart';
import '../widgets/scroller_scaffold.dart';
import '../widgets/track_card.dart';

class PageArtist extends StatelessWidget {
  const PageArtist({Key? key, required this.artistId}) : super(key: key);

  final String artistId;

  @override
  Widget build(BuildContext context) {
    AudioProvider audioProvider = context.read();

    PlayListProvider playListProvider = context.read();
    PageArtistProvider artistProvider = context.read();
    artistProvider.dispose();

    return ScaffoldPage(
        padding: const EdgeInsets.all(0),
        content: ContentLoader(
          future: artistProvider.init(artistId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Artist mPageArtist = artistProvider.mArtist;
              return ScaffoldScroller(
                scrollHeaderModel: ScrollHeaderContent(pageModel: mPageArtist),
                slivers: [
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
                                  track: mPageArtist.popularTracks![index],
                                  onPressed: () {
                                    playListProvider.setPlaylist(mPageArtist.popularTracks!);
                                    playListProvider.setCurrentTrack(index);
                                    audioProvider.playTrack();
                                    // audioProvider.playTrack();
                                  },
                                ),
                              ),
                          childCount: mPageArtist.popularTracks!.length)),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppConsts.defaultVSpacer,
                        FadeInUp(child: const Text("Альбомы", style: AppStyle.header1Style)),
                        AppConsts.defaultVSpacer,
                        AlbumSection(
                          albums: mPageArtist.albums!,
                        ),
                        AppConsts.defaultVSpacer,
                        FadeInUp(child: const Text("Плейлисты", style: AppStyle.header1Style)),
                        AppConsts.defaultVSpacer,
                        PlaylistSection(
                          playlist: mPageArtist.playlists!,
                        ),
                      ],
                    ),
                  ),
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

class AlbumSection extends StatelessWidget {
  const AlbumSection({Key? key, required this.albums}) : super(key: key);

  final List<Album> albums;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
        delay: const Duration(milliseconds: 250),
        child: SizedBox(
          height: AppConsts.cardHeight,
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
          height: AppConsts.cardHeight,
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
