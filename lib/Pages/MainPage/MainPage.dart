import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:gibbon_music/DesignWidget/GStyles.dart';
import 'package:gibbon_music/Pages/MainPage/Sections/PlayContextSection.dart';
import 'package:gibbon_music/Pages/MainPage/Sections/PromotionSection.dart';

import '../../DesignWidget/OverlayWidget.dart';
import '../../main.dart';
import 'Sections/ChartSection.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  double separate = Platform.isWindows ? 16 : 32;

  showOverlay(BuildContext context) async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      opaque: false,
      builder: (context) {
        return const Positioned(
            top: 0, left: 0, bottom: 0, right: 0, child: OverlayWidgets());
      },
    );
    overlayState.insert(overlayEntry);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showOverlay(context));
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: Platform.isWindows ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Text("Интересно сейчас", style: titleTextStyle),
          SizedBox(
            height: separate,
          ),
          PromotionSection(promotions: mHomePage.listMVPromotion),
          SizedBox(
            height: separate,
          ),
          Text("Вы недавно слушали", style: titleTextStyle),
          SizedBox(
            height: separate,
          ),
          PlayContextSection(playContexts: mHomePage.listMVPlayContext),
          SizedBox(
            height: separate,
          ),
          Text("Чарт", style: titleTextStyle),
          SizedBox(
            height: separate,
          ),
          ChartSection(chartTrackList: mHomePage.listMVTrack),
          const SizedBox(
            height: 116,
          ),
        ],
      ),
    );
  }
}
