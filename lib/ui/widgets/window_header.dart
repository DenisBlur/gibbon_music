import 'dart:io';
import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/providers/navigator_provider.dart';
import 'package:gibbon_music/router.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

///переписать что бы хорошо было!

class WindowHeader extends StatelessWidget {
  const WindowHeader({Key? key, required this.setting}) : super(key: key);

  final bool setting;

  @override
  Widget build(BuildContext context) {
    var theme = FluentTheme.of(context);
    return Consumer<NavigatorProvider>(
      builder: (_, provider, __) {
        List<Widget> row = [];
        row.add(HeaderButton(onPressed: () => AppRouter().tryPop(context), icon: m.Icons.arrow_back_rounded, showHide: provider.navigationCanBack),);
        row.add(AppConsts.smallHSpacer,);
        row.add(Expanded(
            child: DragToMoveArea(
                child: SizedBox(
                    height: AppConsts.windowHeader,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Platform.isAndroid ? "" : AppConsts.appTitle,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )))),);
        row.add(AppConsts.defaultHSpacer,);
        row.add(HeaderButton(onPressed: () {AppRouter().gotoSearch(context);}, icon: m.Icons.search_rounded, showHide: true),);
        row.add(AppConsts.smallHSpacer,);
        if(!Platform.isAndroid) {
          row.add(IconButton(
            icon: const Icon(m.Icons.minimize_rounded, size: 18),
            onPressed: () async {
              await windowManager.minimize();
            }),);
        }
        if(!Platform.isAndroid) row.add(AppConsts.smallHSpacer,);
        if(!Platform.isAndroid) {
          row.add(IconButton(
            icon: const Icon(m.Icons.check_box_outline_blank_rounded, size: 18),
            onPressed: () async {
              if (await windowManager.isMaximized()) {
                await windowManager.unmaximize();
              } else {
                await windowManager.maximize();
              }
            }),);
        }
        if(!Platform.isAndroid)row.add(AppConsts.smallHSpacer,);
        if(!Platform.isAndroid) {
          row.add(IconButton(
            icon: const Icon(m.Icons.close_rounded, size: 18),
            onPressed: () {
              exit(0);
            }),);
        }
        if(!Platform.isAndroid)row.add(AppConsts.smallHSpacer,);

        return ClipRRect(
          child: Container(
            height: AppConsts.windowHeader,
            color: Platform.isAndroid ? theme.cardColor : theme.scaffoldBackgroundColor,
            child: Row(
              children: row,
            ),
          ),
        );
      }
    );
  }
}

class HeaderButton extends StatelessWidget {
  const HeaderButton({Key? key, this.showHide = true, required this.onPressed, required this.icon}) : super(key: key);

  final bool showHide;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {

    double iconSize = Platform.isAndroid ? 26 : 18;

    return AnimatedContainer(
      margin: EdgeInsets.only(
        left: 8,
        right: showHide ? 8 : 0,
      ),
      width: showHide ? iconSize * 2 : 0,
      duration: AppConsts.defaultAnimation,
      curve: Curves.fastLinearToSlowEaseIn,
      child: ClipRRect(
        child: IconButton(
            icon: Icon(icon, size: Platform.isAndroid ? 26 : 18),
            onPressed: () {
              onPressed();
            }),
      ),
    );
  }
}
