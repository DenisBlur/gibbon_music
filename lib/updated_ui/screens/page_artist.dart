import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/main.dart';
import 'package:gibbon_music/updated_ui/widgets/custom_scaffold.dart';
import 'package:gibbon_music/updated_ui/widgets/dynamic_list.dart';
import 'package:gibbon_music/updated_ui/widgets/loading_ring.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:yam_api/artist/artist.dart';
import 'package:yam_api/artist/brief_info.dart';
import 'package:yam_api/enums.dart';
import 'package:yam_api/track/track.dart';

import '../../constants/app_consts.dart';
import '../../domain/models/playlist.dart';
import '../../providers/artist_page_provider.dart';
import '../../providers/audio_provider.dart';
import '../../router.dart';
import '../widgets/track_card.dart';

class PageArtist extends StatelessWidget {
  const PageArtist({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    PageArtistProvider artistProvider = context.read();
    artistProvider.dispose();
    return FutureBuilder(
      future: artistProvider.init(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Artist mPageArtist = artistProvider.mArtist;
          List<Track> allTracks = [];
          Future getAllTracks() async {
            var data = await client.getArtistTracks(mPageArtist.briefInfo!.id!);
            allTracks = data.tracks!;
          }

          return CustomScaffold(children: [
            SliverPersistentHeader(
              pinned: true,
              delegate: ScrollHeader(
                  expandedHeight: 200, info: mPageArtist.briefInfo!, stats: mPageArtist.stats!.lastMonthListeners.toString().spaceSeparateNumbers()),
            ),
            const Text(
              "Популярные треки",
            ),
            AppConsts.defaultVSpacer,
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: TrackCard(
                            track: mPageArtist.popularTracks![index],
                            onPressed: () async {
                              if (allTracks.isEmpty) {
                                await getAllTracks();
                              }
                              context.read<NewPlaylist>().setTracksWithActiveTrack(id.toString(), QueueType.various, allTracks, index, true);
                              context.read<AudioProvider>().resume();
                            },
                          ),
                        ),
                    childCount: mPageArtist.popularTracks!.length)),
            AppConsts.defaultVSpacer,
            DynamicListWidget(
              listData: mPageArtist.albums!,
              title: "Популярные альбомы",
              onMore: () async {
                AppRouter().gotoMore(
                    context: context, title: "Альбомы ${mPageArtist.briefInfo!.name}", future: client.getArtistAlbums(mPageArtist.briefInfo!.id!));
              },
            ),
            AppConsts.defaultVSpacer,
            DynamicListWidget(
              listData: mPageArtist.playlists!,
              title: "Плейлисты",
            ),
            AppConsts.defaultVSpacer,
            DynamicListWidget(
              listData: mPageArtist.similarArtists!,
              title: "Похожие",
            )
          ]);
        } else {
          return const LoadingRing();
        }
      },
    );
  }
}

class ScrollHeader extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  ScrollHeader({required this.stats, required this.info, required this.expandedHeight});

  final BriefInfo info;
  final String stats;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    String image = info.ogImage!.isNotEmpty ? info.ogImage!.linkImage(200) : AppConsts.imageEmptyLink;
    return ClipRRect(
      child: Stack(
        children: [
          Transform.translate(
            offset: const Offset(0, -2),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: expandedHeight,
              child: ClipRRect(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
                  child: ShaderMask(
                    blendMode: BlendMode.dstIn,
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 0.8],
                        colors: [Colors.black, Colors.transparent],
                      ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height));
                    },
                    child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, fit: BoxFit.cover, image: image),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: expandedHeight,
          ),
          Positioned(
            width: 100,
            height: 100,
            bottom: AppConsts.pageOffset.horizontal / 2,
            left: AppConsts.pageOffset.horizontal / 2,
            child: Transform.translate(
                offset: Offset(0, lerpDouble(0, -100, shrinkOffset / expandedHeight)!.toDouble()),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: image,
                    width: AppConsts.pageSize(context).width,
                    height: AppConsts.pageSize(context).height,
                    fit: BoxFit.cover,
                  ),
                )),
          ),
          Positioned(
            top: (expandedHeight - shrinkOffset) - (100 + AppConsts.pageOffset.horizontal / 2),
            bottom: AppConsts.pageOffset.horizontal / 2,
            left: AppConsts.pageOffset.horizontal / 2 + 100 + 16,
            child: Transform.translate(
              offset: Offset(0, lerpDouble(0, -100, shrinkOffset / expandedHeight)!.toDouble()),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text(
                  "Исполнитель",
                  maxLines: 1,
                ),
                Text(info.name!, maxLines: 1,),
                Text(
                  "$stats слушателей за месяц",
                  maxLines: 1,
                ),
              ]),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: AppConsts.pageOffset.horizontal / 2,
            child: Center(
              child: Transform.translate(
                offset: Offset(0, lerpDouble(200, 0, shrinkOffset / expandedHeight)!.toDouble()),
                child: Row(
                  children: [
                    Text(info.name!, maxLines: 1, ),
                  ],
                ),
              ),
            ),
          ),
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
