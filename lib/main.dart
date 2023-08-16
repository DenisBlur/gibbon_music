import 'dart:io' show Platform;

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/domain/models/data_model.dart';
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
import 'package:gibbon_music/providers/radio_provider.dart';
import 'package:gibbon_music/providers/search_provider.dart';
import 'package:gibbon_music/providers/ux_provider.dart';
import 'package:gibbon_music/providers/yandex_provider.dart';
import 'package:gibbon_music/updated_ui/screens/page_auth.dart';
import 'package:gibbon_music/updated_ui/screens/page_welcome.dart';
import 'package:gibbon_music/updated_ui/widgets/loading_ring.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:system_theme/system_theme.dart';
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
  Provider(create: (context) => RadioProvider(context.read()))
];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  Future<Widget> getData() async {
    DataModel dataModel = DataModel();
    bool? check = await dataModel.findKey(AppConsts.firstSetupKey);
    if (check!) {
      bool? firstSetup = await dataModel.readBoolData(AppConsts.firstSetupKey);
      if (firstSetup!) {
        return const PageAuth();
      } else {
        return const PageWelcome();
      }
    } else {
      return const PageWelcome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _providers,
      builder: (context, child) {
        return FluentApp(
          theme: FluentThemeData(
            brightness: Brightness.dark,
            accentColor: SystemTheme.accentColor.accent.toAccentColor(),
          ),
          debugShowCheckedModeBanner: false,
          showSemanticsDebugger: false,
          home: SafeArea(
            child: FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.data as Widget;
                  } else {
                    return const LoadingRing();
                  }
                }),
          ),
        );
      },
    );
  }
}
