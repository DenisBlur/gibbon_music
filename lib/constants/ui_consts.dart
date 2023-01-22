import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/updated_ui/utils/ui_utils.dart';

class AppConsts {
  AppConsts._();

  static const String appTitle = "Gibbon Music";
  static const String imageEmptyLink = "https://avatars.mds.yandex.net/i?id=070e2d92627bd11f549d2479c13e8f30-4482423-images-thumbs&n=13&exp=1";

  static const Duration fastAnimation = Duration(milliseconds: 650);
  static const Duration defaultAnimation = Duration(milliseconds: 750);
  static const Duration slowAnimation = Duration(milliseconds: 1050);

  static const Curve defaultCurve = Curves.fastLinearToSlowEaseIn;

  static double windowHeader = 48;

  static const double scrollMultiplier = 25;
  static const double playerHeight = 100;

  static const double standartCardHeight = 258 - 32;
  static const double standartCardWidth = 186 - 32;

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

  static EdgeInsets pageOffset = const EdgeInsets.symmetric(horizontal: 8);

  static EdgeInsets pagePadding(BuildContext context) {
    return !Responsive.isDesktop(context)
        ? EdgeInsets.only(bottom: playerHeight, top: windowHeader)
        : EdgeInsets.only(bottom: playerHeight, top: windowHeader, right: 60, left: 60);
  }

  static Size pageSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}
