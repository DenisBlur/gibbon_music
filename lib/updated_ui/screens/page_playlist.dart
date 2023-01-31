import 'dart:ui';

import 'package:darq/darq.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/updated_ui/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:yam_api/playlist/playlist.dart';

import '../../constants/style_consts.dart';
import '../../constants/app_consts.dart';
import '../../providers/audio_provider.dart';
import '../../providers/playlist_page_provider.dart';
import '../../providers/playlist_provider.dart';
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
                delegate: ScrollHeader(
                    expandedHeight: 200, info: mPagePlaylist),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                          (context, index) => Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: TrackCard(
                          track: mPagePlaylist.tracks![index]!.track!,
                          onPressed: () {
                            playListProvider.setTracksWithActiveTrack(mPagePlaylist.tracks!.select((e, _) => e?.track,).toList(), index);
                            audioProvider.resume();
                          },
                        ),
                      ),
                      childCount: mPagePlaylist.tracks!.length)),
            ]);
          } else {
            return LoadingRing();
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
                    child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, fit: BoxFit.cover, image: info.ogImage!.linkImage(200)),
                  ),
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: expandedHeight,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              FluentTheme.of(context).scaffoldBackgroundColor,
              FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(lerpDouble(0.5, 1.0, shrinkOffset / expandedHeight)!.toDouble())
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
          ),
          Positioned(
            bottom: AppConsts.pageOffset.horizontal / 2,
            left: AppConsts.pageOffset.horizontal / 2,
            child: Transform.translate(
              offset: Offset(0, lerpDouble(0, -100, shrinkOffset / expandedHeight)!.toDouble()),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Плейлист", maxLines: 1, style: TextStyle(color: FluentTheme.of(context).uncheckedColor.withOpacity(.5))),
                Text(info.title!, maxLines: 1, style: AppStyle.title(context)),
                Text("Создатель: ${info.owner!.name}", maxLines: 1, style: TextStyle(color: FluentTheme.of(context).uncheckedColor.withOpacity(.5))),
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
                  children: [Text(info.title!, maxLines: 1, style: AppStyle.title(context))],
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
