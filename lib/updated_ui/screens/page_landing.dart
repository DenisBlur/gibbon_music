import 'package:flutter/material.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:gibbon_music/enums/e_list_typer.dart';
import 'package:gibbon_music/main.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/router.dart';
import 'package:gibbon_music/updated_ui/widgets/custom_scaffold.dart';
import 'package:gibbon_music/updated_ui/widgets/dynamic_list.dart';
import 'package:gibbon_music/updated_ui/widgets/radio_widget.dart';
import 'package:gibbon_music/updated_ui/widgets/track_card.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:yam_api/enums.dart';
import 'package:yam_api/radio/setting2.dart';

import '../../constants/app_consts.dart';
import '../../providers/landing_provider.dart';
import '../widgets/loading_ring.dart';

class UPageLanding extends StatelessWidget {
  const UPageLanding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LandingProvider landingProvider = context.read();
    landingProvider.dispose();

    return FutureBuilder(
      future: landingProvider.init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CustomScaffold(
            children: [
              const RadioWidget(),

              AppConsts.defaultVSpacer,
              if (landingProvider.collections.isNotEmpty)
                DynamicListWidget(
                  listData: landingProvider.userPlaylists,
                  title: 'Ваши плейлисты',
                ),
              AppConsts.defaultVSpacer,
              if (landingProvider.playContext.isNotEmpty) DynamicListWidget(listData: landingProvider.playContext, title: 'Вы недавно слушали'),
              if (landingProvider.playContext.isNotEmpty) AppConsts.defaultVSpacer,
              if (landingProvider.collections.isNotEmpty)
                DynamicListWidget(
                  listData: landingProvider.collections,
                  title: 'Собираем для вас',
                ),
              if (landingProvider.collections.isNotEmpty) AppConsts.defaultVSpacer,
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
              Row(
                children: [
                  const Text(
                    "Чарт",
                  ),
                  AppConsts.fillSpacer,
                  FilledButton(
                      onPressed: () {
                        AppRouter().gotoPlaylist(context, "", "", true);
                      },
                      child: const Text("Смотреть всё"))
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
                                context.read<NewPlaylist>().setTracksWithActiveTrack("414787002:1076", QueueType.various, landingProvider.chart, index, true);
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
    Color waveColors = Theme.of(context).colorScheme.primary;

    return SizedBox(
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
              const Center(
                child: Text(
                  "МОЯ ВОЛНА",
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
              Opacity(
                opacity: 1 - shrinkOffset / expandedHeight,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 86),
                  child: FilledButton(
                      onPressed: () {
                        client.radio.createRadioSession();
                      },
                      child: const Text("воспроизвести")),
                )),
              ),
            ],
          ),
        ));
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 56;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
