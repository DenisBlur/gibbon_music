import 'dart:io';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/router.dart';
import 'package:gibbon_music/ui/controls/buttons.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:yam_api/album/album.dart';
import 'package:yam_api/artist/artist.dart';
import 'package:yam_api/playlist/playlist.dart';
import 'package:flutter/material.dart' as m;

import '../../constants/ui_consts.dart';

class ScaffoldScroller extends StatelessWidget {
  const ScaffoldScroller({Key? key, required this.slivers, this.scrollHeaderModel, required this.padding}) : super(key: key);

  final ScrollHeaderContent? scrollHeaderModel;
  final List<Widget> slivers;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    List<Widget> paddingSlivers = [];

    for (var element in slivers) {
      paddingSlivers.add(SliverPadding(
        padding: padding,
        sliver: element,
      ));
    }

    paddingSlivers.insert(
      0,
      const SliverToBoxAdapter(
        child: SizedBox(height: AppConsts.windowHeader),
      ),
    );

    if (scrollHeaderModel != null) {
      paddingSlivers.insert(
        1,
        SliverPersistentHeader(
          pinned: true,
          delegate: ScrollHeader(expandedHeight: 200, pageModel: scrollHeaderModel?.pageModel),
        ),
      );
    }
    paddingSlivers.add(const SliverToBoxAdapter(
      child: SizedBox(height: AppConsts.playerHeight + 16),
    ));
    Widget content = CustomScrollView(
        controller: controller,
        physics: Platform.isAndroid ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
        slivers: paddingSlivers);

    return Padding(
      padding: EdgeInsets.only(left: 60, right: 60),
      child: ImprovedScrolling(
        scrollController: controller,
        enableCustomMouseWheelScrolling: true,
        customMouseWheelScrollConfig: const CustomMouseWheelScrollConfig(
          scrollAmountMultiplier: AppConsts.scrollMultiplier,
        ),
        child: FadeInUp(delay: Duration(milliseconds: 250), child: content),
      ),
    );
  }
}

class ScrollHeaderContent {
  final dynamic pageModel;

  ScrollHeaderContent({this.pageModel});
}

class ScrollHeader extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final dynamic pageModel;

  ScrollHeader({required this.expandedHeight, this.pageModel});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    Artist artist = Artist();
    Album album = Album();
    MPlaylist playlist = MPlaylist();

    String? title, image, imageBg, upTitle;
    Widget dynamicContent = const Text("none");

    if (pageModel != null) {
      if (pageModel is Artist) {
        artist = pageModel;
        title = artist.briefInfo!.name!;
        image = artist.briefInfo!.ogImage!.linkImage(100);
        imageBg = artist.briefInfo!.ogImage!.linkImage(600);
        upTitle = "Исполнитель";
        dynamicContent = Text(
          "${artist.stats!.lastMonthListeners.toString().spaceSeparateNumbers()} слушателя за месяц",
          style: TextStyle(fontSize: 14 - (shrinkOffset).clamp(0, 14), color: FluentTheme.of(context).uncheckedColor.withOpacity(.5)),
        );
      }
      if (pageModel is Album) {
        album = pageModel;
        title = album.title!;
        imageBg = album.ogImage!.linkImage(600);
        upTitle = "Альбом";
        dynamicContent = Row(
          children: [
            Text(
              "Исполнитель: ",
              style: TextStyle(fontSize: 14 - (shrinkOffset).clamp(0, 14), color: FluentTheme.of(context).uncheckedColor.withOpacity(.5)),
            ),
            GTextButton(
                onPressed: () {
                  AppRouter().gotoArtist(context, album.artists!.first.id);
                },
                title: "${album.artists!.first.name} • ${album.year}")
          ],
        );
      }
      if (pageModel is MPlaylist) {
        playlist = pageModel;
        title = playlist.title!;
        imageBg = playlist.ogImage!.linkImage(600);
        upTitle = "Плейлист";
        dynamicContent = Text(
          "Создатель: ${playlist.owner!.name}",
          style: TextStyle(fontSize: 14 - (shrinkOffset).clamp(0, 14), color: FluentTheme.of(context).uncheckedColor.withOpacity(.5)),
        );
      }
    }

    return FadeInDown(
        delay: const Duration(milliseconds: 450),
        child: ClipRRect(
          child: Stack(
            children: [
              Opacity(
                opacity: 1 - (shrinkOffset / expandedHeight),
                child: Transform.scale(
                  scaleY: .99,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: expandedHeight,
                      child: ClipRRect(
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
                          child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, fit: BoxFit.cover, image: imageBg.toString()),
                        ),
                      )),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: expandedHeight,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  FluentTheme.of(context).scaffoldBackgroundColor,
                  FluentTheme.of(context).scaffoldBackgroundColor.withOpacity((shrinkOffset / expandedHeight).clamp(0.5, 1))
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
              ),
              Positioned(
                  left: 16,
                  bottom: playlist.kind == null ? 8 : 16,
                  child: Row(
                    children: [
                      image != null
                          ? SizedBox(
                              width: (expandedHeight/shrinkOffset*40).clamp(40, 100),
                              height: (expandedHeight/shrinkOffset*40).clamp(40, 100),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: image),
                              ),
                            )
                          : const SizedBox(),
                      image != null ? AppConsts.defaultHSpacer : const SizedBox(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Opacity(
                            opacity: (1 - shrinkOffset / expandedHeight),
                            child: Text(
                              upTitle!,
                              style: TextStyle(
                                  fontSize: (14 - shrinkOffset).clamp(0, 14), color: FluentTheme.of(context).uncheckedColor.withOpacity(.5)),
                            ),
                          ),
                          Text(
                            title!,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: (expandedHeight/shrinkOffset*16).clamp(16, 32)),
                          ),
                          dynamicContent,
                        ],
                      ),
                    ],
                  )),
              Positioned(
                  right: 16,
                  bottom: 8,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GIconButton(
                          onPressed: () {},
                          icon: m.Icons.favorite_border_rounded,
                          contrastBackground: true,
                        ),
                        GIconButton(
                          onPressed: () {},
                          icon: m.Icons.favorite_border_rounded,
                          contrastBackground: true,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => AppConsts.windowHeader + 56;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
