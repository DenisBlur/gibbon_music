import 'package:darq/darq.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:gibbon_music/enums/e_list_typer.dart';
import 'package:gibbon_music/main.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/providers/playlist_provider.dart';
import 'package:gibbon_music/providers/radio_provider.dart';
import 'package:gibbon_music/providers/theme_provider.dart';
import 'package:gibbon_music/providers/yandex_provider.dart';
import 'package:gibbon_music/router.dart';
import 'package:gibbon_music/updated_ui/widgets/track_card.dart';
import 'package:gibbon_music/updated_ui/widgets/custom_scaffold.dart';
import 'package:gibbon_music/updated_ui/widgets/dynamic_list.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../constants/app_consts.dart';
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

    // WidgetsBinding.instance.addPostFrameCallback((_) => context.read<NavigatorProvider>().showOverlay(context));

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
                              onPressed: () {
                                context.read<NewPlaylist>().setTracksWithActiveTrack(landingProvider.chart, index);
                                context.read<AudioProvider>().resume();
                              },
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
    Color waveColors = FluentTheme.of(context).accentColor;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: expandedHeight,
      child: ShaderMask(
        shaderCallback: (bounds) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.1,
              0.5,
              0.9,
            ],
            colors: [Colors.transparent, Colors.black, Colors.transparent],
          ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height));
        },
          blendMode: BlendMode.dstIn,
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
              bottom: 1,
              height: expandedHeight / 3,
              child: WaveWidget(
                config: CustomConfig(colors: [
                  waveColors.withOpacity(0.1),
                  waveColors.withOpacity(0.2),
                  waveColors.withOpacity(0.4),
                  waveColors.withOpacity(0.6),
                  waveColors.withOpacity(0.8),
                  waveColors,
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
                      waveColors.withOpacity(0.1),
                      waveColors.withOpacity(0.2),
                      waveColors.withOpacity(0.4),
                      waveColors.withOpacity(0.6),
                      waveColors.withOpacity(0.8),
                      waveColors,
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
            // Opacity(opacity: 1-shrinkOffset/expandedHeight, child: Center(
            //     child: Padding(
            //       padding: const EdgeInsets.only(top: 86),
            //       child: GButton(onPressed: () {
            //         context.read<RadioProvider>().startRadio("user:onyourwave");
            //       }, title: "воспроизвести"),
            //     )),),
          ],
        ),
      )
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 56;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
