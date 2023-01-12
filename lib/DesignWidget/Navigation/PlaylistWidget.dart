import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:gibbon_music/API/MainMethod/GMethod.dart';
import 'package:gibbon_music/DesignWidget/ListItems/TrackItem.dart';
import 'package:gibbon_music/DesignWidget/Styles/ConstValue.dart';
import 'package:gibbon_music/NewAPI/models/M_Track.dart';
import 'package:gibbon_music/main.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../API/NotifyModels/GeneralNotifyModel.dart';
import '../../API/NotifyModels/UxNotifyModel.dart';

class PlaylistWidget extends StatelessWidget {
  const PlaylistWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    return Consumer<UxNotifyModel>(
      builder: (context, value, child) {
        bool isOpenPlaylist = context.watch<UxNotifyModel>().isOpenPlaylist;
        var trackList = context.watch<GeneralNotifyModel>().mPlaylist;

        double top = isOpenPlaylist ? 60 : 44;
        double bottom = isOpenPlaylist ? 180 : 148;
        double right = isOpenPlaylist ? 16 : 0;
        double width = isOpenPlaylist ? 450 : 56;
        Color bgColor =
            isOpenPlaylist ? FluentTheme.of(context).cardColor.withOpacity(.5) : FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(1);

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
              child: AnimatedContainer(
                decoration: BoxDecoration(color: bgColor),
                duration: slowAnimation,
                child: ImprovedScrolling(
                  scrollController: controller,
                  enableCustomMouseWheelScrolling: true,
                  enableKeyboardScrolling: true,
                  customMouseWheelScrollConfig: const CustomMouseWheelScrollConfig(
                    scrollAmountMultiplier: scrollMultiplier,
                  ),
                  child: ListView.builder(
                    physics: scrollPhysics,
                    controller: controller,
                    itemBuilder: (context, index) {
                      return PlaylistTrack(
                        track: trackList[index],
                        stateHover: isOpenPlaylist,
                        index: index,
                      );
                    },
                    itemCount: trackList.length,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PlaylistTrack extends StatelessWidget {
  const PlaylistTrack({Key key, @required this.track, this.stateHover, @required this.index}) : super(key: key);

  final int index;
  final MTrack track;
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
          padding: EdgeInsets.all(isSelected || state.isHovering ? 4 : 0),
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(milliseconds: 350),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: FluentTheme.of(context).accentColor.withOpacity(state.isHovering || isSelected ? .4 : 0),
              border: Border.all(color: FluentTheme.of(context).borderInputColor.withOpacity(state.isHovering ? .4 : 0), width: .2)),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage, image: track.coverUri != null ? linkImage(track.coverUri, 80) : imagePlaceholder)),
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
