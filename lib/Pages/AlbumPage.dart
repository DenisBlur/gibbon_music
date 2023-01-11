import 'dart:io';
import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:gibbon_music/DesignWidget/Styles/ConstValue.dart';
import 'package:gibbon_music/NewAPI/models/PageModels/M_PageAlbum.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../API/MainMethod/GMethod.dart';
import '../../DesignWidget/ListItems/TrackItem.dart';
import '../../NewAPI/mainYamFunction.dart';
import '../../main.dart';

class AlbumPage extends StatelessWidget {
  AlbumPage({Key key, @required this.albumId}) : super(key: key);

  final int albumId;
  final double hei = 250;

  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    MPageAlbum mPageAlbum;
    Future<void> getData() async {
      mPageAlbum = await getAlbum(albumId);
    }

    return ScaffoldPage(
      padding: const EdgeInsets.all(0),
      content: SafeArea(
          child: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
                padding: pageInsets,
                child: ImprovedScrolling(
                    scrollController: controller,
                    enableCustomMouseWheelScrolling: true,
                    customMouseWheelScrollConfig: const CustomMouseWheelScrollConfig(
                      scrollAmountMultiplier: scrollMultiplier,
                    ),
                    child: CustomScrollView(
                      controller: controller,
                      physics: Platform.isAndroid ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 36,
                              ),
                              Stack(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: hei,
                                    child: FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage, fit: BoxFit.cover, image: linkImage(mPageAlbum.coverUri, 400)),
                                  ),
                                  ClipRRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaY: 50, sigmaX: 50),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: hei,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(end: Alignment.topCenter, begin: Alignment.bottomCenter, colors: [
                                          FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(1),
                                          FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(.8)
                                        ])),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 16,
                                    left: 16,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: linkImage(mPageAlbum.coverUri, 150)),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 56,
                                      left: 198,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Альбом", style: TextStyle(color: FluentTheme.of(context).borderInputColor)),
                                          Text(mPageAlbum.title, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                                        ],
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate((context, index) {
                              return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: TrackItem(
                                    callback: () {
                                      generalNotifyModel.mPlaylist = mPageAlbum.volumes;
                                      generalNotifyModel.playTrack(index);
                                    },
                                    track: mPageAlbum.volumes[index],
                                    imageSize: 48,
                                  ));
                            }, childCount: mPageAlbum.volumes.length),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(height: 150),
                        )
                      ],
                    )));
          } else {
            return const Center(
              child: ProgressRing(),
            );
          }
        },
      )),
    );
  }
}
