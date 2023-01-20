import 'dart:io';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/providers/playlist_provider.dart';
import 'package:gibbon_music/ui/widgets/player/player_controls.dart';
import 'package:gibbon_music/ui/widgets/player/player_second_controls.dart';
import 'package:provider/provider.dart';
import 'package:yam_api/track/track.dart';

import '../playlist.dart';
import '../track_card.dart';
import 'player_info.dart';

class PlayerMain extends StatefulWidget {
  const PlayerMain({Key? key}) : super(key: key);

  @override
  State<PlayerMain> createState() => _PlayerMainState();
}

class _PlayerMainState extends State<PlayerMain> {
  double height = AppConsts.playerHeight;
  double coefAnimation = 0.0;

  @override
  Widget build(BuildContext context) {
    var wHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Consumer<AudioProvider>(builder: (_, value, __) {
      if (value.currentTrack != null) {
        return FadeInUp(
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              if (Platform.isAndroid) {
                setState(() {
                  height = (height + (details.delta.dy * -1)).clamp(AppConsts.playerHeight, wHeight);
                  coefAnimation = (height - AppConsts.playerHeight) / (wHeight - AppConsts.playerHeight);
                });
              }
            },
            onVerticalDragEnd: (details) {
              if (Platform.isAndroid) {
                var velocityInverse = (details.primaryVelocity! * -1);
                setState(() {
                  if (velocityInverse.abs() > 250) {
                    if (velocityInverse.isNegative) {
                      height = AppConsts.playerHeight;
                    } else {
                      height = wHeight;
                    }
                  } else {
                    if (height < (wHeight / 2)) {
                      height = AppConsts.playerHeight;
                    } else {
                      height = wHeight;
                    }
                  }
                  coefAnimation = (height - AppConsts.playerHeight) / (wHeight - AppConsts.playerHeight);
                });
              }
            },
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 25, sigmaX: 25),
                child: AnimatedContainer(
                  duration: AppConsts.defaultAnimation,
                  curve: AppConsts.defaultCurve,
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  height: height,
                  color: FluentTheme
                      .of(context)
                      .cardColor
                      .withOpacity(.4),
                  child: Stack(
                      children: [
                      PlayerInfo(animationCoef: coefAnimation),
                  const Align(
                    alignment: Alignment.center,
                    child: PlayerMainControl(),
                  ),
                  Platform.isWindows ? const PlayerSecondControl() : Transform.translate(
                    offset: Offset(0, lerpDouble(126, 0, coefAnimation)!.toDouble()), child: const Align(alignment: Alignment.bottomCenter, child: PlaylistSheet())),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}

class PlaylistSheet extends StatefulWidget {
  const PlaylistSheet({Key? key}) : super(key: key);

  @override
  State<PlaylistSheet> createState() => _PlaylistSheetState();
}

class _PlaylistSheetState extends State<PlaylistSheet> {

  double height = AppConsts.playerHeight;
  double coefAnimation = 0.0;

  @override
  Widget build(BuildContext context) {
    var wHeight = MediaQuery
        .of(context)
        .size
        .height;
    var wWidth = MediaQuery
        .of(context)
        .size
        .width;

    PlayListProvider playListProvider = context.watch();

    List<Track?>? tracks = playListProvider.queue;

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        setState(() {
          height = (height + (details.delta.dy * -1)).clamp(AppConsts.playerHeight, wHeight);
          coefAnimation = (height - AppConsts.playerHeight) / (wHeight - AppConsts.playerHeight);
        });
      },
      onVerticalDragEnd: (details) {
        var velocityInverse = (details.primaryVelocity! * -1);
        setState(() {
          if (velocityInverse.abs() > 250) {
            if (velocityInverse.isNegative) {
              height = AppConsts.playerHeight;
            } else {
              height = wHeight;
            }
          } else {
            if (height < (wHeight / 2)) {
              height = AppConsts.playerHeight;
            } else {
              height = wHeight;
            }
          }
          coefAnimation = (height - AppConsts.playerHeight) / (wHeight - AppConsts.playerHeight);
        });
      },
      child: ClipRRect(
        child: AnimatedContainer(
          width: wWidth,
          duration: AppConsts.defaultAnimation,
          curve: AppConsts.defaultCurve,
          padding: const EdgeInsets.only(left: 16, right: 16),
          height: height,
          decoration: BoxDecoration(
              color: FluentTheme
                  .of(context)
                  .cardColor,
              borderRadius: const BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16))),
          child: ListView.builder(
            itemBuilder: (context, index) => Padding(padding: const EdgeInsets.only(bottom: 8), child: TrackCard(
              track: tracks![index]!,
              onPressed: () => playListProvider.setCurrentTrack(index),
            ),),
            itemCount: tracks!.length,
          ),
        ),
      ),
    );
  }
}
