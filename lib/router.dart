import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:gibbon_music/ui/screens/page_artist.dart';
import 'package:gibbon_music/ui/screens/page_dashboard.dart';
import 'package:gibbon_music/ui/widgets/page_container.dart';
import 'package:gibbon_music/ui/screens/page_test.dart';
import 'package:go_router/go_router.dart';

import 'main.dart';
import 'ui/screens/page_home.dart';

class AppRouter {
  AppRouter();

  final GoRouter route = GoRouter(
    initialLocation: '/',
    routerNeglect: true,
    routes: [
      ShellRoute(
          routes: [
            GoRoute(
              path: "/test",
              name: "test",
              builder: (context, state) => PageTest(key: state.pageKey),
            ),
            GoRoute(
              path: "/",
              name: "dashboard",
              builder: (context, state) => PageDashboard(key: state.pageKey),
            ),
            GoRoute(
              path: "/artist/:id",
              name: "artist",
              pageBuilder: (context, state) {
                return CustomTransitionPage<void>(
                  child: PageArtist(key: state.pageKey, id: int.parse(state.params["id"])),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return DrillInPageTransition(
                      animation: animation,
                      child: child,
                    );
                  },
                );
              },
            ),
          ],
          builder: (context, state, child) => PageContainer(
                key: state.pageKey,
                child: child,
              ))
    ],
    navigatorKey: rootNavigatorKey,
  );

  tryPop(BuildContext context) {
    if (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    }
  }

  gotoArtist(BuildContext context, int id) {
    context.pushNamed("artist", params: {"id": id.toString()});
  }

  gotoTest(BuildContext context) {
    context.push("/test");
  }

  gotoDashboard(BuildContext context) {
    context.push("/dashboard");
  }
}
