import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/domain/models/data_model.dart';
import 'package:gibbon_music/updated_ui/theme_data.dart';
import 'package:system_theme/system_theme.dart';

enum ThemeType { darkColor, lightColor, darkNoColor, lightNoColor, systemTheme }

class ThemeProvider extends ChangeNotifier {
  GThemeCreator themeCreator = GThemeCreator();
  ThemeType themeType = ThemeType.lightNoColor;
  ThemeData? _theme;
  Color? _accentColor;
  bool isSystemTheme = false;

  ThemeProvider() {
    Future.delayed(const Duration(milliseconds: 2500)).then((value) {
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

  init() async {
    themeCreator.init(accentColor: SystemTheme.accentColor);
    theme = getTheme();
    accentColor = themeCreator.mainAccentColor;

    DataModel dataModel = DataModel();

    bool? hasSystemTheme = await dataModel.findKey(AppConsts.systemThemeKey);
    bool? hasThemeIndex = await dataModel.findKey(AppConsts.themeIndexKey);

    if (hasSystemTheme!) {
      bool? check = await dataModel.readBoolData(AppConsts.systemThemeKey);
      if (check!) {
        changeThemeType(ThemeType.systemTheme);
        setEffect(true);
        return;
      }
    }

    if (hasThemeIndex!) {
      int? index = await dataModel.readIntData(AppConsts.themeIndexKey);
      theme = getTheme(type: ThemeType.values[index!]);
      return;
    }

    if (SystemTheme.isDarkMode) {
      themeType = ThemeType.darkNoColor;
    } else {
      themeType = ThemeType.lightNoColor;
    }
  }

  changeThemeType(ThemeType type) {
    themeType = type;
    isSystemTheme = type == ThemeType.systemTheme;
    theme = getTheme();
  }

  ThemeData? getTheme({ThemeType? type}) {
    switch (type ?? themeType) {
      case ThemeType.darkColor:
        return themeCreator.darkColor;
      case ThemeType.lightColor:
        return themeCreator.lightColor;
      case ThemeType.darkNoColor:
        return themeCreator.darkNoColor;
      case ThemeType.lightNoColor:
        return themeCreator.lightNoColor;
      case ThemeType.systemTheme:
        return themeCreator.buildSystemTheme();
    }
  }

  Future<void> setEffect(bool isSystem) async {
    if (!isSystem) {
      await Window.setEffect(effect: WindowEffect.solid);
      return;
    }
    bool isDark = SystemTheme.isDarkMode;
    final deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isWindows) {
      WindowsDeviceInfo windowsDeviceInfo = await deviceInfoPlugin.windowsInfo;
      String product = windowsDeviceInfo.productName;
      if (product.contains("11")) {
        await Window.setEffect(effect: WindowEffect.mica, dark: isDark);
      } else {
        await Window.setEffect(effect: WindowEffect.acrylic, dark: isDark);
      }
    }
  }
}
