import 'package:darq/darq.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:gibbon_music/enums/e_list_typer.dart';
import 'package:gibbon_music/main.dart';
import 'package:gibbon_music/providers/playlist_provider.dart';
import 'package:gibbon_music/providers/yandex_provider.dart';
import 'package:gibbon_music/router.dart';
import 'package:gibbon_music/updated_ui/widgets/track_card.dart';
import 'package:gibbon_music/updated_ui/widgets/custom_scaffold.dart';
import 'package:gibbon_music/updated_ui/widgets/dynamic_list.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../constants/ui_consts.dart';
import '../../providers/landing_provider.dart';
import '../../providers/navigator_provider.dart';
import '../controls/buttons.dart';
import '../widgets/loading_ring.dart';

import 'package:flutter/material.dart' as m;

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
              SliverPersistentHeader(
                delegate: ScrollHeader(expandedHeight: 400),
              ),
              AppConsts.defaultVSpacer,
              DynamicListWidget(
                listData: landingProvider.collections,
                title: 'Собираем для вас',
              ),
              AppConsts.defaultVSpacer,
              DynamicListWidget(
                listData: landingProvider.promotions,
                title: 'Интересно сейчас',
                listType: ListType.wide,
                canMore: false,
              ),
              AppConsts.defaultVSpacer,
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
              Row(
                children: [
                  Text(
                    "Чарт",
                    style: AppStyle.subTitle(context),
                  ),
                  AppConsts.fillSpacer,
                  GButton(
                      onPressed: () {
                        AppRouter().gotoPlaylist(context, "", "", true);
                      },
                      title: "More")
                ],
              ),
              AppConsts.smallVSpacer,
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: TrackCard(
                              track: landingProvider.chart[index],
                              onPressed: () {},
                            ),
                          ),
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

class ScrollHeader extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  ScrollHeader({required this.expandedHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: expandedHeight,
      color: FluentTheme.of(context).accentColor.withOpacity(.5),
      child: Stack(
        children: [
          Center(
            child: Text(
              "МОЯ ВОЛНА",
              style: AppStyle.title(context),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: expandedHeight / 3,
            child: WaveWidget(
              config: CustomConfig(colors: [
                FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
                FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
                FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
                FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                FluentTheme.of(context).scaffoldBackgroundColor,
              ], durations: [
                9500,
                9600,
                9700,
                9800,
                9900,
                10000
              ], heightPercentages: [
                0.1,
                0.2,
                0.3,
                0.4,
                0.5,
                0.6
              ]),
              size: const Size(double.infinity, double.infinity),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: expandedHeight / 3,
              child: Transform.scale(
                scaleY: -1,
                alignment: Alignment.center,
                child: WaveWidget(
                  config: CustomConfig(colors: [
                    FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                    FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
                    FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
                    FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
                    FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                    FluentTheme.of(context).scaffoldBackgroundColor,
                  ], durations: [
                    9500,
                    9600,
                    9700,
                    9800,
                    9900,
                    10000
                  ], heightPercentages: [
                    0.1,
                    0.2,
                    0.3,
                    0.4,
                    0.5,
                    0.6
                  ]),
                  size: const Size(double.infinity, double.infinity),
                ),
              )),
          Opacity(opacity: 1-shrinkOffset/expandedHeight, child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 86),
                child: GButton(onPressed: () {

                  client.rotorStationTracks("user:onyourwave").then((value) {
                    context.read<YandexProvider>().startRadio(true, value.batchId!, "user:onyourwave");
                    context.read<NewPlaylist>().tracks = value.sequence!.select((e, _) => e.track,).toList();
                    context.read<NewPlaylist>().currentTrackIndex =  0;
                  });

                }, title: "воспроизвести"),
              )),),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 56;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
