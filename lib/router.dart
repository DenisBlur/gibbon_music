import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:gibbon_music/ui/screens/page_dashboard.dart';
import 'package:gibbon_music/ui/widgets/page_container.dart';
import 'package:gibbon_music/ui/screens/page_test.dart';
import 'package:go_router/go_router.dart';

import 'main.dart';
import 'ui/screens/page_home.dart';

class AppRouter {
  AppRouter();

  final GoRouter route = GoRouter(
    initialLocation: '/home',
    routes: [
      ShellRoute(
          routes: [
            GoRoute(
              path: "/home",
              builder: (context, state) => PageHome(key: state.pageKey),
            ),
            GoRoute(
              path: "/setting",
              builder: (context, state) => PageTest(key: state.pageKey),
            ),
            GoRoute(
              path: "/dashboard",
              builder: (context, state) => PageDashboard(key: state.pageKey),
            ),
          ],
          builder: (context, state, child) => PageContainer(
                key: state.pageKey,
                child: child,
              ))
    ],
    navigatorKey: rootNavigatorKey,
  );

  static Future<void> gotoTest(BuildContext context, Key key) async {
    await Navigator.of(context).push(
      FluentPageRoute(builder: (_) => PageTest(key: key,)),
    );
  }

  static Future<void> gotoDashboard(BuildContext context, Key key) async {
    await Navigator.of(context).push(
      FluentPageRoute(builder: (_) => PageDashboard(key: key,)),
    );
  }
}
