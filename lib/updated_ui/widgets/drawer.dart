import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/providers/theme_provider.dart';
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
    var backgroundColor = theme.cardColor.withOpacity(0.65);
    return AnimatedPositioned(
      duration: AppConsts.defaultAnimation,
      curve: AppConsts.defaultCurve,
      top: AppConsts.windowHeader,
      bottom: AppConsts.playerHeight,
      left: uxProvider.isOpenDrawer ? 0 : -350,
      child: Acrylic(
        elevation: 5,
        blurAmount: 20,
        luminosityAlpha: .95,
        tint: backgroundColor,
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(8),
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
    );
  }
}
