import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/updated_ui/utils/ui_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart' as m;
import 'package:window_manager/window_manager.dart';

import '../../constants/ui_consts.dart';
import '../../providers/navigator_provider.dart';
import '../../router.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = FluentTheme.of(context);
    return Consumer<NavigatorProvider>(
      builder: (_, provider, __) {
        List<Widget> headerButtons = [];

        if (Platform.isWindows) {
          headerButtons.add(
            HeaderButton(onPressed: () => AppRouter().tryPop(context), icon: m.Icons.arrow_back_rounded, showHide: provider.navigationCanBack),
          );
        }

        headerButtons.add(
          Expanded(
              child: DragToMoveArea(
                  child: SizedBox(
                      height: AppConsts.windowHeader,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Platform.isAndroid ? "" : AppConsts.appTitle,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      )))),
        );
        headerButtons.add(
          AppConsts.defaultHSpacer,
        );

        headerButtons.add(
          HeaderButton(
              onPressed: () {
                AppRouter().gotoSearch(context);
              },
              icon: m.Icons.search_rounded,
              showHide: true),
        );

        if (Platform.isWindows) {
          headerButtons.add(
            IconButton(
                icon: const Icon(m.Icons.minimize_rounded, size: 18),
                onPressed: () async {
                  await windowManager.minimize();
                }),
          );
        }

        if (Platform.isWindows) {
          headerButtons.add(
            IconButton(
                icon: const Icon(m.Icons.check_box_outline_blank_rounded, size: 18),
                onPressed: () async {
                  if (await windowManager.isMaximized()) {
                    await windowManager.unmaximize();
                  } else {
                    await windowManager.maximize();
                  }
                }),
          );
        }

        if (Platform.isWindows) {
          headerButtons.add(
            IconButton(
                icon: const Icon(m.Icons.close_rounded, size: 18),
                onPressed: () {
                  exit(0);
                }),
          );
        }

        return ClipRRect(
          child: Container(
            height: AppConsts.windowHeader,
            color: Responsive.isMobile(context) ? theme.cardColor : theme.scaffoldBackgroundColor,
            child: Row(
              children: headerButtons,
            ),
          ),
        );
      },
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
    double iconSize = Responsive.isMobile(context) ? 26 : 18;

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
            icon: Icon(icon, size: iconSize),
            onPressed: () {
              onPressed();
            }),
      ),
    );
  }
}
