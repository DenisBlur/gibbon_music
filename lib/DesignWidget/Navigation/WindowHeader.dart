import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mIcon;
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
    return Container(
      height: 28,
      decoration: BoxDecoration(
          color: FluentTheme.of(context).cardColor,
          border: Border(
              bottom: BorderSide(
                  color:
                      FluentTheme.of(context).borderInputColor.withOpacity(.2),
                  width: .8))),
      child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 0),
          child: Row(
            children: [
              backArrow
                  ? IconButton(
                      icon:
                          const Icon(mIcon.Icons.arrow_back_rounded, size: 16),
                      onPressed: () async {
                        Navigator.pop(context);
                      })
                  : const SizedBox(),
              SizedBox(
                width: backArrow ? 4 : 0,
              ),
              Expanded(
                  child: DragToMoveArea(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12),
                ),
              )),
              setting
                  ? IconButton(
                      icon: const Icon(mIcon.Icons.settings, size: 16),
                      onPressed: () async {})
                  : const SizedBox(),
              const SizedBox(
                width: 16,
              ),
              IconButton(
                  icon: const Icon(mIcon.Icons.minimize_rounded, size: 16),
                  onPressed: () async {
                    await windowManager.minimize();
                  }),
              IconButton(
                  icon: const Icon(mIcon.Icons.check_box_outline_blank_rounded,
                      size: 16),
                  onPressed: () async {
                    if (await windowManager.isMaximized()) {
                      await windowManager.unmaximize();
                    } else {
                      await windowManager.maximize();
                    }
                  }),
              IconButton(
                  icon: const Icon(mIcon.Icons.close_rounded, size: 16),
                  onPressed: () {
                    exit(0);
                  })
            ],
          )),
    );
  }
}
