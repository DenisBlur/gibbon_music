
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/providers/ux_provider.dart';
import 'package:provider/provider.dart';

import '../utils/dynamic_data.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    children.add(const SizedBox(
      height: 120,
    ));

    return SafeArea(
      child: Scaffold(
        body: CustomScroller(
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
    return Padding(
      padding: AppConsts.pagePadding(context),
      child: CustomScrollView(
          controller: controller,
          physics: !context.watch<UxProvider>().smoothScroll ? const ScrollPhysics() : const NeverScrollableScrollPhysics(),
          slivers: widgetsToSliver(slivers))
          .animate(delay: 450.ms)
          .fadeIn(duration: AppConsts.defaultAnimation, curve: AppConsts.defaultCurve)
          .moveY(begin: 150, end: 0, duration: AppConsts.defaultAnimation, curve: AppConsts.defaultCurve),
    );
  }
}
