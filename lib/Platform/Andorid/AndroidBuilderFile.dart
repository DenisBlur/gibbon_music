import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/API/YAM_Functions.dart';
import 'package:gibbon_music/DesignWidget/Audio/Player/AudioPlayer.dart';
import 'package:gibbon_music/Pages/MainPage/MainPage.dart';
import 'package:gibbon_music/Theme/ThemeModel.dart';
import 'package:gibbon_music/main.dart';
import 'package:provider/provider.dart';

class AndroidBuilderFile extends StatefulWidget {
  const AndroidBuilderFile({Key key}) : super(key: key);

  @override
  State<AndroidBuilderFile> createState() => _AndroidBuilderFileState();
}

class _AndroidBuilderFileState extends State<AndroidBuilderFile> {

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: FutureBuilder(
                        future: initAPI(),
                        builder: (BuildContext context,
                            AsyncSnapshot<void> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return const Padding(
                              padding: EdgeInsets.only(left: 16, right: 16),
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
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
