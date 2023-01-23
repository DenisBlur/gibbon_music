import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/providers/ux_provider.dart';
import 'package:gibbon_music/router.dart';
import 'package:provider/provider.dart';

import '../controls/buttons.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UxProvider uxProvider = context.watch();
    var theme = FluentTheme.of(context);
    var backgroundColor = theme.cardColor.withOpacity(.65);

    return AnimatedPositioned(
        duration: AppConsts.defaultAnimation,
        curve: AppConsts.defaultCurve,
        top: AppConsts.windowHeader,
        bottom: AppConsts.playerHeight,
        left: uxProvider.isOpenDrawer ? 0 : -350,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: AnimatedContainer(
              width: 350,
              curve: AppConsts.defaultCurve,
              padding: const EdgeInsets.all(8),
              duration: AppConsts.defaultAnimation,
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppConsts.fillSpacer,
                  GIconButton(
                    onPressed: () {
                      AppRouter().gotoSetting(context);
                    },
                    icon: m.Icons.settings,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
