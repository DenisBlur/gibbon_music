import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/providers/artist_provider.dart';
import 'package:provider/provider.dart';

import '../../api/mainYamFunction.dart';
import '../../api/models/PageModels/M_PageArtist.dart';
import '../../constants/style_consts.dart';
import '../../providers/dashboard_provider.dart';
import '../widgets/scroller_scaffold.dart';
import '../widgets/track_card.dart';

class PageArtist extends StatelessWidget {
  const PageArtist({Key key, this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        padding: const EdgeInsets.all(0),
        content: Consumer<ArtistProvider>(builder: (_, provider, __) {
          return FutureBuilder(
            future: provider.init(id),
            builder: (context, snapshot) {
              bool hasData = provider.mPageArtist != null;
              return ScaffoldScroller(
                slivers: hasData
                    ? [
                        SliverToBoxAdapter(
                          child: Column(
                            children: const [
                              AppConsts.defaultVSpacer,
                              Text("Популярные треки", style: AppStyle.header1Style),
                              AppConsts.defaultVSpacer
                            ],
                          ),
                        ),
                        SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (context, index) => Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: TrackCard(
                                        track: provider.mPageArtist.popularTracks[index],
                                      ),
                                    ),
                                childCount: provider.mPageArtist.popularTracks.length))
                      ]
                    : [
                        const SliverToBoxAdapter(
                            child: Center(
                          child: ProgressRing(),
                        ))
                      ],
              );
            },
          );
        }));
  }
}
