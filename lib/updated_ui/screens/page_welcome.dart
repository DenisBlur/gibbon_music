import 'dart:math';
import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/updated_ui/controls/buttons.dart';
import 'package:gibbon_music/updated_ui/screens/page_auth.dart';
import 'package:gibbon_music/updated_ui/screens/page_setting.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../constants/app_consts.dart';
import '../../domain/models/data_model.dart';
import '../../providers/theme_provider.dart';
import '../widgets/header.dart';

class PageWelcome extends StatefulWidget {
  const PageWelcome({Key? key}) : super(key: key);

  @override
  State<PageWelcome> createState() => _PageWelcomeState();
}

class _PageWelcomeState extends State<PageWelcome> {
  PageController pageController = PageController();
  final currentImage = AppConsts.authBgImagesLinks[Random().nextInt(AppConsts.authBgImagesLinks.length)];

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        padding: const EdgeInsets.all(0),
        content: Stack(
          children: [
            if (!context.read<ThemeProvider>().isSystemTheme)
              FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: currentImage,
                  fit: BoxFit.cover,
                  height: AppConsts.pageSize(context).height,
                  width: AppConsts.pageSize(context).width),
            if (!context.read<ThemeProvider>().isSystemTheme)
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: AppConsts.pageSize(context).width,
                    height: AppConsts.pageSize(context).height,
                    decoration: BoxDecoration(
                      color: FluentTheme.of(context).cardColor.withOpacity(.4),
                      border: Border.all(color: FluentTheme.of(context).borderInputColor.withOpacity(.1), width: .2),
                    ),
                  ),
                ),
              ),
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(.5),
                    border: Border.all(color: FluentTheme.of(context).borderInputColor.withOpacity(.3), width: .4),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(.25), blurRadius: 10, offset: const Offset(0, 10))]),
                child: PageView(
                  controller: pageController,
                  children: [const WelcomeSlide()],
                ),
              ),
            ),
            const Header(menu: false),
          ],
        ));
  }
}

class WelcomeSlide extends StatelessWidget {
  const WelcomeSlide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataModel dataModel = DataModel();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Welcome",
          style: AppStyle.subTitle(context),
        ),
        Row(
          children: [
            Text(
              "System theme",
              style: AppStyle.prTitle(context),
            ),
            AppConsts.fillSpacer,
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
        Text(
          "Themes",
          style: AppStyle.prTitle(context),
        ),
        AppConsts.smallVSpacer,
        SizedBox(
            width: AppConsts.pageSize(context).width,
            height: 370,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, mainAxisExtent: 150, crossAxisSpacing: 8, mainAxisSpacing: 8),
              itemBuilder: (context, index) {
                return ThemeCard(
                  themeType: ThemeType.values[index],
                  onPressed: () {
                    dataModel.writeBoolData(AppConsts.systemThemeKey, false);
                    dataModel.writeIntData(AppConsts.themeIndexKey, index);
                  },
                );
              },
              itemCount: ThemeType.values.length - 1,
            )),
        AppConsts.fillSpacer,
        GButton(onPressed: () {
          dataModel.writeBoolData(AppConsts.firstSetupKey, true);
          Navigator.pop(context);
          Navigator.push(context, FluentPageRoute(builder: (context) => PageAuth(),));
        }, title: "complete")
      ],
    );
  }
}
