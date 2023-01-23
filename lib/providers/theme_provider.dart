import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/updated_ui/theme_data.dart';
import 'package:system_theme/system_theme.dart';

enum ThemeType {
  darkColor,
  lightColor,
  darkNoColor,
  lightNoColor
}

class ThemeProvider extends ChangeNotifier {

  GThemeCreator themeCreator = GThemeCreator();
  ThemeType themeType = ThemeType.lightNoColor;
  ThemeData? _theme;
  Color? _accentColor;

  ThemeProvider() {
    Future.delayed(const Duration(milliseconds: 1500)).then((value) {
      init();
    });
  }


  Color? get accentColor => _accentColor;

  set accentColor(Color? value) {
    _accentColor = value;
    notifyListeners();
  }

  ThemeData? get theme => _theme;
  set theme(ThemeData? value) {
    _theme = value;
    notifyListeners();
  }

  init() {
    if(SystemTheme.isDarkMode) {
      themeType = ThemeType.darkNoColor;
    } else {
      themeType = ThemeType.lightColor;
    }
    themeCreator.init(accentColor: SystemTheme.accentColor);
    theme = getTheme();
    accentColor = themeCreator.mainAccentColor;
  }

  changeThemeType(ThemeType type) {
    themeType = type;
    theme = getTheme();
  }

  ThemeData? getTheme() {
    switch(themeType) {
      case ThemeType.darkColor:
        return themeCreator.darkColor;
      case ThemeType.lightColor:
        return themeCreator.lightColor;
      case ThemeType.darkNoColor:
        return themeCreator.darkNoColor;
      case ThemeType.lightNoColor:
        return themeCreator.lightNoColor;
    }

  }


}