import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/providers/ux_provider.dart';
import 'package:gibbon_music/updated_ui/widgets/context_widget.dart';
import 'package:gibbon_music/updated_ui/widgets/drawer.dart';
import 'package:gibbon_music/updated_ui/utils/ui_utils.dart';
import 'package:gibbon_music/updated_ui/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../player/android/and_player_main.dart';
import '../player/windows/win_player_main.dart';
import 'playlist_widget.dart';

class OverlayContainer extends StatelessWidget {
  const OverlayContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          const UPlaylistWidget(),
          Responsive.isDesktop(context) ? const DrawerWidget() : const SizedBox(),
          const Header(),
          if(Platform.isWindows) const Align(
              alignment: Alignment.bottomCenter,
              child: PlayerMain()),
          if(Platform.isAndroid) AndPlayerMain(
            maxHeight: AppConsts.pageSize(context).height,
          ),
          const ContextWidget(),
        ],
      ),
    );
  }
}
