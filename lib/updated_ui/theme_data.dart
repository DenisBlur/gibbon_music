import 'package:fluent_ui/fluent_ui.dart';
import 'package:system_theme/system_theme.dart';

class GThemeCreator {

  init({required SystemAccentColor accentColor}) {
    mainAccentColor = accentColor.accent;
    setColors(accentColor);
  }

  Color? mainAccentColor;

  Color? accentDarkBackgroundColor;
  Color? accentDarkMicaColor;
  Color? accentDarkCardColor;

  Color? accentLightBackgroundColor;
  Color? accentLightMicaColor;
  Color? accentLightCardColor;

  static const double blendValue = 0.25;
  static const double effectValue = 0.1;

  ThemeData? darkNoColor;
  ThemeData? lightNoColor;
  ThemeData? darkColor;
  ThemeData? lightColor;

  ThemeData? darkNoColorEffect;
  ThemeData? lightNoColorEffect;
  ThemeData? darkColorEffect;
  ThemeData? lightColorEffect;


  Color alphaBlend(Color foreground, Color background) {
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

  void setColors(SystemAccentColor systemAccentColor) {

    Color userAccentColorLight = systemAccentColor.lightest;
    Color userAccentColorDark = systemAccentColor.dark;

    accentDarkBackgroundColor =
        alphaBlend(userAccentColorDark.withOpacity(blendValue), Colors.black);
    accentDarkMicaColor =
        alphaBlend(userAccentColorDark.withOpacity(blendValue), accentDarkBackgroundColor!);
    accentDarkCardColor =
        alphaBlend(userAccentColorDark.withOpacity(blendValue), accentDarkBackgroundColor!);

    accentLightBackgroundColor =
        alphaBlend(userAccentColorLight.withOpacity(blendValue), Colors.white);
    accentLightMicaColor =
        alphaBlend(userAccentColorLight.withOpacity(blendValue), accentLightBackgroundColor!);
    accentLightCardColor =
        alphaBlend(userAccentColorLight.withOpacity(blendValue), accentLightBackgroundColor!);

    darkNoColor = ThemeData(
      brightness: Brightness.dark,
      cardColor: alphaBlend(Colors.white.withOpacity(.1), Colors.black),
      scaffoldBackgroundColor: Colors.black,
      accentColor: Colors.white.toAccentColor(),
      scrollbarTheme: const ScrollbarThemeData(
        backgroundColor: Colors.transparent,
        hoveringThickness: 1,
        thickness: 1,
      ),
    );

    lightNoColor = ThemeData(
      brightness: Brightness.light,
      cardColor: alphaBlend(Colors.black.withOpacity(.05), Colors.white),
      scaffoldBackgroundColor: Colors.white,
      accentColor: Colors.black.toAccentColor(),
      scrollbarTheme: const ScrollbarThemeData(
        backgroundColor: Colors.transparent,
        hoveringThickness: 1,
        thickness: 1,
      ),
    );

    darkColor = ThemeData(
      brightness: Brightness.dark,
      cardColor: accentDarkCardColor,
      scaffoldBackgroundColor: accentDarkBackgroundColor,
      micaBackgroundColor: accentDarkMicaColor,
      inactiveBackgroundColor: accentDarkMicaColor,
      scrollbarTheme: ScrollbarThemeData(
        backgroundColor: Colors.transparent,
        scrollbarColor: systemAccentColor.accent,
        hoveringThickness: 1,
        thickness: 1,
      ),
      accentColor: systemAccentColor.accent.toAccentColor(),
    );

    lightColor = ThemeData(
      brightness: Brightness.light,
      cardColor: accentLightCardColor,
      scaffoldBackgroundColor: accentLightBackgroundColor,
      micaBackgroundColor: accentLightMicaColor,
      inactiveBackgroundColor: accentLightMicaColor,
      scrollbarTheme: ScrollbarThemeData(
        backgroundColor: Colors.transparent,
        scrollbarColor: systemAccentColor.accent,
        hoveringThickness: 1,
        thickness: 1,
      ),
      accentColor: systemAccentColor.accent.toAccentColor(),
    );

    darkNoColorEffect = ThemeData(
      brightness: Brightness.dark,
      cardColor: alphaBlend(Colors.white.withOpacity(.1), Colors.black).withOpacity(effectValue),
      scaffoldBackgroundColor: Colors.black.withOpacity(effectValue),
      accentColor: Colors.white.toAccentColor(),
      scrollbarTheme: const ScrollbarThemeData(
        backgroundColor: Colors.transparent,
        hoveringThickness: 1,
        thickness: 1,
      ),
    );

    lightNoColorEffect = ThemeData(
      brightness: Brightness.light,
      cardColor: alphaBlend(Colors.black.withOpacity(.05), Colors.white).withOpacity(effectValue),
      scaffoldBackgroundColor: Colors.white.withOpacity(effectValue),
      accentColor: Colors.black.toAccentColor(),
      scrollbarTheme: const ScrollbarThemeData(
        backgroundColor: Colors.transparent,
        hoveringThickness: 1,
        thickness: 1,
      ),
    );

    darkColorEffect = ThemeData(
      brightness: Brightness.dark,
      cardColor: accentDarkCardColor!.withOpacity(effectValue),
      scaffoldBackgroundColor: accentDarkBackgroundColor!.withOpacity(effectValue),
      micaBackgroundColor: accentDarkMicaColor!.withOpacity(effectValue),
      inactiveBackgroundColor: accentDarkMicaColor!.withOpacity(effectValue),
      scrollbarTheme: ScrollbarThemeData(
        backgroundColor: Colors.transparent,
        scrollbarColor: systemAccentColor.accent,
        hoveringThickness: 1,
        thickness: 1,
      ),
      accentColor: systemAccentColor.accent.toAccentColor(),
    );

    lightColorEffect = ThemeData(
      brightness: Brightness.light,
      cardColor: accentLightCardColor!.withOpacity(effectValue),
      scaffoldBackgroundColor: accentLightBackgroundColor!.withOpacity(effectValue),
      micaBackgroundColor: accentLightMicaColor!.withOpacity(effectValue),
      inactiveBackgroundColor: accentLightMicaColor!.withOpacity(effectValue),
      scrollbarTheme: ScrollbarThemeData(
        backgroundColor: Colors.transparent,
        scrollbarColor: systemAccentColor.accent,
        hoveringThickness: 1,
        thickness: 1,
      ),
      accentColor: systemAccentColor.accent.toAccentColor(),
    );
  }
}
