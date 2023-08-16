import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/updated_ui/widgets/custom_scaffold.dart';
import 'package:gibbon_music/updated_ui/widgets/loading_ring.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:yam_api/album/album.dart';

import '../../constants/style_consts.dart';
import '../../providers/album_page_provider.dart';
import '../../providers/audio_provider.dart';
import '../../router.dart';
import '../widgets/track_card.dart';

class PageAlbum extends StatelessWidget {
  const PageAlbum({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    AudioProvider audioProvider = context.read();
    NewPlaylist playListProvider = context.read();
    PageAlbumProvider albumProvider = context.read();
    albumProvider.dispose();

    return SafeArea(
        child: ScaffoldPage(
            padding: const EdgeInsets.all(0),
            content: FutureBuilder(
              future: albumProvider.init(id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Album mPageAlbum = albumProvider.mAlbum;
                  return CustomScaffold(children: [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: ScrollHeader(expandedHeight: 200, info: mPageAlbum),
                    ),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: TrackCard(
                                    track: mPageAlbum.volumes![index],
                                    onPressed: () {
                                      // playListProvider.
                                      playListProvider.setTracksWithActiveTrack(mPageAlbum.volumes!, index);
                                      audioProvider.resume();
                                    },
                                  ),
                                ),
                            childCount: mPageAlbum.volumes!.length)),
                  ]);
                } else {
                  return const LoadingRing();
                }
              },
            )));
  }
}

class ScrollHeader extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  ScrollHeader({required this.info, required this.expandedHeight});

  final Album info;

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
          Container(
            width: MediaQuery.of(context).size.width,
            height: expandedHeight,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              FluentTheme.of(context).inactiveBackgroundColor.withOpacity(shrinkOffset / expandedHeight),
              FluentTheme.of(context).inactiveBackgroundColor.withOpacity(lerpDouble(0.5, 1.0, shrinkOffset / expandedHeight)!.toDouble())
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
          ),
          Positioned(
            bottom: AppConsts.pageOffset.horizontal / 2,
            left: AppConsts.pageOffset.horizontal / 2,
            child: Transform.translate(
              offset: Offset(0, lerpDouble(0, -100, shrinkOffset / expandedHeight)!.toDouble()),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text(
                  "Альбом",
                  maxLines: 1,
                ),
                Text(info.title!, maxLines: 1, style: AppStyle.title(context)),
                Row(
                  children: [
                    const Text(
                      "Исполнитель: ",
                    ),
                    Button(
                        onPressed: () {
                          AppRouter().gotoArtist(context, info.artists!.first.id);
                        },
                        child: Text("${info.artists!.first.name} • ${info.year}"))
                  ],
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
