import 'dart:ui';

import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/updated_ui/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:yam_api/enums.dart';
import 'package:yam_api/playlist/playlist.dart';

import '../../constants/app_consts.dart';
import '../../providers/audio_provider.dart';
import '../../providers/playlist_page_provider.dart';
import '../widgets/loading_ring.dart';
import '../widgets/track_card.dart';

class PagePlaylist extends StatelessWidget {
  const PagePlaylist({Key? key, required this.id, required this.kind, this.isChart}) : super(key: key);

  final String id;
  final String kind;
  final bool? isChart;

  @override
  Widget build(BuildContext context) {
    AudioProvider audioProvider = context.read();
    NewPlaylist playListProvider = context.read();
    PagePlaylistProvider pagePlaylistProvider = context.read();
    pagePlaylistProvider.dispose();

    return FutureBuilder(
        future: pagePlaylistProvider.init(uid: id, kind: kind, isChart: isChart),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            MPlaylist mPagePlaylist = pagePlaylistProvider.mPlaylist;

            return CustomScaffold(children: [
              SliverPersistentHeader(
                pinned: true,
                delegate: ScrollHeader(expandedHeight: 200, info: mPagePlaylist),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: TrackCard(
                              track: mPagePlaylist.tracks![index]!.track!,
                              onPressed: () {
                                playListProvider.setTracksWithActiveTrack("$id:$kind", QueueType.various,
                                    mPagePlaylist.tracks!
                                        .select(
                                          (e, _) => e?.track,
                                        )
                                        .toList(),
                                    index, true);
                                audioProvider.resume();
                              },
                            ),
                          ),
                      childCount: mPagePlaylist.tracks!.length)),
            ]);
          } else {
            return const LoadingRing();
          }
        });
  }
}

class ScrollHeader extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  ScrollHeader({required this.info, required this.expandedHeight});

  final MPlaylist info;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
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
                    child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, fit: BoxFit.cover, image: info.ogImage!.linkImage(200)),
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
            bottom: AppConsts.pageOffset.horizontal / 2,
            left: AppConsts.pageOffset.horizontal / 2,
            child: Transform.translate(
              offset: Offset(0, lerpDouble(0, -100, shrinkOffset / expandedHeight)!.toDouble()),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text("Плейлист", maxLines: 1, ),
                Text(info.title!, maxLines: 1, ),
                Text("Создатель: ${info.owner!.name}", maxLines: 1,),
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
                  children: [Text(info.title!, maxLines: 1, )],
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
