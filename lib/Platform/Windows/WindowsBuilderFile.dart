import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/DesignWidget/Audio/Player/AudioPlayer.dart';
import 'package:gibbon_music/DesignWidget/Navigation/NavigationBar.dart';
import 'package:gibbon_music/DesignWidget/Navigation/WindowHeader.dart';
import 'package:gibbon_music/Pages/MainPage/MainPage.dart';
import 'package:gibbon_music/Theme/ThemeModel.dart';
import 'package:provider/provider.dart';

import '../../API/YAM_Functions.dart';
import '../../DesignWidget/Effects/Snowfall.dart';
import '../../main.dart';

class WindowsBuilderFile extends StatefulWidget {
  const WindowsBuilderFile({Key key}) : super(key: key);

  @override
  State<WindowsBuilderFile> createState() => _WindowsBuilderFileState();
}

class _WindowsBuilderFileState extends State<WindowsBuilderFile> {
  int index = 0;

  //Инициализация Яндекс Музыки, с передачей токена
  Future<void> initAPI() async {
    initYamApi("AQAAAAAV_ACCAAG8XkFW219h4UiInu2aEV4ZGL4");
    mHomePage =
        await getYamApiHomePage(["play_contexts", "chart", "promotions"]);
  }

  @override
  void initState() {
    super.initState();
    player.initAudio();
  }

  @override
  void dispose() {
    super.dispose();
    player.disposeAudio();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaffoldPage(
        padding: const EdgeInsets.all(0),
        content: Consumer<ThemeModel>(
          builder: (context, value, child) {
            return Stack(
              children: [
                const SnowFallBG(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const WindowHeader(
                        title: 'Yandex Music',
                        backArrow: false,
                        setting: false),
                    Expanded(
                      child: FutureBuilder(
                        future: initAPI(),
                        builder: (BuildContext context,
                            AsyncSnapshot<void> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return const Padding(
                              padding: EdgeInsets.only(left: 72, right: 16),
                              child: CustomScrollView(
                                slivers: [
                                  MainPage(),
                                ],
                              ),
                            );
                          } else {
                            return const Center(
                              child: ProgressRing(),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: AudioPlayerWidget(),
                ),
                const NavigationBar(),
              ],
            );
          },
        ),
      ),
    );
  }
}
