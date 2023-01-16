import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/api/mainYamFunction.dart';
import 'package:gibbon_music/api/models/M_Track.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/ui/widgets/content_loader.dart';
import 'package:yam_api/yam_api.dart';

import '../../constants/ui_consts.dart';
import '../controls/buttons.dart';
import '../widgets/scroller_scaffold.dart';

/// Эта стриничка только для тестирования виджетов!

class PageTest extends StatelessWidget {
  const PageTest({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(YamApi.device);
    return ContentLoader(
      future: syncDevices(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          MTrack track = snapshot.data[0];
          List<MTrack> listTracks = snapshot.data[1];
          return ScaffoldScroller(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(track.title, style: AppStyle.trackHeaderStyle),
                    Text(listTracks.length.toString(), style: AppStyle.trackHeaderStyle),
                    const SizedBox(
                      height: 5000,
                    ),
                  ],
                ),
              ),
            ],
            padding: EdgeInsets.zero,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
