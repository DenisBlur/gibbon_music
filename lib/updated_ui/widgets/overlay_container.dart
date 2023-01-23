

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/updated_ui/widgets/drawer.dart';
import 'package:gibbon_music/updated_ui/utils/ui_utils.dart';
import 'package:gibbon_music/updated_ui/widgets/header.dart';

import '../player/player_main.dart';
import 'playlist_widget.dart';
class OverlayContainer extends StatelessWidget {
  const OverlayContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Stack(
      children: [
        const Header(),
        const UPlaylistWidget(),
        const Align(alignment: Alignment.bottomCenter, child: PlayerMain()),
        Responsive.isDesktop(context)
            ? const DrawerWidget()
            : const SizedBox(),
      ],
    ),);
  }
}
