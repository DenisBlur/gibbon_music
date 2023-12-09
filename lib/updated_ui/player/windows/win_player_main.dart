import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/updated_ui/player/windows/win_player_controls.dart';
import 'package:gibbon_music/updated_ui/player/windows/win_player_second_controls.dart';
import 'package:provider/provider.dart';

import 'win_player_info.dart';

class PlayerMain extends StatelessWidget {
  const PlayerMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color waveColors = Theme.of(context).colorScheme.primary;

    return Consumer<AudioProvider>(builder: (_, value, __) {
      if (value.currentTrack != null) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            margin: const EdgeInsets.all(16),
            width: AppConsts.pageSize(context).width,
            height: AppConsts.playerHeight,
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer, borderRadius: BorderRadius.circular(16), boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.5), offset: const Offset(0,4), blurRadius: 10)
            ]),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 30, sigmaX: 30),
                    child: SizedBox(
                      width: 250,
                      height: AppConsts.pageSize(context).width,
                    ),
                  ),
                ),
                const PlayerInfo(),
                const Center(
                  child: PlayerMainControl(),
                ),
                const PlayerSecondControl(),
              ],
            ),
          ),
        )
            .animate()
            .fadeIn(duration: AppConsts.slowAnimation, curve: AppConsts.defaultCurve)
            .moveY(begin: 150, end: 0, duration: AppConsts.defaultAnimation, curve: AppConsts.defaultCurve)
            .then()
            .shimmer(duration: 2500.ms, color: Theme.of(context).colorScheme.primary.withOpacity(.2));
      } else {
        return const SizedBox();
      }
    });
  }
}
