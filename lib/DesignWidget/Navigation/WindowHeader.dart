import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/API/MainMethod/GMethod.dart';
import 'package:gibbon_music/API/NotifyModels/GeneralNotifyModel.dart';
import 'package:gibbon_music/DesignWidget/Styles/ConstValue.dart';
import 'package:gibbon_music/main.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

class WindowHeader extends StatelessWidget {
  const WindowHeader({Key key, @required this.title, @required this.backArrow, @required this.setting}) : super(key: key);

  final String title;
  final bool backArrow;
  final bool setting;

  @override
  Widget build(BuildContext context) {

    String router = "";
    bool searchButton = false;
    if (context.watch<GeneralNotifyModel>().mNavList.isNotEmpty) {
      searchButton = context.watch<GeneralNotifyModel>().mNavList.last == "SearchPage" ;
      context.watch<GeneralNotifyModel>().mNavList.forEach((element) {
        router = "$router > $element";
      });
    }
    Color borderColor = FluentTheme.of(context).borderInputColor.withOpacity(.2);

    return Container(
      height: windowHeader,
      decoration: BoxDecoration(color: FluentTheme.of(context).cardColor, border: Border(bottom: BorderSide(color: borderColor, width: .8))),
      child: Row(
        children: [
          HeaderButton(
              onPressed: () {
                Navigator.pop(context);
                generalNotifyModel.removeNavList();
                generalNotifyModel.backArrow = false;
              },
              icon: m.Icons.arrow_back_rounded,
              showHide: backArrow),
          Expanded(
              child: DragToMoveArea(
                  child: SizedBox(
                      height: 36,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "$title $router",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      )))),
          setting ? IconButton(icon: const Icon(m.Icons.settings, size: 16), onPressed: () async {}) : const SizedBox(),
          const SizedBox(
            width: 16,
          ),
          HeaderButton(
              onPressed: () {
                goToSearch(context);
              },
              icon: m.Icons.search_rounded,
              showHide: !searchButton),
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
      duration: slowAnimation,
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
