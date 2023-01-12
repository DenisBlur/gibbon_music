import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';

import '../../constants/ui_consts.dart';

class ScaffoldScroller extends StatelessWidget {
  const ScaffoldScroller({Key key, @required this.slivers}) : super(key: key);

  final List<Widget> slivers;

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    return ScaffoldPage(
      padding: const EdgeInsets.all(0),
      content: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16),
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
        ),
      ),
    );
  }
}
