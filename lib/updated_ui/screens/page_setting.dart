import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/domain/models/data_model.dart';
import 'package:gibbon_music/main.dart';
import 'package:gibbon_music/providers/theme_provider.dart';
import 'package:gibbon_music/providers/ux_provider.dart';
import 'package:gibbon_music/updated_ui/controls/buttons.dart';
import 'package:gibbon_music/updated_ui/theme_data.dart';
import 'package:gibbon_music/updated_ui/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart' as m;

class PageSetting extends StatelessWidget {
  const PageSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataModel dataModel = DataModel();
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
                    Text(
                      "Системная тема",
                      style: AppStyle.prTitle(context),
                    ),
                    AppConsts.fillSpacer,
                    GIconButton(onPressed: () {
                      showDialog(context: context, builder: (context) {
                        return ContentDialog(
                          title: const Text("Select effect"),
                          content: SizedBox(
                            height: 125,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                GButton(onPressed: () {
                                  Navigator.pop(context);
                                  context.read<ThemeProvider>().setEffect(isSystem: true, effect: WindowEffect.acrylic);
                                }, title: "acrylic"),
                                AppConsts.smallVSpacer,
                                GButton(onPressed: () {
                                  Navigator.pop(context);
                                  context.read<ThemeProvider>().setEffect(isSystem: true, effect: WindowEffect.mica);
                                }, title: "mica"),
                                AppConsts.smallVSpacer,
                                GButton(onPressed: () {
                                  Navigator.pop(context);
                                  context.read<ThemeProvider>().setEffect(isSystem: true, effect: WindowEffect.tabbed);
                                }, title: "mica 2"),
                              ],
                            ),
                          ),
                          actions: [
                            GButton(onPressed: () {
                              Navigator.pop(context);
                            }, title: "Close")
                          ],
                        );
                      },);
                    }, icon: m.Icons.settings),
                    AppConsts.defaultHSpacer,
                    ToggleSwitch(
                      checked: context.read<ThemeProvider>().isSystemTheme,
                      onChanged: (value) {
                        if (!context.read<ThemeProvider>().isSystemTheme) {
                          context.read<ThemeProvider>().changeThemeType(ThemeType.systemTheme);
                          context.read<ThemeProvider>().setEffect(isSystem: true);
                          dataModel.writeBoolData(AppConsts.systemThemeKey, true);
                        } else {
                          context.read<ThemeProvider>().changeThemeType(ThemeType.lightColor);
                          context.read<ThemeProvider>().setEffect(isSystem: false);
                          dataModel.writeBoolData(AppConsts.systemThemeKey, false);
                        }
                      },
                    )
                  ],
                ),
                AppConsts.defaultVSpacer,
                Consumer<UxProvider>(
                  builder: (context, ux, child) {
                    return Row(
                      children: [
                        Text(
                          "Плавная прокрутка",
                          style: AppStyle.prTitle(context),
                        ),
                        AppConsts.fillSpacer,
                        ToggleSwitch(
                          checked: ux.smoothScroll,
                          onChanged: (value) {
                            if (!ux.smoothScroll) {
                              ux.changeSmoothScrollState();
                              dataModel.writeBoolData(AppConsts.smoothScrollKey, true);
                            } else {
                              ux.changeSmoothScrollState();
                              dataModel.writeBoolData(AppConsts.smoothScrollKey, false);
                            }
                          },
                        )
                      ],
                    );
                  },
                ),
                AppConsts.smallVSpacer,
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: GThemeCreator().alphaBlend(Colors.yellow.withOpacity(.2), FluentTheme.of(context).cardColor),
                    border: Border.all(color: FluentTheme.of(context).borderInputColor.withOpacity(.4), width: .2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(FluentIcons.warning),
                      AppConsts.smallHSpacer,
                      Text(
                          "Attention when smooth scrolling is enabled, your laptop's touchpad or touch screen will not work!"
                      ),
                    ],
                  )
                ),
                AppConsts.defaultVSpacer,
                Text(
                  "Темы",
                  style: AppStyle.prTitle(context),
                ),
                AppConsts.smallVSpacer,
                SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ThemeCard(
                            themeType: ThemeType.values[index],
                            onPressed: () {
                              dataModel.writeBoolData(AppConsts.systemThemeKey, false);
                              dataModel.writeIntData(AppConsts.themeIndexKey, index);
                            },
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
  const ThemeCard({Key? key, required this.themeType, this.onPressed}) : super(key: key);

  final ThemeType themeType;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = context.read();

    ThemeData themeData;
    themeData = theme.getTheme(type: themeType)!;

    return HoverButton(
      onPressed: () {
        theme.changeThemeType(themeType);
        theme.setEffect(isSystem: false);
        onPressed!();
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
