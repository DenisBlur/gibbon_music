import 'dart:math';
import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/updated_ui/screens/page_auth.dart';
import 'package:gibbon_music/updated_ui/screens/page_setting.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../constants/app_consts.dart';
import '../../domain/models/data_model.dart';
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
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(.5),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(.25), blurRadius: 10, offset: const Offset(0, 10))]),
                child: PageView(
                  controller: pageController,
                  children: const [WelcomeSlide()],
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
          ],
        ),
        AppConsts.defaultVSpacer,
        Text(
          "Themes",
          style: AppStyle.prTitle(context),
        ),
        AppConsts.smallVSpacer,
        AppConsts.fillSpacer,
        Button(
            onPressed: () {
              dataModel.writeBoolData(AppConsts.firstSetupKey, true);
              Navigator.pop(context);
              Navigator.push(
                  context,
                  FluentPageRoute(
                    builder: (context) => const PageAuth(),
                  ));
            },
            child: const Text("complete"))
      ],
    );
  }
}
