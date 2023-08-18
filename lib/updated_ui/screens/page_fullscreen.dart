import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart' as mp;
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/updated_ui/player/windows/win_player_controls.dart';
import 'package:gibbon_music/updated_ui/widgets/Image_thumbnail.dart';
import 'package:gibbon_music/updated_ui/widgets/playlist_widget.dart';
import 'package:gibbon_music/updated_ui/widgets/track_card.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:yam_api/track/track.dart';

import '../../constants/style_consts.dart';
import '../../domain/models/playlist.dart';
import '../../main.dart';
import '../../providers/audio_provider.dart';
import '../widgets/header.dart';
import '../widgets/lyric_widget.dart';

class PageFullscreen extends StatelessWidget {
  const PageFullscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewPlaylist playlist = context.watch();
    Track? track = playlist.currentTrack;
    Color waveColors = FluentTheme.of(context).accentColor;

    return ScaffoldPage(
      padding: const EdgeInsets.all(0),
      content: Stack(
        children: [
          if (track!.backgroundVideoUri != null && track.backgroundVideoUri != " " && track.backgroundVideoUri != "")
            Opacity(
              opacity: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  child: mp.MeeduVideoPlayer(
                    controller: meeduPlayerController,
                  ),
                ),
              ),
            ),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 1500, sigmaX: 1500),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(24, 24, 24, .5),
                ),
                height: AppConsts.pageSize(context).height,
                width: AppConsts.pageSize(context).width,
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: context.watch<NewPlaylist>().radio ? 1 : 0,
            duration: AppConsts.slowAnimation,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: WaveWidget(
                config: CustomConfig(colors: [
                  waveColors.withOpacity(0.1),
                  waveColors.withOpacity(0.2),
                  waveColors.withOpacity(0.4),
                  waveColors.withOpacity(0.6),
                  waveColors,
                ], durations: [
                  9600,
                  9700,
                  9800,
                  9900,
                  10000
                ], heightPercentages: [
                  0.2,
                  0.3,
                  0.4,
                  0.5,
                  0.6
                ]),
                size: const Size(double.infinity, double.infinity),
              ),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    ImageThumbnail(
                        url: track.ogImage!.linkImage(600),
                        width: AppConsts.pageSize(context).width / 4,
                        height: AppConsts.pageSize(context).width / 4),
                    LyricWidget(),
                  ],
                ),
                SizedBox(
                  width: AppConsts.pageSize(context).width / 4,
                  child: Text(
                    track.title!,
                    style: AppStyle.title(context),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  width: AppConsts.pageSize(context).width / 4,
                  child: ArtistsListWidgets(
                    track: track,
                  ),
                ),
                AppConsts.defaultVSpacer,
                const PlayerMainControl(),
              ],
            ),
          ),
          const UPlaylistWidget(),
          const Header(menu: false),
        ],
      ).animate(delay: 500.ms).fadeIn().moveY(begin: 150, end: 0, curve: AppConsts.defaultCurve, duration: 1500.ms),
    );
  }
}
