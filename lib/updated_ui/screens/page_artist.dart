import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/updated_ui/widgets/ImageThumbnail.dart';
import 'package:gibbon_music/updated_ui/widgets/custom_scaffold.dart';
import 'package:gibbon_music/updated_ui/widgets/dynamic_list.dart';
import 'package:gibbon_music/updated_ui/widgets/loading_ring.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:yam_api/artist/artist.dart';
import 'package:yam_api/artist/brief_info.dart';

import '../../constants/ui_consts.dart';
import '../../providers/artist_page_provider.dart';
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
          return CustomScaffold(children: [
            SliverPersistentHeader(
              pinned: true,
              delegate: ScrollHeader(
                  expandedHeight: 200, info: mPageArtist.briefInfo!, stats: mPageArtist.stats!.lastMonthListeners.toString().spaceSeparateNumbers()),
            ),
            Text(
              "Популярные треки",
              style: AppStyle.subTitle(context),
            ),
            AppConsts.defaultVSpacer,
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: TrackCard(
                            track: mPageArtist.popularTracks![index],
                            onPressed: () {},
                          ),
                        ),
                    childCount: mPageArtist.popularTracks!.length)),
            AppConsts.defaultVSpacer,
            DynamicListWidget(
              listData: mPageArtist.albums!,
              title: "Альбомы",
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
                    child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, fit: BoxFit.cover, image: info.cover!.uri!.linkImage(200)),
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
            width: 100,
            height: 100,
            bottom: AppConsts.pageOffset.horizontal/2,
            left: AppConsts.pageOffset.horizontal/2,
            child: Transform.translate(
              offset: Offset(0, lerpDouble(0, -100, shrinkOffset / expandedHeight)!.toDouble()),
              child: ImageThumbnail(
                url: info.cover!.uri!.linkImage(200),
                width: 100,
                height: 100,
                radius: 100,
              ),
            ),
          ),
          Positioned(
            top: (expandedHeight - shrinkOffset) - (100 + AppConsts.pageOffset.horizontal/2),
            bottom: AppConsts.pageOffset.horizontal/2,
            left: AppConsts.pageOffset.horizontal/2 + 100 + 16,
            child: Transform.translate(
              offset: Offset(0, lerpDouble(0, -100, shrinkOffset / expandedHeight)!.toDouble()),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Исполнитель", maxLines: 1, style: TextStyle(color: FluentTheme.of(context).uncheckedColor.withOpacity(.5))),
                Text(info.name!, maxLines: 1, style: AppStyle.title(context)),
                Text("$stats слушателей за месяц", maxLines: 1, style: TextStyle(color: FluentTheme.of(context).uncheckedColor.withOpacity(.5))),
              ]),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: AppConsts.pageOffset.horizontal/2,
            child: Center(
              child: Transform.translate(
                offset: Offset(0, lerpDouble(200, 0, shrinkOffset / expandedHeight)!.toDouble()),
                child: Row(
                  children: [
                    Text(info.name!, maxLines: 1, style: AppStyle.title(context)),
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