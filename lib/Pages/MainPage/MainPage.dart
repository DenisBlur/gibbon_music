import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:gibbon_music/DesignWidget/GStyles.dart';
import 'package:gibbon_music/DesignWidget/ListItems/TrackItem.dart';
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

  final controller = ScrollController();

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
    return Padding(
        padding: EdgeInsets.only(left: Platform.isAndroid ? 0 : 72,  right: Platform.isAndroid ? 0 : 16),
        child: ImprovedScrolling(
          scrollController: controller,
          enableCustomMouseWheelScrolling: true,
          enableKeyboardScrolling: true,
          customMouseWheelScrollConfig: const CustomMouseWheelScrollConfig(
            scrollAmountMultiplier: 25.0,
          ),
          child: CustomScrollView(
            physics: Platform.isAndroid ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
            controller: controller,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: Platform.isWindows
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
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
                    PlayContextSection(
                        playContexts: mHomePage.listMVPlayContext),
                    SizedBox(
                      height: separate,
                    ),
                    Text("Чарт", style: titleTextStyle),
                    ChartSection(chartTrackList: mHomePage.listMVTrack),
                    SizedBox(
                      height: separate,
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 150),
              ),
            ],
          ),
        ));
  }
}
