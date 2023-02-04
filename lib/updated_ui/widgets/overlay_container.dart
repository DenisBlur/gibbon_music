import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/providers/navigator_provider.dart';
import 'package:gibbon_music/updated_ui/screens/page_landing.dart';
import 'package:gibbon_music/updated_ui/utils/ui_utils.dart';
import 'package:gibbon_music/updated_ui/widgets/context_widget.dart';
import 'package:gibbon_music/updated_ui/widgets/drawer.dart';
import 'package:gibbon_music/updated_ui/widgets/header.dart';
import 'package:provider/provider.dart';

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
          Positioned(height: AppConsts
              .pageSize(context)
              .height, width: AppConsts
              .pageSize(context)
              .width, child: const NavigationSystem(),),
          const UPlaylistWidget(),
          Responsive.isDesktop(context) ? const DrawerWidget() : const SizedBox(),
          const Header(),
          if(Platform.isWindows) const Align(
              alignment: Alignment.bottomCenter,
              child: PlayerMain()),
          if(Platform.isAndroid) AndPlayerMain(
            maxHeight: AppConsts
                .pageSize(context)
                .height - 30,
          ),
        ],
      ),
    );
  }
}


class NavigationSystem extends StatelessWidget {
  const NavigationSystem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    late Widget page;

    return Navigator(
      key: context.watch<NavigatorProvider>().navigatorKey,
      onGenerateRoute: (settings) {
        if(settings.name == "/") {
          page = const UPageLanding();
        }
        return FluentPageRoute(builder: (context) => page);

      },
    );
  }
}
