import 'package:flutter/widgets.dart';
import 'package:gibbon_music/DesignWidget/GTextStyles.dart';
import 'package:gibbon_music/Pages/MainPage/Sections/PlayContextSection.dart';
import 'package:gibbon_music/Pages/MainPage/Sections/PromotionSection.dart';

import '../../main.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Интересно сейчас", style: titleTextStyle),
          const SizedBox(height: 8,),
          PromotionSection(promotions: mHomePage.listMVPromotion),
          const SizedBox(height: 8,),
          Text("Вы недавно слушали", style: titleTextStyle),
          const SizedBox(height: 8,),
          PlayContextSection(playContexts: mHomePage.listMVPlayContext),
        ],
      ),
    );
  }
}
