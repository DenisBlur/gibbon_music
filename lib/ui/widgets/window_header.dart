import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/router.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

import '../../main.dart';


///переписать что бы хорошо было!

class WindowHeader extends StatelessWidget {
  const WindowHeader({Key key, @required this.title, @required this.backArrow, @required this.setting}) : super(key: key);

  final String title;
  final bool backArrow;
  final bool setting;

  @override
  Widget build(BuildContext context) {
    Color borderColor = FluentTheme.of(context).borderInputColor.withOpacity(.2);

    return Container(
      height: AppConsts.windowHeader,
      decoration: BoxDecoration(color: FluentTheme.of(context).cardColor, border: Border(bottom: BorderSide(color: borderColor, width: .8))),
      child: Row(
        children: [
          HeaderButton(onPressed: () {
              AppRouter().tryPop(context);
          }, icon: m.Icons.arrow_back_rounded, showHide: GoRouter.of(context).location != "/"),
          Expanded(
              child: DragToMoveArea(
                  child: SizedBox(
                      height: 36,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      )))),
          setting
              ? IconButton(
                  icon: const Icon(m.Icons.settings, size: 16),
                  onPressed: () async {
                    print(GoRouter.of(context).location);
                  })
              : const SizedBox(),
          const SizedBox(
            width: 16,
          ),
          HeaderButton(onPressed: () {}, icon: m.Icons.search_rounded, showHide: false),
          const SizedBox(
            width: 8,
          ),
          IconButton(
              icon: const Icon(m.Icons.minimize_rounded, size: 16),
              onPressed: () async {
                await windowManager.minimize();
              }),
          const SizedBox(
            width: 8,
          ),
          IconButton(
              icon: const Icon(m.Icons.check_box_outline_blank_rounded, size: 16),
              onPressed: () async {
                if (await windowManager.isMaximized()) {
                  await windowManager.unmaximize();
                } else {
                  await windowManager.maximize();
                }
              }),
          const SizedBox(
            width: 8,
          ),
          IconButton(
              icon: const Icon(m.Icons.close_rounded, size: 16),
              onPressed: () {
                exit(0);
              }),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
    );
  }
}

class HeaderButton extends StatelessWidget {
  const HeaderButton({Key key, this.showHide = true, @required this.onPressed, @required this.icon}) : super(key: key);

  final bool showHide;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(
        left: 8,
        right: showHide ? 8 : 0,
      ),
      width: showHide ? 32 : 0,
      duration: AppConsts.defaultAnimation,
      curve: Curves.fastLinearToSlowEaseIn,
      child: ClipRRect(
        child: IconButton(
            icon: Icon(icon, size: 16),
            onPressed: () {
              onPressed();
            }),
      ),
    );
  }
}