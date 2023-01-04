import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/API/YAM_Functions.dart';
import 'package:gibbon_music/Pages/MainPage/MainPage.dart';
import 'package:gibbon_music/Theme/ThemeModel.dart';
import 'package:gibbon_music/main.dart';
import 'package:provider/provider.dart';

import '../../DesignWidget/Audio/Player/Android/AndAudioPlayer.dart';

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
                DraggableBottomSheet(
                  minExtent: 150,
                  useSafeArea: false,
                  curve: Curves.easeIn,
                  previewWidget: _previewWidget(),
                  expandedWidget: _expandedWidget(),
                  backgroundWidget: _backgroundWidget(),
                  maxExtent: MediaQuery.of(context).size.height * 0.8,
                  onDragging: (pos) {},
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  final List<IconData> icons = const [
    m.Icons.message,
    m.Icons.call,
    m.Icons.mail,
    m.Icons.notifications,
    m.Icons.settings,
  ];

  Widget _backgroundWidget() {
    return ScaffoldPage(
      content: SizedBox(
        height: 400,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(vertical: 32),
          itemCount: icons.length,
          itemBuilder: (context, index) => Container(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icons[index], color: Colors.white, size: 60),
          ),
          separatorBuilder: (context, index) => const SizedBox(width: 10),
        ),
      ),
    );
  }

  Widget _previewWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: m.Colors.pink,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 40,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Drag Me',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: icons.map((icon) {
                return Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: m.Colors.pink, size: 40),
                );
              }).toList())
        ],
      ),
    );
  }

  Widget _expandedWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: m.Colors.pink,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: <Widget>[
          const Icon(m.Icons.keyboard_arrow_down, size: 30, color: Colors.white),
          const SizedBox(height: 8),
          const Text(
            'Hey...I\'m expanding!!!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              itemCount: icons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icons[index], color: m.Colors.pink, size: 40),
              ),
            ),
          )
        ],
      ),
    );
  }

}
