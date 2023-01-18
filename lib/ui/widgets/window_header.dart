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
      builder: (_, provider, __) => ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 25, sigmaX: 25),
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            height: AppConsts.windowHeader,
            color: theme.scaffoldBackgroundColor.withOpacity(.4),
            child: Row(
              children: [
                HeaderButton(onPressed: () => AppRouter().tryPop(context), icon: m.Icons.arrow_back_rounded, showHide: provider.navigationCanBack),
                AppConsts.smallHSpacer,
                const Expanded(
                    child: DragToMoveArea(
                        child: SizedBox(
                            height: AppConsts.windowHeader,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppConsts.appTitle,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            )))),
                setting ? IconButton(icon: const Icon(m.Icons.settings, size: 18), onPressed: () async {}) : const SizedBox(),
                AppConsts.defaultHSpacer,
                HeaderButton(onPressed: () {}, icon: m.Icons.search_rounded, showHide: false),
                AppConsts.smallHSpacer,
                IconButton(
                    icon: const Icon(m.Icons.minimize_rounded, size: 18),
                    onPressed: () async {
                      await windowManager.minimize();
                    }),
                AppConsts.smallHSpacer,
                IconButton(
                    icon: const Icon(m.Icons.check_box_outline_blank_rounded, size: 18),
                    onPressed: () async {
                      if (await windowManager.isMaximized()) {
                        await windowManager.unmaximize();
                      } else {
                        await windowManager.maximize();
                      }
                    }),
                AppConsts.smallHSpacer,
                IconButton(
                    icon: const Icon(m.Icons.close_rounded, size: 18),
                    onPressed: () {
                      exit(0);
                    }),
                AppConsts.smallHSpacer,
              ],
            ),
          ),
        ),
      ),
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
            icon: Icon(icon, size: 18),
            onPressed: () {
              onPressed();
            }),
      ),
    );
  }
}
