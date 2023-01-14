import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/providers/artist_provider.dart';
import 'package:gibbon_music/ui/widgets/content_loader.dart';
import 'package:gibbon_music/ui/widgets/loading_ring.dart';
import 'package:provider/provider.dart';

import '../../api/models/PageModels/M_PageArtist.dart';
import '../../constants/style_consts.dart';
import '../../providers/audio_provider.dart';
import '../widgets/scroller_scaffold.dart';
import '../widgets/track_card.dart';

class PageArtist extends StatelessWidget {
  const PageArtist({Key key, this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    AudioProvider audioProvider = context.read();

    ArtistProvider artistProvider = context.read();
    artistProvider.dispose();

    return ScaffoldPage(
        padding: const EdgeInsets.all(0),
        content: ContentLoader(
          future: artistProvider.init(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              MPageArtist mPageArtist = artistProvider.mPageArtist;
              return ScaffoldScroller(slivers: [
                SliverToBoxAdapter(
                    child: FadeInUp(
                  delay: const Duration(milliseconds: 250),
                  child: Column(
                    children: const [AppConsts.defaultVSpacer, Text("Популярные треки", style: AppStyle.header1Style), AppConsts.defaultVSpacer],
                  ),
                )),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: FadeInUp(
                                delay: Duration(milliseconds: 250+(50*index)),
                                child: TrackCard(
                                  track: mPageArtist.popularTracks[index],
                                  onPressed: () {
                                    audioProvider.setPlaylist(mPageArtist.popularTracks);
                                    audioProvider.playTrack(index);
                                  },
                                ),
                              ),
                            ),
                        childCount: mPageArtist.popularTracks.length))
              ]);
            } else {
              return const LoadingRing();
            }
          },
        ));
  }
}
