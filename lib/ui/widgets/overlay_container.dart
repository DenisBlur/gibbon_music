import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/ui/widgets/drawer.dart';
import 'package:gibbon_music/ui/widgets/player/player_main.dart';
import 'package:gibbon_music/ui/widgets/playlist.dart';
import 'package:gibbon_music/ui/widgets/window_header.dart';
import 'package:provider/provider.dart';
import '../../constants/ui_consts.dart';
import '../../providers/audio_provider.dart';

class OverlayContainer extends StatelessWidget {
  const OverlayContainer({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioProvider audioProvider = context.read();
    audioProvider.init();
    return Stack(
      children: [
        const WindowHeader(setting: false),
        const Positioned(bottom: 0, right: 0, left: 0, child: PlayerMain()),
        const Positioned(top: AppConsts.windowHeader , bottom: AppConsts.playerHeight, left: 0, child: DrawerWidget()),
        Positioned(
          top: AppConsts.windowHeader,
          height: MediaQuery.of(context).size.height - (AppConsts.playerHeight + (AppConsts.windowHeader)),
          right: 0,
          child: const PlaylistWidget(),
        ),
      ],
    );
  }
}
