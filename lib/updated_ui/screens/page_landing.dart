import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/rendering.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:gibbon_music/enums/e_list_typer.dart';
import 'package:gibbon_music/main.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/router.dart';
import 'package:gibbon_music/updated_ui/widgets/custom_scaffold.dart';
import 'package:gibbon_music/updated_ui/widgets/dynamic_list.dart';
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
    Color waveColors = FluentTheme.of(context).accentColor;

    LandingProvider landingProvider = context.read();
    landingProvider.dispose();

    return FutureBuilder(
      future: landingProvider.init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CustomScaffold(
            children: [
              const Text(
                "Главная",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
              AppConsts.defaultVSpacer,
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          FluentTheme.of(context).cardColor,
                          FluentTheme.of(context).cardColor.withOpacity(.1),
                        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(8)),
                    width: AppConsts.pageSize(context).width / 3,
                    height: 350,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: WaveWidget(
                            config: CustomConfig(colors: [
                              waveColors.withOpacity(0.1),
                              waveColors.withOpacity(0.2),
                              waveColors.withOpacity(0.4),
                              waveColors.withOpacity(0.6),
                              waveColors,
                            ], durations: [
                              9600,
                              9700,
                              9800,
                              9900,
                              10000
                            ], heightPercentages: [
                              0.2,
                              0.3,
                              0.4,
                              0.5,
                              0.6
                            ]),
                            size: const Size(double.infinity, double.infinity),
                          ),
                        ),
                        Container(
                          width: AppConsts.pageSize(context).width,
                          height: 350,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.black.withOpacity(.25),
                                Colors.black,
                              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: AppConsts.pageSize(context).width / 3,
                            ),
                            const Text(
                              "МОЯ ВОЛНА",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            AppConsts.defaultVSpacer,
                            Button(
                                onPressed: () async {
                                  await context.read<NewPlaylist>().startRadio();
                                },
                                child: const Text("воспроизвести")),
                            Button(
                                onPressed: () async {
                                  await client.radio.sendRotorStationSetting(
                                      radioDiversity: RadioDiversity.defaultDiversity,
                                      radioMoodEnergy: RadioMoodEnergy.all,
                                      radioLanguage: RadioLanguage.any);
                                },
                                child: const Text("тест")),
                            SizedBox(
                              width: AppConsts.pageSize(context).width,
                              height: 26,
                              child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return FilledButton(
                                      child: Text(RadioDiversity.values[index].name),
                                      onPressed: () async {
                                        await context.read<NewPlaylist>().updateRadio(radioDiversity: RadioDiversity.values[index]);
                                      },
                                    );
                                  },
                                  itemCount: RadioDiversity.values.length-1,
                                  scrollDirection: Axis.horizontal),
                            ),
                            SizedBox(
                              width: AppConsts.pageSize(context).width,
                              height: 26,
                              child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return FilledButton(
                                      child: Text(RadioMoodEnergy.values[index].name),
                                      onPressed: () async {
                                        await context.read<NewPlaylist>().updateRadio(radioMoodEnergy: RadioMoodEnergy.values[index]);
                                      },
                                    );
                                  },
                                  itemCount: RadioMoodEnergy.values.length-1,
                                  scrollDirection: Axis.horizontal),
                            ),
                            SizedBox(
                              width: AppConsts.pageSize(context).width,
                              height: 26,
                              child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return FilledButton(
                                      child: Text(RadioLanguage.values[index].name),
                                      onPressed: () async {
                                        await context.read<NewPlaylist>().updateRadio(radioLanguage: RadioLanguage.values[index]);
                                      },
                                    );
                                  },
                                  itemCount: RadioLanguage.values.length-1,
                                  scrollDirection: Axis.horizontal),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  AppConsts.bigHSpacer,
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        FluentTheme.of(context).accentColor.light,
                        FluentTheme.of(context).accentColor.darkest,
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 350,
                    height: 350,
                  ),
                  AppConsts.smallHSpacer,
                ],
              ),
              AppConsts.defaultVSpacer,
              if (landingProvider.collections.isNotEmpty)
                DynamicListWidget(
                  listData: landingProvider.userPlaylists,
                  title: 'Ваши плейлисты',
                ),
              AppConsts.defaultVSpacer,
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
              if (landingProvider.playContext.isNotEmpty) DynamicListWidget(listData: landingProvider.playContext, title: 'Вы недавно слушали'),
              if (landingProvider.playContext.isNotEmpty) AppConsts.defaultVSpacer,
              Row(
                children: [
                  Text(
                    "Чарт",
                    style: AppStyle.subTitle(context),
                  ),
                  AppConsts.fillSpacer,
                  Button(
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
                                context.read<NewPlaylist>().setTracksWithActiveTrack(landingProvider.chart, index, true);
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
              Opacity(
                opacity: 1 - shrinkOffset / expandedHeight,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 86),
                  child: Button(
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
