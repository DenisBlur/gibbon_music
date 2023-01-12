import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/providers/dashboard_provider.dart';
import 'package:gibbon_music/ui/list_item/track_card.dart';
import 'package:provider/provider.dart';

import 'package:gibbon_music/ui/widgets/scroller_scaffold.dart';

class PageDashboard extends StatelessWidget {
  const PageDashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (_, provider, __) {
        return FutureBuilder(
          future: provider.init(),
          builder: (_, __) {
            return provider.mPageDashboard != null
                ? ScaffoldScroller(
                    slivers: [
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
                                  ),
                              childCount: provider.mPageDashboard.chartList.length))
                    ],
                  )
                : const Center(
                    child: ProgressRing(),
                  );
          },
        );
      },
    );
  }
}
