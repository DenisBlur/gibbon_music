import 'dart:io' show Platform;

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/domain/models/like_model.dart';
import 'package:gibbon_music/domain/models/queue_model.dart';
import 'package:gibbon_music/domain/models/search_model.dart';
import 'package:gibbon_music/providers/album_page_provider.dart';
import 'package:gibbon_music/providers/artist_page_provider.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/providers/landing_provider.dart';
import 'package:gibbon_music/providers/navigator_provider.dart';
import 'package:gibbon_music/providers/playlist_page_provider.dart';
import 'package:gibbon_music/providers/playlist_provider.dart';
import 'package:gibbon_music/providers/search_provider.dart';
import 'package:gibbon_music/providers/theme_provider.dart';
import 'package:gibbon_music/providers/ux_provider.dart';
import 'package:gibbon_music/providers/yandex_provider.dart';
import 'package:gibbon_music/ui/screens/page_landing.dart';
import 'package:gibbon_music/ui/screens/page_init.dart';
import 'package:gibbon_music/ui/widgets/content_loader.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';
import 'package:yam_api/client.dart';

import 'ui/theme_data.dart';

Client client = Client();

List<SingleChildWidget> _providers = [
  Provider(create: (_) => LandingProvider()),
  Provider(create: (_) => PageArtistProvider()),
  Provider(create: (_) => PageAlbumProvider()),
  Provider(create: (_) => PagePlaylistProvider()),
  ChangeNotifierProvider(
    create: (_) => SearchProvider(searchModel: SearchModel()),
  ),
  ChangeNotifierProvider(
    create: (_) => ThemeProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => YandexProvider(likeModel: LikeModel(), queueModel: QueueModel()),
  ),
  ChangeNotifierProvider(create: (context) => PlayListProvider(context.read())),
  ChangeNotifierProvider(
    create: (_) => UxProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => AudioProvider(context.read()),
  ),
  ChangeNotifierProvider(
    create: (context) => NavigatorProvider(),
  ),
];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();

    ///Убираем TitleBar, ставим минимальный размер приложения и центрируем
    WindowOptions windowOptions = const WindowOptions(
      minimumSize: Size(800, 400),
      center: true,
      size: Size(1280, 720),
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );

    ///показ приложения и центрирование, а так же установка фокуса на приложение
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.center();
    });
  }
  client.init(token: "AQAAAAAV_ACCAAG8XkFW219h4UiInu2aEV4ZGL4").whenComplete(() {
    runApp(const App());
  });
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

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
    return MultiProvider(
      providers: _providers,
      builder: (context, child) {
        return FluentApp(
          debugShowCheckedModeBanner: false,
          showSemanticsDebugger: false,
          home: const Load(),
          theme: context.watch<ThemeProvider>().theme,
          color: context.watch<ThemeProvider>().accentColor,
        );
      },
    );
  }
}

class Load extends StatelessWidget {
  const Load({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayListProvider pl = context.read();
    AudioProvider au = context.read();
    YandexProvider ya = context.read();
    ya.connectToAudioSystem(au);
    return ContentLoader(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const PageLanding();
        } else {
          return const PageInit();
        }
      },
      future: Future.delayed(Duration(seconds: 2)),
    );
  }
}
