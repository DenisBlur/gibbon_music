import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';

import '../Styles/ConstValue.dart';

class ScrollerWidget extends StatelessWidget {
  const ScrollerWidget({Key key, @required this.slivers}) : super(key: key);

  final List<Widget> slivers;

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    return Padding(
      padding: pageInsets,
      child: ImprovedScrolling(
        scrollController: controller,
        enableCustomMouseWheelScrolling: true,
        customMouseWheelScrollConfig: const CustomMouseWheelScrollConfig(
          scrollAmountMultiplier: scrollMultiplier,
        ),
        child: CustomScrollView(
          controller: controller,
          physics: Platform.isAndroid ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
          slivers: slivers,
        ),
      ),
    );
  }
}
