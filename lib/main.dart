import 'dart:io' show Platform;

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/api/mainYamFunction.dart';
import 'package:gibbon_music/providers/artist_provider.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/providers/dashboard_provider.dart';
import 'package:gibbon_music/providers/navigator_provider.dart';
import 'package:gibbon_music/ui/screens/page_dashboard.dart';
import 'package:gibbon_music/ui/screens/page_init.dart';
import 'package:gibbon_music/ui/widgets/content_loader.dart';
import 'package:gibbon_music/ui/widgets/loading_ring.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';
import 'package:yam_api/yam_api.dart';

import 'ui/theme_data.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
bool _overlayCreated = false;

List<SingleChildWidget> _providers = [
  Provider(create: (_) => DashboardProvider()),
  Provider(create: (_) => ArtistProvider()),
  ChangeNotifierProvider(
    create: (_) => AudioProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => NavigatorProvider(),
  )
];

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

  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Инициализация тем приложения
    GThemeCreator.setColors(SystemTheme.accentColor);
    return MultiProvider(
      providers: _providers,
      child: FluentApp(
        home: ContentLoader(
          future: initYamApi("AQAAAAAV_ACCAAG8XkFW219h4UiInu2aEV4ZGL4"),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done) {
              return const PageDashboard();
            } else {
              return const PageInit();
            }
          },
        ),
        theme: GThemeCreator.darkColor,
        color: GThemeCreator.accentColor.accent,
      ),
    );
  }
}
