import 'dart:io' show Platform;

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/API/Models/NewHomePage/MV_HomePage.dart';
import 'package:gibbon_music/Platform/Andorid/AndroidBuilderFile.dart';
import 'package:gibbon_music/Platform/Windows/WindowsBuilderFile.dart';
import 'package:gibbon_music/Theme/ThemeCreater.dart';
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';

import 'Theme/ThemeModel.dart';

//Просто акцент
SystemAccentColor accentColor = SystemTheme.accentColor;
//Основная модель приложения
ThemeModel themeModel = ThemeModel();
//Моделька с HomePage яндекс музыки
MVHomePage mHomePage = MVHomePage();
//Основные темы
GThemeCreator gThemeCreator = GThemeCreator();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    //Убираем TitleBar, ставим минимальный размер приложения и центрируем
    WindowOptions windowOptions = const WindowOptions(
      minimumSize: Size(800, 400),
      center: true,
      size: Size(1280, 720),
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );

    //показ приложения и центрирование, а так же установка фокуса на приложение
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.center();
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    //Инициализация тем приложения
    GThemeCreator.setColors(SystemTheme.accentColor.accent);

    return ChangeNotifierProvider(
      create: (_) => themeModel = ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, value, child) {
          return FluentApp(
            title: "Music",
            theme: GThemeCreator.darkNoColor,
            home: Platform.isAndroid
                ? const AndroidBuilderFile()
                : const WindowsBuilderFile(),
          );
        },
      ),
    );
  }
}
