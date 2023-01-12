import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/api/models/M_Track.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/extensions/duration.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/ui/widgets/context_menu.dart';
import 'package:gibbon_music/ui/controls/buttons.dart';
import 'package:gibbon_music/ui/widgets/ImageThumbnail.dart';
import 'package:gibbon_music/ui/widgets/card_view.dart';
import 'package:flutter/material.dart' as m;
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
              Text(
                track.artists.first.name,
                style: AppStyle.subTrackHeaderStyle(context),
              )
            ],
          ),
          AppConsts.fillSpacer,
          const TrackCommandBar(),
        ],
      ),
    );
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
