import 'dart:io' show Platform;

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:gibbon_music/domain/models/like_model.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:gibbon_music/domain/models/queue_model.dart';
import 'package:gibbon_music/domain/models/search_model.dart';
import 'package:gibbon_music/providers/album_page_provider.dart';
import 'package:gibbon_music/providers/artist_page_provider.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:gibbon_music/providers/landing_provider.dart';
import 'package:gibbon_music/providers/navigator_provider.dart';
import 'package:gibbon_music/providers/playlist_page_provider.dart';
import 'package:gibbon_music/providers/search_provider.dart';
import 'package:gibbon_music/providers/theme_provider.dart';
import 'package:gibbon_music/providers/ux_provider.dart';
import 'package:gibbon_music/providers/yandex_provider.dart';
import 'package:gibbon_music/updated_ui/screens/page_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:yam_api/client.dart';

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
];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    await Window.initialize();
    await Window.setEffect(effect: WindowEffect.solid, color: Colors.black);
    await Window.hideWindowControls();
  }
  runApp(const App());
  doWhenWindowReady(() {
    final win = appWindow;
    win.alignment = Alignment.center;
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
          home: const SafeArea(
            child: Load(),
          ),
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
    return const PageAuth();
  }
}
