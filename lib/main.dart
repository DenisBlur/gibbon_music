import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:gibbon_telegram/API/Models/NewHomePage/MV_HomePage.dart';
import 'package:gibbon_telegram/Pages/MainPage/MainPage.dart';
import 'package:gibbon_telegram/Theme/ThemeCreater.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';

import 'API/YAM_Functions.dart';
import 'DesignWidget/WindowHeader.dart';
import 'Theme/ThemeModel.dart';

//Просто акцент
SystemAccentColor accentColor = SystemTheme.accentColor;
//Основная модель приложения
ThemeModel themeModel = ThemeModel();
//Моделька с HomePage яндекс музыки
MVHomePage mHomePage = MVHomePage();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => themeModel = ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, value, child) {
          return FluentApp(
            title: "Music",
            theme: GThemeCreator.darkColor,
            home: const BuilderPage(),
          );
        },
      ),
    );
  }
}

class BuilderPage extends StatefulWidget {
  const BuilderPage({Key? key}) : super(key: key);

  @override
  State<BuilderPage> createState() => _BuilderPageState();
}

class _BuilderPageState extends State<BuilderPage> {
  final player = AudioPlayer();
  int index = 0;

  //Инициализация Яндекс Музыки, с передачей токена
  Future<void> initAPI() async {
    initYamApi("AQAAAAAV_ACCAAG8XkFW219h4UiInu2aEV4ZGL4");
    mHomePage =
        await getYamApiHomePage(["play_contexts", "chart", "promotions"]);
  }

  //TODO: тестовое воспроизвидение музыки, удалить в будущем
  Future<void> playAudio() async {
    await player.setUrl(
        'https://cdn7.deliciouspeaches.com/get/cuts/d7/7f/d77f4f45b3541506b1d2a94886a119ef/73156409/INSTASAMKA_-_LIPSI_HA_b128f0d121.mp3');
    await player.setVolume(1);
    // await player.play();
    getYamApiHomePage(["promotions, play_contexts"]);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaffoldPage(
        padding: EdgeInsets.all(0),
        content: Consumer<ThemeModel>(
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const WindowHeader(title: 'Yandex Music', backArrow: false, setting: false),
                Expanded(
                  child: FutureBuilder(
                    future: initAPI(),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return const Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: CustomScrollView(
                            slivers: [
                              MainPage(),
                            ],
                          ),
                        );
                      } else {
                        return const Center(child: ProgressRing(),);
                      }
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
