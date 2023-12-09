import 'dart:io' show Platform;

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:gibbon_music/domain/models/like_model.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:gibbon_music/domain/models/search_model.dart';
import 'package:gibbon_music/providers/album_page_provider.dart';
import 'package:gibbon_music/providers/artist_page_provider.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/providers/auth_provider.dart';
import 'package:gibbon_music/providers/landing_provider.dart';
import 'package:gibbon_music/providers/navigator_provider.dart';
import 'package:gibbon_music/providers/playlist_page_provider.dart';
import 'package:gibbon_music/providers/search_provider.dart';
import 'package:gibbon_music/providers/ux_provider.dart';
import 'package:gibbon_music/providers/yandex_provider.dart';
import 'package:gibbon_music/updated_ui/screens/page_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:system_theme/system_theme.dart';
import 'package:yam_api/client.dart';

final _defaultLightColorScheme = ColorScheme.fromSwatch(primarySwatch: Colors.blue);

final _defaultDarkColorScheme = ColorScheme.fromSwatch(primarySwatch: Colors.blue, brightness: Brightness.dark);

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
    create: (context) => YandexProvider(likeModel: LikeModel()),
  ),
  ChangeNotifierProvider(create: (_) => NewPlaylist()),
  ChangeNotifierProvider(
    create: (_) => UxProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => AudioProvider(context.read()),
  ),
  ChangeNotifierProvider(
    create: (context) => NavigatorProvider(),
  ),
  ChangeNotifierProvider(create: (context) => AuthProvider(),)
];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemTheme.accentColor.load();
  runApp(const App());

  if (Platform.isWindows) {
    doWhenWindowReady(() {
      final win = appWindow;
      win.alignment = Alignment.center;
      win.minSize = const Size(720, 480);
    });
  }
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
        return  DynamicColorBuilder(
          builder: (lightColorScheme, darkColorScheme) {
            return MaterialApp(
          theme: ThemeData(
            colorScheme: lightColorScheme ?? _defaultLightColorScheme,
            useMaterial3: true,
            platform: TargetPlatform.iOS,
          ),
          darkTheme: ThemeData(

            colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
            useMaterial3: true,
            platform: TargetPlatform.iOS,
          ),
          showSemanticsDebugger: false,
          home: SafeArea(
            child: PageAuth(),
          ),
        );});
      },
    );
  }
}
