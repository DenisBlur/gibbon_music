import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/main.dart';
import 'package:gibbon_music/providers/theme_provider.dart';
import 'package:gibbon_music/updated_ui/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

class PageSetting extends StatelessWidget {
  const PageSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String accName = client.account.account!.displayName.toString();
    String accLogin = client.account.account!.login.toString();
    bool? hasPlus = client.account.plus!.hasPlus;
    return SafeArea(
        child: ScaffoldPage(
            padding: EdgeInsets.zero,
            content: CustomScaffold(
              children: [
                AppConsts.smallVSpacer,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      accName,
                      style: AppStyle.header1Style,
                    ),
                    AppConsts.smallHSpacer,
                    hasPlus == true
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                                color: FluentTheme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: FluentTheme.of(context).borderInputColor.withOpacity(.2), width: .6)),
                            child: const Text(
                              "PLUS",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                Text(
                  accLogin,
                  style: AppStyle.subTrackHeaderStyle(context),
                ),
                AppConsts.defaultVSpacer,
                const Text(
                  "Персонализация",
                  style: AppStyle.header1Style,
                ),
                AppConsts.defaultVSpacer,
                Row(
                  children: [
                    Text("Системная тема", style: AppStyle.prTitle(context),),
                    AppConsts.fillSpacer,
                    ToggleSwitch(
                      checked: context.read<ThemeProvider>().isSystemTheme,
                      onChanged: (value) {
                        if(!context.read<ThemeProvider>().isSystemTheme) {
                          context.read<ThemeProvider>().changeThemeType(ThemeType.systemTheme);
                          context.read<ThemeProvider>().setEffect(true);
                        } else {
                          context.read<ThemeProvider>().changeThemeType(ThemeType.lightColor);
                          context.read<ThemeProvider>().setEffect(false);
                        }
                      },
                    )
                  ],
                ),
                AppConsts.defaultVSpacer,
                Text("Темы", style: AppStyle.prTitle(context),),
                AppConsts.smallVSpacer,
                SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ThemeCard(
                            themeType: ThemeType.values[index],
                          ),
                        );
                      },
                      itemCount: ThemeType.values.length - 1,
                      scrollDirection: Axis.horizontal,
                    )),
              ],
            )));
  }
}

class ThemeCard extends StatelessWidget {
  const ThemeCard({Key? key, required this.themeType}) : super(key: key);

  final ThemeType themeType;

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = context.read();

    ThemeData themeData;
    themeData = theme.getTheme(type: themeType)!;

    return HoverButton(
      onPressed: () {
        theme.changeThemeType(themeType);
        theme.setEffect(false);
      },
      builder: (p0, state) {
        return AnimatedContainer(
            width: 150,
            height: 100,
            padding: EdgeInsets.all(theme.themeType == themeType
                ? 4
                : state.isHovering
                    ? 4
                    : 0),
            duration: AppConsts.defaultAnimation,
            curve: AppConsts.defaultCurve,
            decoration: BoxDecoration(
                color: theme.themeType == themeType ? FluentTheme.of(context).accentColor : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 10, offset: const Offset(0, 4))]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
                decoration: BoxDecoration(color: themeData.scaffoldBackgroundColor),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Container(
                    height: 10,
                    decoration: BoxDecoration(color: themeData.cardColor),
                  ),
                ]),
              ),
            ));
      },
    );
  }
}
