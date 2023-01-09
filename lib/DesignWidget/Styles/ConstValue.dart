import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';

///Dynamic value
final double windowHeader = Platform.isAndroid ? 0 : 36;
final double sectionSeparate = Platform.isWindows ? 16 : 32;
final double promotionHeight = Platform.isWindows ? 450 : 250;

final EdgeInsets pageInsets = EdgeInsets.only(left: Platform.isAndroid ? 0 : 72, right: Platform.isAndroid ? 0 : 72);
final EdgeInsets sectionInsets = EdgeInsets.only(left: Platform.isAndroid ? 16 : 0, right: Platform.isAndroid ? 16 : 0);

final ScrollPhysics scrollPhysics = Platform.isAndroid ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics();
final CrossAxisAlignment textPageAlignment = Platform.isWindows ? CrossAxisAlignment.start : CrossAxisAlignment.center;


///Static value
const double scrollMultiplier = 25.0;

///Animations
const Duration dragAnimation = Duration(milliseconds: 25);
const Duration fastAnimation = Duration(milliseconds: 250);
const Duration slowAnimation = Duration(milliseconds: 650);
