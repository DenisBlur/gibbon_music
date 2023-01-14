import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:gibbon_music/ui/widgets/content_loader.dart';
import 'package:animate_do/animate_do.dart';
import '../../constants/ui_consts.dart';

class ScaffoldScroller extends StatelessWidget {
  const ScaffoldScroller({Key key, @required this.slivers}) : super(key: key);

  final List<Widget> slivers;

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    Widget content = CustomScrollView(
        controller: controller, physics: Platform.isAndroid ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(), slivers: slivers);

    return Padding(
        padding: const EdgeInsets.only(top: AppConsts.windowHeader, left: 16, right: 16, bottom: 100),
        child: ImprovedScrolling(
          scrollController: controller,
          enableCustomMouseWheelScrolling: true,
          customMouseWheelScrollConfig: const CustomMouseWheelScrollConfig(
            scrollAmountMultiplier: AppConsts.scrollMultiplier,
          ),
          child: content,
        ));
  }
}
