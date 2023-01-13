import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';

import '../../constants/ui_consts.dart';

class ScaffoldScroller extends StatelessWidget {
  const ScaffoldScroller({Key key, @required this.slivers, this.showContent = true}) : super(key: key);

  final bool showContent;
  final List<Widget> slivers;

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: ImprovedScrolling(
          scrollController: controller,
          enableCustomMouseWheelScrolling: true,
          customMouseWheelScrollConfig: const CustomMouseWheelScrollConfig(
            scrollAmountMultiplier: AppConsts.scrollMultiplier,
          ),
          child: CustomScrollView(
              controller: controller,
              physics: Platform.isAndroid ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
              slivers: slivers),
        ));
  }
}
