import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/DesignWidget/Navigation/NavigationBar.dart';
import 'package:gibbon_music/Pages/MainPage/MainPage.dart';

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
    mHomePage = await getYamApiHomePage(
        ["play_contexts", "chart", "promotions", "mixes"]);
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
        content: Stack(
          children: [
            const SnowFallBG(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: Platform.isAndroid ? 0 : 36),
                Expanded(
                  child: FutureBuilder(
                    future: initAPI(),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
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
            const NavigationBar(),
          ],
        ),
      ),
    );
  }
}