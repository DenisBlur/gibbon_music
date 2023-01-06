import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/main.dart';
import 'package:window_manager/window_manager.dart';

class WindowHeader extends StatelessWidget {
  const WindowHeader(
      {Key key,
      @required this.title,
      @required this.backArrow,
      @required this.setting})
      : super(key: key);

  final String title;
  final bool backArrow;
  final bool setting;

  @override
  Widget build(BuildContext context) {
    Color borderColor =
        FluentTheme.of(context).borderInputColor.withOpacity(.2);

    return Container(
      height: 36,
      decoration: BoxDecoration(
          color: FluentTheme.of(context).cardColor,
          border: Border(bottom: BorderSide(color: borderColor, width: .8))),
      child: Row(
        children: [
          AnimatedContainer(
            margin: EdgeInsets.only(
              left: 8,
              right: backArrow ? 8 : 0,
            ),
            width: backArrow ? 32 : 0,
            duration: const Duration(milliseconds: 850),
            curve: Curves.fastLinearToSlowEaseIn,
            child: ClipRRect(
              child: IconButton(
                  icon: const Icon(m.Icons.arrow_back_rounded, size: 16),
                  onPressed: () async {
                    Navigator.pop(context);
                    generalNotifyModel.removeNavList();
                    generalNotifyModel.backArrow = false;
                  }),
            ),
          ),
          Expanded(
              child: DragToMoveArea(
                  child: SizedBox(
                      height: 36,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      )))),
          setting
              ? IconButton(
                  icon: const Icon(m.Icons.settings, size: 16),
                  onPressed: () async {})
              : const SizedBox(),
          const SizedBox(
            width: 16,
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
              icon:
                  const Icon(m.Icons.check_box_outline_blank_rounded, size: 16),
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
