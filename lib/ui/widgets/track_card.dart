import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/api/models/InnerModel/M_InnerArtist.dart';
import 'package:gibbon_music/api/models/M_Track.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/extensions/duration.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/router.dart';
import 'package:gibbon_music/ui/widgets/context_menu.dart';
import 'package:gibbon_music/ui/controls/buttons.dart';
import 'package:gibbon_music/ui/widgets/ImageThumbnail.dart';
import 'package:gibbon_music/ui/widgets/card_view.dart';
import 'package:flutter/material.dart' as m;
import 'package:go_router/go_router.dart';
import '../../constants/style_consts.dart';

class TrackCard extends StatelessWidget {
  const TrackCard({Key key, @required this.track}) : super(key: key);

  final MTrack track;

  @override
  Widget build(BuildContext context) {
    return GCardView(
      onPressed: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ImageThumbnail(url: track.coverUri.linkImage(200)),
          AppConsts.defaultHSpacer,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                track.title,
                style: AppStyle.trackHeaderStyle,
              ),
              ArtistsListWidgets(key: key, mInnerArtistList: track.artists,)
            ],
          ),
          AppConsts.fillSpacer,
          const TrackCommandBar(),
        ],
      ),
    );
  }
}

class ArtistsListWidgets extends StatelessWidget {
  const ArtistsListWidgets({Key key, @required this.mInnerArtistList}) : super(key: key);

  final List<MInnerArtist> mInnerArtistList;

  @override
  Widget build(BuildContext context) {
    List<Widget> artistButtonList = [];
    String fullTitle = "";

    for (int i = 0; i < mInnerArtistList.length; i++) {
      String title = "";
      var element = mInnerArtistList[i];
      if (i == 0) {
        title = element.name;
        fullTitle = element.name;
      } else {
        title = ", ${element.name}";
        fullTitle = fullTitle + title;
      }
      artistButtonList.add(GTextButton(
        onPressed: () {
          if (fullTitle.length > 20) Navigator.pop(context);
          AppRouter().gotoArtist(context, element.id);
        },
        title: title,
      ));
    }

    if (fullTitle.length > 20) {
      fullTitle = "${fullTitle.substring(0, 17)}...";
      return GestureDetector(
          onTapDown: (details) {
            AppContext.showContext(context, details, artistButtonList);
          },
          child: GTextButton(onPressed: null, title: fullTitle));
    } else {
      return Row(
        children: artistButtonList,
      );
    }

    return const Placeholder();
  }
}

class TrackCommandBar extends StatelessWidget {
  const TrackCommandBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GIconButton(
          onPressed: () {},
          icon: m.Icons.favorite_border_rounded,
        ),
        AppConsts.smallHSpacer,
        GestureDetector(
          onTapDown: (details) => AppContext.showContext(context, details, [Text("Hello!")]),
          child: GIconButton(
            onPressed: () {},
            icon: m.Icons.more_horiz_rounded,
          ),
        ),
        AppConsts.defaultHSpacer,
        Text(const Duration(milliseconds: 88442).toHms()),
      ],
    );
  }
}
