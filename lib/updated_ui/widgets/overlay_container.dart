import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/providers/navigator_provider.dart';
import 'package:gibbon_music/router.dart';
import 'package:gibbon_music/updated_ui/screens/page_landing.dart';
import 'package:gibbon_music/updated_ui/widgets/header.dart';
import 'package:gibbon_music/updated_ui/widgets/lyric_widget.dart';
import 'package:provider/provider.dart';

import '../player/windows/win_player_main.dart';
import 'playlist_widget.dart';

class OverlayContainer extends StatelessWidget {
  const OverlayContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {

        return WillPopScope(
            onWillPop: () async {
              AppRouter().tryPop(context);
              return false;
            },
            child: const SafeArea(
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: AppConsts.defaultAnimation,
                    curve: AppConsts.defaultCurve,
                    child: NavigationSystem(),
                  ),
                  UPlaylistWidget(),
                  LyricWidget(),
                  Header(),
                  Align(alignment: Alignment.bottomCenter, child: PlayerMain()),
                ],
              ),
            ));
      },
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
        if (settings.name == "/") {
          page = const UPageLanding();
        }
        return FluentPageRoute(builder: (context) => page);
      },
    );
  }
}
