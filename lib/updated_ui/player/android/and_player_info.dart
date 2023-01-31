import 'package:audioplayers/audioplayers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/extensions/duration.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/updated_ui/widgets/ImageThumbnail.dart';
import 'package:provider/provider.dart';
import 'package:yam_api/track/track.dart';
import 'package:flutter/material.dart' as m;

import '../../../constants/app_consts.dart';
import '../../../domain/models/playlist.dart';
import '../../../providers/audio_provider.dart';
import '../../controls/buttons.dart';

class AndPlayerInfo extends StatelessWidget {
  const AndPlayerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioProvider provider = context.watch();
    NewPlaylist playList = context.watch();
    Track? track = playList.currentTrack;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppConsts.smallHSpacer,
            ImageThumbnail(url: track!.ogImage!.linkImage(200), width: 44, height: 44,),
            AppConsts.fillSpacer,
            GIconButton(
                onPressed: () {
                  if (provider.playerState == PlayerState.playing) {
                    provider.pause();
                  } else {
                    provider.resume();
                  }
                },
                icon: provider.icon(),
                size: 32),
            AppConsts.defaultHSpacer,
            GIconButton(
                onPressed: () {
                  playList.nextTrack();
                },
                icon: m.Icons.skip_next_rounded,
                size: 24),
          ],
        ),
      ],
    );
  }
}
