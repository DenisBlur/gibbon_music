import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/providers/ux_provider.dart';
import 'package:gibbon_music/router.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/playlist.dart';
import '../../../providers/audio_provider.dart';

class PlayerSecondControl extends StatelessWidget {
  const PlayerSecondControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;
    AudioProvider provider = context.watch();

    return Container(
      margin: const EdgeInsets.only(right: 32),
      width: pageSize.width,
      height: AppConsts.playerHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () async {
                context.read<UxProvider>().changeLyricState();
              },
              icon: Icon(context.watch<UxProvider>().isOpenLyric ? m.Icons.text_snippet_rounded : m.Icons.text_snippet_outlined, size: 24)),
          context.watch<NewPlaylist>().radio
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    context.read<UxProvider>().changePlaylistState();
                  },
                  icon: const Icon(m.Icons.playlist_play_rounded, size: 24)),
          AppConsts.smallHSpacer,
          AppConsts.smallHSpacer,
          IconButton(
              onPressed: () {
                AppRouter().openFullscreen(context);
              },
              icon: const Icon(m.Icons.fullscreen, size: 24)),
        ],
      ),
    );
  }
}
