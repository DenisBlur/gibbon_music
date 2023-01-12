import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/extensions/duration.dart';
import 'package:gibbon_music/extensions/string.dart';
import '../../constants/ui_consts.dart';
import '../controls/buttons.dart';
import '../list_item/album_card.dart';
import '../list_item/track_card.dart';
import '../widgets/scroller_scaffold.dart';


/// Эта стриничка только для тестирования виджетов!

class PageTest extends StatelessWidget {
  const PageTest({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldScroller(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppConsts.defaultVSpacer,
              Text("Gibbon system design".toUpperCase(), style: AppStyle.header1Style),
              GTextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },title: "GoBack"),
              Text("Input GButtons", style: AppStyle.subHeader1Style(context),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GIconButton(onPressed: () {}, icon: m.Icons.play_arrow_rounded, size: 24, contrastBackground: true),
                  const SizedBox(width: 16,),
                  GIconButton(onPressed: () {}, icon: m.Icons.play_arrow_rounded, size: 24, contrastBackground: false),
                  const SizedBox(width: 16,),
                  GTextButton(onPressed: () {}, title: "Text button"),
                  const SizedBox(width: 16,),
                  GButton(onPressed: () {}, title: "Default button")
                ],
              ),
              const Text("Extensions", style: AppStyle.header1Style),
              Text("avatars.yandex.net/get-music-content/7548376/aef04514.a.23754447-1/%x%".linkImage(200)),
              const SizedBox(
                height: 5000,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
