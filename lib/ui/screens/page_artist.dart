import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/providers/playlist_provider.dart';
import 'package:gibbon_music/ui/widgets/content_loader.dart';
import 'package:gibbon_music/ui/widgets/loading_ring.dart';
import 'package:provider/provider.dart';
import 'package:yam_api/artist/artist.dart';

import '../../constants/style_consts.dart';
import '../../providers/artist_page_provider.dart';
import '../../providers/audio_provider.dart';
import '../widgets/list_widget.dart';
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
                        Text("Альбомы", style: AppStyle.header1Style),
                        AppConsts.defaultVSpacer,
                        ListWidget( list: mPageArtist.albums!,),
                        AppConsts.defaultVSpacer,
                        const Text("Плейлисты", style: AppStyle.header1Style),
                        AppConsts.defaultVSpacer,
                        ListWidget( list: mPageArtist.playlists!,),
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
