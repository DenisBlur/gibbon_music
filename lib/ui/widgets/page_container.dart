import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:gibbon_music/ui/widgets/window_header.dart';
import 'package:provider/provider.dart';

import '../../constants/ui_consts.dart';
import '../../providers/audio_provider.dart';

class PageContainer extends StatelessWidget {
  const PageContainer({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    context.read<AudioProvider>().init();
    return Stack(
      children: [
        Positioned(
          top: AppConsts.windowHeader,
          left: 0,
          right: 0,
          bottom: 50,
          child: child,
        ),
        WindowHeader(title: "YandexMusic", backArrow: true, setting: false, key: key),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            height: 50,
            color: FluentTheme.of(context).cardColor,
          ),
        )
      ],
    );
  }
}
