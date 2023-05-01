import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/main.dart';
import 'package:gibbon_music/providers/ux_provider.dart';
import 'package:gibbon_music/router.dart';
import 'package:provider/provider.dart';

import '../controls/buttons.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UxProvider uxProvider = context.watch();
    return AnimatedPositioned(
      duration: AppConsts.defaultAnimation,
      curve: AppConsts.defaultCurve,
      top: AppConsts.windowHeader,
      bottom: AppConsts.playerHeight,
      left: uxProvider.isOpenDrawer ? 0 : -350,
      child: Container(
        color: FluentTheme.of(context).cardColor,
        width: 350,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GDrawerButton(onPressed: () async {
              AppRouter().gotoMore(context: context, future: client.getUserPlaylists(), title: "User playlists");
            }, title: "User playlists", icon: m.Icons.playlist_play_rounded,),
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
    );
  }
}
