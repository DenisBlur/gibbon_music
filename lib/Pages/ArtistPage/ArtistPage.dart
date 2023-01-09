import 'dart:io';
import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:gibbon_music/API/MainMethod/GMethod.dart';
import 'package:gibbon_music/API/YAM_Functions.dart';
import 'package:gibbon_music/DesignWidget/GButtons.dart';
import 'package:gibbon_music/DesignWidget/GStyles.dart';
import 'package:gibbon_music/DesignWidget/ListItems/AAPItem.dart';
import 'package:gibbon_music/DesignWidget/ListItems/TrackItem.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../API/Models/ArtistPage/MV_ArtistPage.dart';

class ArtistPage extends StatelessWidget {
  ArtistPage({Key key, @required this.artistId}) : super(key: key);

  final int artistId;
  final double hei = 250;

  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    MvArtistPage artistPage;
    Future<void> getData() async {
      artistPage = await getYamApiArtist(artistId);
    }

    return ScaffoldPage(
      padding: const EdgeInsets.all(0),
      content: SafeArea(
          child: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
                padding: EdgeInsets.only(
                    left: Platform.isAndroid ? 0 : 72,
                    right: Platform.isAndroid ? 0 : 16),
                child: ImprovedScrolling(
                    scrollController: controller,
                    enableCustomMouseWheelScrolling: true,
                    customMouseWheelScrollConfig:
                        const CustomMouseWheelScrollConfig(
                      scrollAmountMultiplier: 45.0,
                    ),
                    child: CustomScrollView(
                      controller: controller,
                      physics: const NeverScrollableScrollPhysics(),
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
                                        placeholder: kTransparentImage,
                                        fit: BoxFit.cover,
                                        image: linkImage(
                                            artistPage.artist.ogImage, 400)),
                                  ),
                                  ClipRRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaY: 50, sigmaX: 50),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: hei,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                end: Alignment.topCenter,
                                                begin: Alignment.bottomCenter,
                                                colors: [
                                              FluentTheme.of(context)
                                                  .scaffoldBackgroundColor
                                                  .withOpacity(1),
                                              FluentTheme.of(context)
                                                  .scaffoldBackgroundColor
                                                  .withOpacity(.8)
                                            ])),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 16,
                                    left: 16,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: FadeInImage.memoryNetwork(
                                          placeholder: kTransparentImage,
                                          image: linkImage(
                                              artistPage.artist.ogImage, 150)),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 56,
                                      left: 198,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Исполнитель",
                                              style: TextStyle(
                                                  color: FluentTheme.of(context)
                                                      .borderInputColor)),
                                          Text(artistPage.artist.name,
                                              style: const TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold)),
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
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                              return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: TrackItem(
                                    track: artistPage.popularTracks[index],
                                    imageSize: 48,
                                  ));
                            }, childCount: artistPage.popularTracks.length),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 16, bottom: 16),
                            child:
                                Text("Популярные альбомы", style: titleTextStyle),
                          ),
                        ),
                        // SliverPadding(
                        //   padding: const EdgeInsets.only(left: 16, right: 16),
                        //   sliver: SliverList(
                        //     delegate:
                        //     SliverChildBuilderDelegate((context, index) {
                        //       return Padding(
                        //           padding: const EdgeInsets.only(bottom: 16),
                        //           child: AAPItem(
                        //             playContext: ,
                        //             index: index,
                        //           ));
                        //     }, childCount: artistPage.albums.length),
                        //   ),
                        // ),
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
