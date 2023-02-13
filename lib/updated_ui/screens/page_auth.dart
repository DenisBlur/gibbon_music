import 'dart:math';
import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/domain/models/data_model.dart';
import 'package:gibbon_music/main.dart';
import 'package:gibbon_music/updated_ui/controls/buttons.dart';
import 'package:gibbon_music/updated_ui/screens/page_init.dart';
import 'package:gibbon_music/updated_ui/widgets/header.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_windows/webview_windows.dart';

class PageAuth extends StatefulWidget {
  const PageAuth({Key? key}) : super(key: key);

  @override
  State<PageAuth> createState() => _PageAuthState();
}

class _PageAuthState extends State<PageAuth> {
  PageController pageController = PageController();
  WebviewController controller = WebviewController();
  TextEditingController textEditingController = TextEditingController();
  bool errorAuth = false;
  final currentImage = AppConsts.authBgImagesLinks[Random().nextInt(AppConsts.authBgImagesLinks.length)];

  Future webInitialize() async {
    await controller.initialize();
    final DataModel dataModel = DataModel();
    String localToken = await dataModel.readStringData(AppConsts.tokenKey);
    if (localToken.contains("null")) {
      controller.url.listen((url) {
        if (url.contains("#access_token")) {
          String token = url.substring(url.indexOf("#access_token=") + 14, url.indexOf("&token_type=bearer"));
          showDialog(context: context, builder: (context) {
            return ContentDialog(
               title: const Text("Token found"),
              content: const Text("If you want to use another account, log out of your account."),
              actions: [
                GButton(onPressed: () {
                  dataModel.writeStringData(AppConsts.tokenKey, token);
                  initToken(token);
                  Navigator.pop(context);
                }, title: "Use"),
                GButton(onPressed: () {
                  Navigator.pop(context);
                }, title: "another account"),
              ],
            );
          },);
        }
      });
    } else {
      initToken(localToken);
    }
  }

  void initToken(String token) async {
    await client.init(token: token).then(
      (value) {
        if (!value) {
          updateStatus(true);
          Future.delayed(const Duration(seconds: 1)).then((value) {
            setState(() {
              updateStatus(false);
            });
          });
        } else {
          updateStatus(false);
          Navigator.pop(context);
          Navigator.push(
              context,
              FluentPageRoute(
                builder: (context) => PageInit(token: token),
              ));
        }
      },
    );
  }

  void updateStatus(bool er) {
    setState(() {
      errorAuth = er;
    });
  }

  @override
  void initState() {
    super.initState();
    webInitialize();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        padding: const EdgeInsets.all(0),
        content: Stack(
          children: [
            FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: currentImage,
                fit: BoxFit.cover,
                height: AppConsts.pageSize(context).height,
                width: AppConsts.pageSize(context).width),
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
            PageView(
              controller: pageController,
              children: [
                Center(
                  child: tokenAuth(),
                ),
                Column(
                  children: [
                    Expanded(
                      child: Webview(controller),
                    ),
                    Container(
                      color: FluentTheme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GButton(
                              onPressed: () {
                                pageController.animateToPage(0, duration: AppConsts.defaultAnimation, curve: AppConsts.defaultCurve);
                              },
                              title: "back"),
                          AppConsts.defaultHSpacer,
                          const Text("Is the browser not working? go back to the previous authorization method.")
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            const Header(menu: false),
          ],
        ));
  }

  Widget tokenAuth() {
    return Container(
            height: 300,
            constraints: const BoxConstraints(maxWidth: 300),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    color: FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(.8),
                    border: Border.all(color: FluentTheme.of(context).borderInputColor.withOpacity(.1), width: .2),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "MUSIC",
                        style: AppStyle.subTitle(context),
                      ),
                      AppConsts.smallVSpacer,
                      TextBox(
                        controller: textEditingController,
                        onSubmitted: (value) {
                          initToken(value);
                        },
                        maxLines: 1,
                        placeholder: "User token",
                      ),
                      AppConsts.smallVSpacer,
                      GButton(
                          onPressed: () {
                            initToken(textEditingController.text);
                          },
                          title: "Log in"),
                      AppConsts.smallVSpacer,
                      GTextButton(
                          onPressed: () async {
                            if (!await launchUrl(Uri.parse(AppConsts.tokenGetLink))) {
                              throw Exception('Could not launch');
                            }
                          },
                          title: "how do I find out the token?"),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: FluentTheme.of(context).cardColor.withOpacity(.6),
                    border: Border.all(color: FluentTheme.of(context).borderInputColor.withOpacity(.1), width: .2),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GTextButton(
                          onPressed: () async {
                            await controller.loadUrl(AppConsts.authLink);
                            pageController.animateToPage(1, duration: AppConsts.defaultAnimation, curve: AppConsts.defaultCurve);
                          },
                          title: "use the browser"),
                    ],
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      color: FluentTheme.of(context).cardColor.withOpacity(.4),
                      border: Border.all(color: FluentTheme.of(context).borderInputColor.withOpacity(.1), width: .2),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GImageButton(
                            onPressed: () async {
                              if (!await launchUrl(Uri.parse(AppConsts.yandexMusicApiLink))) {
                                throw Exception('Could not launch');
                              }
                            },
                            uri: "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png"),
                        AppConsts.smallHSpacer,
                        GImageButton(
                            onPressed: () async {
                              if (!await launchUrl(Uri.parse(AppConsts.telegramLink))) {
                                throw Exception('Could not launch');
                              }
                            },
                            uri: "https://img.icons8.com/color/512/telegram-app.png"),
                        AppConsts.smallHSpacer,
                        GImageButton(
                            onPressed: () async {
                              if (!await launchUrl(Uri.parse(AppConsts.yandexMusicLink))) {
                                throw Exception('Could not launch');
                              }
                            },
                            uri: "https://yastatic.net/s3/doc-binary/freeze/ru/music/eb46606ef5c2f78e06c7289d712e9d7e7a3712a1.png"),
                      ],
                    )),
              ],
            ))
        .animate(target: errorAuth ? 1 : 0)
        .shimmer(color: FluentTheme.of(context).accentColor, delay: 400.ms, duration: 1800.ms)
    .color(end: Colors.red)
        .scaleXY(end: 1.1, curve: Curves.easeInOutCubic)
        .shakeX(hz: 10, curve: Curves.easeInOutCubic);
  }
}
