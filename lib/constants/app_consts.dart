import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/updated_ui/utils/ui_utils.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class AppConsts {
  AppConsts._();

  static const String appTitle = "Gibbon Music";
  static const String imageEmptyLink = "https://avatars.mds.yandex.net/i?id=070e2d92627bd11f549d2479c13e8f30-4482423-images-thumbs&n=13&exp=1";
  static const String authLink = "https://oauth.yandex.ru/authorize?response_type=token&client_id=23cabbbdc6cd418abb4b39c32c41195d";
  static const String tokenGetLink = "https://github.com/MarshalX/yandex-music-api/discussions/513#discussioncomment-2729781";
  static const String tokenKey = "token";

  static const String yandexMusicLink = "https://music.yandex.ru/home";
  static const String yandexMusicApiLink = "https://github.com/MarshalX/yandex-music-api";
  static const String telegramLink = "https://t.me/gibbonstudio";

  static const List<String> authBgImagesLinks = [
    "https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1948&q=80",
    "https://images.unsplash.com/photo-1426604966848-d7adac402bff?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80",
    "https://images.unsplash.com/photo-1501854140801-50d01698950b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1950&q=80",
    "https://images.unsplash.com/photo-1497436072909-60f360e1d4b1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1932&q=80",
    "https://images.unsplash.com/photo-1475070929565-c985b496cb9f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80",
    "https://images.unsplash.com/photo-1483982258113-b72862e6cff6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80",
    "https://images.unsplash.com/photo-1485470733090-0aae1788d5af?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2117&q=80",
  ];


  static const Duration fastAnimation = Duration(milliseconds: 650);
  static const Duration defaultAnimation = Duration(milliseconds: 750);
  static const Duration slowAnimation = Duration(milliseconds: 1050);

  static const Curve defaultCurve = Curves.fastLinearToSlowEaseIn;

  static double windowHeader = appWindow.titleBarHeight;

  static const double scrollMultiplier = 4;
  static final double playerHeight = Platform.isWindows ? 100 : 64;

  static const double defaultCardHeight = 258 - 32;
  static const double defaultCardWidth = 186 - 32;

  static double wideCardHeight(BuildContext context) {
    return Responsive.isDesktop(context) ? 300 : 200;
  }

  static double wideCardWidth(BuildContext context) {
    return Responsive.isDesktop(context) ? 350 : 250;
  }

  static const SizedBox smallHSpacer = SizedBox(
    width: 8,
  );
  static const SizedBox defaultHSpacer = SizedBox(
    width: 16,
  );
  static const SizedBox bigHSpacer = SizedBox(
    width: 32,
  );

  static const SizedBox smallVSpacer = SizedBox(
    height: 8,
  );
  static const SizedBox defaultVSpacer = SizedBox(
    height: 16,
  );
  static const SizedBox bigVSpacer = SizedBox(
    height: 32,
  );

  static const Expanded fillSpacer = Expanded(child: SizedBox());

  static EdgeInsets pageInsets(BuildContext context) {
    return Responsive.isMobile(context) ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 16);
  }

  static EdgeInsets pageOffset = const EdgeInsets.symmetric(horizontal: 16);

  static EdgeInsets pagePadding(BuildContext context) {
    return !Responsive.isDesktop(context)
        ? EdgeInsets.only(bottom: playerHeight, top: windowHeader)
        : EdgeInsets.only(bottom: playerHeight, top: windowHeader);
  }

  static Size pageSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}
