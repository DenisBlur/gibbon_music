import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/API/Models/NotifyModels/GeneralNotifyModel.dart';
import 'package:gibbon_music/DesignWidget/GDragWidget.dart';
import 'package:gibbon_music/DesignWidget/Navigation/NavigationBar.dart';
import 'package:gibbon_music/DesignWidget/Player/Windows/WinAudioPlayer.dart';
import 'package:provider/provider.dart';

import 'Navigation/WindowHeader.dart';

class OverlayWidgets extends StatefulWidget {
  const OverlayWidgets({Key key}) : super(key: key);

  @override
  State<OverlayWidgets> createState() => _OverlayWidgetsState();
}

class _OverlayWidgetsState extends State<OverlayWidgets> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Platform.isAndroid ? const SizedBox() : const NavigationBar(),
        Platform.isAndroid
            ? const SizedBox()
            : WindowHeader(
                title: 'Yandex Music',
                backArrow: context.watch<GeneralNotifyModel>().backArrow,
                setting: false),
        Platform.isAndroid
            ? const Align(
                alignment: Alignment.bottomCenter,
                child: GDragWidget(),
              )
            : const Align(
                alignment: Alignment.bottomCenter,
                child: AudioPlayerWidget(),
              ),
      ],
    );
  }
}
