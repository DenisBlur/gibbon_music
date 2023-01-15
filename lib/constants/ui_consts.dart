import 'package:fluent_ui/fluent_ui.dart';

class AppConsts {
  AppConsts._();

  static const String appTitle = "Gibbon Music";

  static const Duration fastAnimation = Duration(milliseconds: 250);
  static const Duration defaultAnimation = Duration(milliseconds: 350);
  static const Duration slowAnimation = Duration(milliseconds: 650);

  static const Curve defaultCurve = Curves.fastLinearToSlowEaseIn;

  static const double windowHeader = 48;
  static const double scrollMultiplier = 25;
  static const double playerHeight = 100;

  static const SizedBox smallHSpacer = SizedBox(width: 8,);
  static const SizedBox defaultHSpacer = SizedBox(width: 16,);
  static const SizedBox bigHSpacer = SizedBox(width: 32,);

  static const SizedBox smallVSpacer = SizedBox(height: 8,);
  static const SizedBox defaultVSpacer = SizedBox(height: 16,);
  static const SizedBox bigVSpacer = SizedBox(height: 32,);

  static const Expanded fillSpacer = Expanded(child: SizedBox());
}
