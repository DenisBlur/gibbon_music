import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

import '../../constants/ui_consts.dart';

class GCardView extends StatelessWidget {
  const GCardView({Key key, @required this.child, this.onPressed}) : super(key: key);

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {

    Color defaultStateColor, hoverStateColor, pressedStateColor;

    var theme = FluentTheme.of(context);

    defaultStateColor = theme.cardColor.withOpacity(0);
    hoverStateColor = theme.cardColor.withOpacity(.4);
    pressedStateColor = theme.accentColor.withOpacity(.2);

    return Material(
      borderRadius: BorderRadius.circular(8),
      color: defaultStateColor,
      child: InkWell(
        splashColor: pressedStateColor,
        borderRadius: BorderRadius.circular(8),
        highlightColor:defaultStateColor,
        hoverColor: hoverStateColor,
        onTap: () => onPressed(),
        child: child,
      ),
    );
  }
}
