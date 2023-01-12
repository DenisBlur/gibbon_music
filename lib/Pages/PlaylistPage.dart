import 'dart:io';
import 'dart:ui';

import 'package:darq/darq.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:gibbon_music/DesignWidget/GListView/PageScrollerWidget.dart';
import 'package:gibbon_music/DesignWidget/Styles/ConstValue.dart';
import 'package:gibbon_music/NewAPI/models/M_Track.dart';
import 'package:gibbon_music/NewAPI/models/PageModels/M_PagePlaylist.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../API/MainMethod/GMethod.dart';
import '../../DesignWidget/ListItems/TrackItem.dart';
import '../../NewAPI/mainYamFunction.dart';
import '../../main.dart';

class PlaylistPage extends StatelessWidget {
  PlaylistPage({Key key, @required this.playlistKind, @required this.playlistId}) : super(key: key);

  final int playlistKind;
  final String playlistId;
  final double hei = 250;

  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    MPagePlaylist mPagePlaylist;
    Future<void> getData() async {
      mPagePlaylist = await getPlaylist(playlistId.toString(), playlistKind);
    }

    return ScaffoldPage(
      padding: const EdgeInsets.all(0),
      content: SafeArea(
          child: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ScrollerWidget(slivers: [
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
                              placeholder: kTransparentImage, fit: BoxFit.cover, image: linkImage(mPagePlaylist.ogImage, 400)),
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
                            bottom: 56,
                            left: 16,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Плейлист", style: TextStyle(color: FluentTheme.of(context).borderInputColor)),
                                Text(mPagePlaylist.title, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                                Text("Создатель: ${mPagePlaylist.owner.name}", style: TextStyle(color: FluentTheme.of(context).borderInputColor)),
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
                            List<MTrack> tracks = mPagePlaylist.tracks.select((element, _) {
                              return element.track;
                            }).toList();
                            generalNotifyModel.mPlaylist = tracks;
                            generalNotifyModel.playTrack(index);
                          },
                          track: mPagePlaylist.tracks[index].track,
                          imageSize: 48,
                        ));
                  }, childCount: mPagePlaylist.tracks.length),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 150),
              )
            ],);
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
