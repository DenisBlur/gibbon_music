import 'package:flutter/widgets.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:gibbon_music/DesignWidget/Styles/ConstValue.dart';
import 'package:gibbon_music/DesignWidget/Styles/GStyles.dart';
import 'package:gibbon_music/Pages/MainPage/Sections/PlayContextSection.dart';
import 'package:gibbon_music/Pages/MainPage/Sections/PromotionSection.dart';

import '../../DesignWidget/OverlayWidget.dart';
import '../../main.dart';
import 'Sections/ChartSection.dart';

bool overlayCreated = false;

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  OverlayState overlayState;
  OverlayEntry overlayEntry;
  final controller = ScrollController();

  showOverlay(BuildContext context) async {
    overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      opaque: false,
      maintainState: true,
      builder: (context) {
        return const Positioned(top: 0, left: 0, bottom: 0, right: 0, child: OverlayWidgets());
      },
    );
    if(!overlayCreated) {
      overlayState.insert(overlayEntry);
      overlayCreated = true;
    }
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showOverlay(context));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: pageInsets,
        child: ImprovedScrolling(
          scrollController: controller,
          enableCustomMouseWheelScrolling: true,
          enableKeyboardScrolling: true,
          customMouseWheelScrollConfig: const CustomMouseWheelScrollConfig(
            scrollAmountMultiplier: scrollMultiplier,
          ),
          child: CustomScrollView(
            physics: scrollPhysics,
            controller: controller,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: textPageAlignment,
                  children: [
                    Text("Интересно сейчас", style: titleTextStyle),
                    SizedBox(
                      height: sectionSeparate,
                    ),
                    PromotionSection(promotions: mHomePage.promotionList),
                    SizedBox(
                      height: sectionSeparate,
                    ),
                    Text("Вы недавно слушали", style: titleTextStyle),
                    SizedBox(
                      height: sectionSeparate,
                    ),
                    PlayContextSection(playContexts: mHomePage.playContextList),
                    SizedBox(
                      height: sectionSeparate,
                    ),
                    Text("Чарт", style: titleTextStyle),
                    ChartSection(chartTrackList: mHomePage.chartList),
                    SizedBox(
                      height: sectionSeparate,
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
