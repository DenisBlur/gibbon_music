import 'package:fluent_ui/fluent_ui.dart';
import 'package:system_theme/system_theme.dart';

class GThemeCreator {
  static SystemAccentColor accentColor = SystemTheme.accentColor;

  static Color accentDarkBackgroundColor;
  static Color accentDarkMicaColor;
  static Color accentDarkCardColor;

  static Color accentLightBackgroundColor;
  static Color accentLightMicaColor;
  static Color accentLightCardColor;

  static const double blendValue = 0.2;

  static ThemeData darkNoColor = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    cardColor: alphaBlend(Colors.white.withOpacity(.1), Colors.black),
    accentColor: accentColor.accent.toAccentColor(),
  );

  static ThemeData lightNoColor = ThemeData(
    brightness: Brightness.light,
    cardColor: alphaBlend(Colors.black.withOpacity(.1), Colors.white),
    scaffoldBackgroundColor: Colors.white,
    accentColor: accentColor.accent.toAccentColor(),
  );

  static ThemeData darkColor = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    accentColor: accentColor.accent.toAccentColor(),
  );

  static ThemeData lightColor = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    accentColor: accentColor.accent.toAccentColor(),
  );

  static Color alphaBlend(Color foreground, Color background) {
    final int alpha = foreground.alpha;
    if (alpha == 0x00) {
      // Foreground completely transparent.
      return background;
    }
    final int invAlpha = 0xff - alpha;
    int backAlpha = background.alpha;
    if (backAlpha == 0xff) {
      // Opaque background case
      return Color.fromARGB(
        0xff,
        (alpha * foreground.red + invAlpha * background.red) ~/ 0xff,
        (alpha * foreground.green + invAlpha * background.green) ~/ 0xff,
        (alpha * foreground.blue + invAlpha * background.blue) ~/ 0xff,
      );
    } else {
      // General case
      backAlpha = (backAlpha * invAlpha) ~/ 0xff;
      final int outAlpha = alpha + backAlpha;
      assert(outAlpha != 0x00);
      return Color.fromARGB(
        outAlpha,
        (foreground.red * alpha + background.red * backAlpha) ~/ outAlpha,
        (foreground.green * alpha + background.green * backAlpha) ~/ outAlpha,
        (foreground.blue * alpha + background.blue * backAlpha) ~/ outAlpha,
      );
    }
  }

  static void setColors(SystemAccentColor systemAccentColor) {

    Color userAccentColorLight = systemAccentColor.lightest;
    Color userAccentColorDark = systemAccentColor.darkest;

    accentDarkBackgroundColor =
        alphaBlend(userAccentColorDark.withOpacity(blendValue), Colors.black);
    accentDarkMicaColor =
        alphaBlend(userAccentColorDark.withOpacity(blendValue), accentDarkBackgroundColor);
    accentDarkCardColor =
        alphaBlend(userAccentColorDark.withOpacity(blendValue), accentDarkBackgroundColor);

    accentLightBackgroundColor =
        alphaBlend(userAccentColorLight.withOpacity(blendValue), Colors.white);
    accentLightMicaColor =
        alphaBlend(userAccentColorLight.withOpacity(blendValue), accentLightBackgroundColor);
    accentLightCardColor =
        alphaBlend(userAccentColorLight.withOpacity(blendValue), accentLightBackgroundColor);

    darkColor = ThemeData(
      brightness: Brightness.dark,
      cardColor: accentDarkCardColor,
      scaffoldBackgroundColor: accentDarkBackgroundColor,
      micaBackgroundColor: accentDarkMicaColor,
      inactiveBackgroundColor: accentDarkMicaColor,
      accentColor: systemAccentColor.accent.toAccentColor(),
    );

    lightColor = ThemeData(
      brightness: Brightness.light,
      cardColor: accentLightCardColor,
      scaffoldBackgroundColor: accentLightBackgroundColor,
      micaBackgroundColor: accentLightMicaColor,
      inactiveBackgroundColor: accentLightMicaColor,
      accentColor: systemAccentColor.accent.toAccentColor(),
    );
  }
}