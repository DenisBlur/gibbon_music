import 'dart:io' show Platform;

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:gibbon_music/providers/dashboard_provider.dart';
import 'package:gibbon_music/router.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';

import 'ui/theme_data.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

List<SingleChildWidget> _providers = [ChangeNotifierProvider(create: (_) => DashboardProvider())];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    //Убираем TitleBar, ставим минимальный размер приложения и центрируем
    WindowOptions windowOptions = const WindowOptions(
      minimumSize: Size(800, 400),
      center: true,
      size: Size(1280, 720),
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );

    //показ приложения и центрирование, а так же установка фокуса на приложение
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.center();
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Инициализация тем приложения
    GThemeCreator.setColors(SystemTheme.accentColor);
    return MultiProvider(
      providers: _providers,
      child: FluentApp.router(
        theme: GThemeCreator.lightColor,
        routeInformationParser: AppRouter().route.routeInformationParser,
        routerDelegate: AppRouter().route.routerDelegate,
        routeInformationProvider: AppRouter().route.routeInformationProvider,
        color: GThemeCreator.accentColor.accent,
      ),
    );
  }
}
