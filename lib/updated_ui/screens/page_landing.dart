import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/enums/e_list_typer.dart';
import 'package:gibbon_music/ui/widgets/track_card.dart';
import 'package:gibbon_music/updated_ui/widgets/custom_scaffold.dart';
import 'package:gibbon_music/updated_ui/widgets/dynamic_list.dart';
import 'package:provider/provider.dart';

import '../../constants/ui_consts.dart';
import '../../providers/landing_provider.dart';
import '../../providers/navigator_provider.dart';
import '../../ui/widgets/loading_ring.dart';

class UPageLanding extends StatelessWidget {
  const UPageLanding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LandingProvider landingProvider = context.read();
    landingProvider.dispose();

    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<NavigatorProvider>().showOverlay(context));

    return FutureBuilder(
      future: landingProvider.init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CustomScaffold(
            children: [
              Text(
                "Главное",
                style: AppStyle.title(context),
              ),
              AppConsts.defaultVSpacer,
              DynamicListWidget(
                listData: landingProvider.promotions,
                title: 'Интересно сейчас',
                listType: ListType.wide,
              ),
              DynamicListWidget(
                listData: landingProvider.newPlaylists,
                title: 'Хиты и новинки',
              ),
              AppConsts.defaultVSpacer,
              DynamicListWidget(
                listData: landingProvider.newReleases,
                title: 'Новые релизы',
              ),
              AppConsts.defaultVSpacer,
              DynamicListWidget(listData: landingProvider.playContext, title: 'Вы недавно слушали'),
              AppConsts.defaultVSpacer,
              Text(
                "Чарт",
                style: AppStyle.subTitle(context),
              ),
              AppConsts.smallVSpacer,
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(padding: EdgeInsets.only(bottom: 8), child: TrackCard(
                        track: landingProvider.chart[index],
                        onPressed: () {},
                      ),),
                      childCount: landingProvider.chart.length))
            ],
          );
        } else {
          return const LoadingRing();
        }
      },
    );
  }
}
