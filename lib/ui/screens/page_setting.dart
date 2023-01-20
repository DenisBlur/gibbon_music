import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/main.dart';
import 'package:gibbon_music/providers/theme_provider.dart';
import 'package:gibbon_music/ui/widgets/scroller_scaffold.dart';
import 'package:provider/provider.dart';

class PageSetting extends StatelessWidget {
  const PageSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String accName = client.account.account!.displayName.toString();
    String accLogin = client.account.account!.login.toString();
    bool? hasPlus = client.account.plus!.hasPlus;
    return SafeArea(child: ScaffoldPage(
        padding: EdgeInsets.zero,
        content: ScaffoldScroller(
          padding: AppConsts.pageInsets,
          slivers: [
            const Adapter(
              AppConsts.smallVSpacer,
            ),
            Adapter(Row(
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
                      color: FluentTheme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: FluentTheme.of(context).borderInputColor.withOpacity(.2), width: .6)),
                  child: const Text(
                    "PLUS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
                    : const SizedBox(),
              ],
            )),
            Adapter(Text(
              accLogin,
              style: AppStyle.subTrackHeaderStyle(context),
            )),
            const Adapter(
              AppConsts.defaultVSpacer,
            ),
            const Adapter(Text(
              "Персонализация",
              style: AppStyle.header1Style,
            )),
            const Adapter(
              AppConsts.defaultVSpacer,
            ),
            Adapter(SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  ThemeCard(
                    themeType: ThemeType.lightColor,
                  ),
                  AppConsts.smallHSpacer,
                  ThemeCard(
                    themeType: ThemeType.darkColor,
                  ),
                  AppConsts.smallHSpacer,
                  ThemeCard(
                    themeType: ThemeType.lightNoColor,
                  ),
                  AppConsts.smallHSpacer,
                  ThemeCard(
                    themeType: ThemeType.darkNoColor,
                  ),
                ],
              ),
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

    switch (themeType) {
      case ThemeType.darkColor:
        themeData = theme.themeCreator.darkColor!;
        break;
      case ThemeType.lightColor:
        themeData = theme.themeCreator.lightColor!;
        break;
      case ThemeType.darkNoColor:
        themeData = theme.themeCreator.darkNoColor!;
        break;
      case ThemeType.lightNoColor:
        themeData = theme.themeCreator.lightNoColor!;
        break;
    }

    return HoverButton(
      onPressed: () {
        theme.changeThemeType(themeType);
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

class Adapter extends StatelessWidget {
  const Adapter(this.child, {Key? key}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: child,
    );
  }
}
