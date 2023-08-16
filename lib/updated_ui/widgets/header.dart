import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart' as m;

import '../../constants/app_consts.dart';
import '../../providers/navigator_provider.dart';
import '../../router.dart';

class Header extends StatelessWidget {
  const Header({Key? key, this.menu = true}) : super(key: key);

  final bool? menu;

  @override
  Widget build(BuildContext context) {
    var theme = FluentTheme.of(context);
    return Consumer<NavigatorProvider>(
      builder: (_, provider, __) {
        List<Widget> headerButtons = [];

        if (Platform.isWindows && menu!) {
          headerButtons.add(
            HeaderButton(onPressed: () => AppRouter().tryPop(context), icon: m.Icons.arrow_back_rounded, showHide: provider.navigationCanBack),
          );
        }

        headerButtons.add(AppConsts.defaultHSpacer);

        headerButtons.add(
          Expanded(
              child: MoveWindow(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                Platform.isAndroid || !menu! ? "" : AppConsts.appTitle,
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
              ),
            ),
          )),
        );
        headerButtons.add(
          AppConsts.defaultHSpacer,
        );

        if (menu!) {
          headerButtons.add(
            HeaderButton(
                onPressed: () {
                  AppRouter().gotoSearch(context);
                },
                icon: m.Icons.search_rounded,
                showHide: true),
          );
        }

        if (Platform.isWindows) {
          headerButtons.add(MinimizeWindowButton(
            colors: WindowButtonColors(
                iconNormal: theme.activeColor
            ),
          ));
        }

        if (Platform.isWindows) {
          headerButtons.add(MaximizeWindowButton(
            colors: WindowButtonColors(
                iconNormal: theme.activeColor
            ),
          ));
        }

        if (Platform.isWindows) {
          headerButtons.add(CloseWindowButton(
            colors: WindowButtonColors(
              iconNormal: theme.activeColor
            ),
          ));
        }

        return Platform.isWindows ? WindowTitleBarBox(
            child: ClipRRect(
          child: Container(
            height: AppConsts.windowHeader,
            color: theme.inactiveBackgroundColor.withOpacity(1),
            child: Row(
              children: headerButtons,
            ),
          ),
        )) : const SizedBox();
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
    double iconSize = 18;

    return AnimatedContainer(
      margin: EdgeInsets.only(
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
