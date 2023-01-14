import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';

class AppContext {
  AppContext._();

  static showContext(BuildContext context, TapDownDetails details, List<Widget> children) {
    double width = MediaQuery.of(context).size.width / 2;
    Offset position = details.globalPosition;

    if (position.dx > width) {
      position = Offset(position.dx - 250, position.dy);
    }

    showMenu(
        context: context,
        offset: position,
        builder: (BuildContext context) => SizedBox(
            height: children.length * 35.0,
            width: 250,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: FluentTheme.of(context).accentColor.withOpacity(.2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: children,
                        ))))));
  }
}
