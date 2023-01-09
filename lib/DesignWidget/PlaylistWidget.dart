import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/API/MainMethod/GMethod.dart';
import 'package:gibbon_music/API/Models/ArtistPage/MV_ArtistPage.dart';
import 'package:gibbon_music/API/Models/NotifyModels/GeneralNotifyModel.dart';
import 'package:gibbon_music/DesignWidget/ListItems/TrackItem.dart';
import 'package:gibbon_music/DesignWidget/Styles/ConstValue.dart';
import 'package:gibbon_music/main.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class PlaylistWidget extends StatelessWidget {
  const PlaylistWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverButton(
        onPressed: () {},
        builder: (p0, state) {
          double top = state.isHovering ? 60 : 44;
          double bottom = state.isHovering ? 192 : 180;
          double right = state.isHovering ? 16 : 0;
          double width = state.isHovering ? 300 : 56;
          Color bgColor = state.isHovering
              ? FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(.1)
              : FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(1);

          var trackList = context.watch<GeneralNotifyModel>().mPlaylist;

          return AnimatedContainer(
              width: width,
              height: MediaQuery.of(context).size.height - bottom,
              duration: slowAnimation,
              curve: Curves.fastLinearToSlowEaseIn,
              margin: EdgeInsets.only(top: top, right: right),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 50, sigmaX: 50),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return PlaylistTrack(
                          track: trackList[index],
                          stateHover: state.isHovering, index: index,
                        );
                      },
                      itemCount: trackList.length,
                    ),
                  )));
        });
  }
}

class PlaylistTrack extends StatelessWidget {
  const PlaylistTrack({Key key, @required this.track, this.stateHover, @required this.index}) : super(key: key);

  final int index;
  final Track track;
  final bool stateHover;

  @override
  Widget build(BuildContext context) {

    bool isSelected = context.watch<GeneralNotifyModel>().currentIndex == index;

    return HoverButton(
      onPressed: () {
        generalNotifyModel.playTrack(index);
      },
      builder: (p0, state) {
        return AnimatedContainer(
          margin: const EdgeInsets.only(top: 8, left: 8),
          height: stateHover ? 64 : 40,
          width: stateHover ? 64 : 40,
          padding: EdgeInsets.all(isSelected ? 4 : 0),
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(milliseconds: 350),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(isSelected ? 12 : 8),
              color: FluentTheme.of(context).cardColor.withOpacity(state.isHovering || isSelected ? .4 : 0),
              border: Border.all(color: FluentTheme.of(context).borderInputColor.withOpacity(state.isHovering ? .4 : 0), width: .2)),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: linkImage(track.coverUri, 80))),
              const SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(track.title),
                  ArtistsWidget(listArtists: track.artists),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
