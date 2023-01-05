import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/API/YAM_Functions.dart';
import 'package:gibbon_music/Pages/MainPage/MainPage.dart';
import 'package:gibbon_music/main.dart';

import '../../DesignWidget/Effects/Snowfall.dart';

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
    return ScaffoldPage(
      padding: const EdgeInsets.all(0),
      content: SafeArea(child: Stack(
        children: [
          const SnowFallBG(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: FutureBuilder(
                  future: initAPI(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return const CustomScrollView(
                        physics: BouncingScrollPhysics(),
                        slivers: [
                          MainPage(),
                        ],
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
        ],
      ),),
    );
  }
}
