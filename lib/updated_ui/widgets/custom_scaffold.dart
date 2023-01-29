import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:gibbon_music/constants/app_consts.dart';

import '../utils/dynamic_data.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaffoldPage(
        padding: AppConsts.pageInsets(context),
        content: CustomScroller(
          slivers: children,
        ),
      ),
    );
  }
}

class CustomScroller extends StatelessWidget {
  CustomScroller({Key? key, required this.slivers}) : super(key: key);

  final List<Widget> slivers;
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ImprovedScrolling(
      scrollController: controller,
      enableCustomMouseWheelScrolling: true,
      customMouseWheelScrollConfig: const CustomMouseWheelScrollConfig(
        scrollAmountMultiplier: AppConsts.scrollMultiplier,
      ),
      child: Padding(
        padding: AppConsts.pagePadding(context),
        child: FadeInUp(
          child: CustomScrollView(
              controller: controller,
              physics: Platform.isAndroid ? const ScrollPhysics() : const NeverScrollableScrollPhysics(),
              slivers: widgetsToSliver(slivers)),
        )
      )
    );
  }
}
