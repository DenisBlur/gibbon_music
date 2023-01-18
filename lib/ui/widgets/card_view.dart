import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

import '../../constants/ui_consts.dart';

class GCardView extends StatelessWidget {
  const GCardView({Key? key, required this.child,required this.onPressed, this.radius = 8}) : super(key: key);

  final Widget child;
  final double radius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Color defaultStateColor, hoverStateColor, pressedStateColor;

    var theme = FluentTheme.of(context);

    defaultStateColor = theme.cardColor.withOpacity(0);
    hoverStateColor = theme.cardColor.withOpacity(.4);
    pressedStateColor = theme.accentColor.withOpacity(.2);

    return HoverButton(
      onPressed: () => onPressed(),
      builder: (p0, state) {
        Color bgColor = state.isPressing
            ? pressedStateColor
            : state.isHovering
            ? hoverStateColor
            : defaultStateColor;

        return AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: bgColor,
          ),
          duration: AppConsts.defaultAnimation,
          curve: AppConsts.defaultCurve,
          child: child,
        );
      },
    );

  }
}
