import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/main.dart';
import 'package:gibbon_music/ui/theme_data.dart';

import '../../constants/ui_consts.dart';

class GButton extends StatelessWidget {
  const GButton({Key key, @required this.onPressed, @required this.title}) : super(key: key);

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    Color defaultStateColor, hoverStateColor, pressedStateColor;

    var theme = FluentTheme.of(context);

    defaultStateColor = theme.cardColor.withOpacity(.5);
    hoverStateColor = theme.accentColor.withOpacity(.4);
    pressedStateColor = theme.accentColor.withOpacity(.2);

    return m.Material(
      color: defaultStateColor,
      borderRadius: BorderRadius.circular(4),
      child: m.InkWell(
        splashColor: pressedStateColor,
        borderRadius: BorderRadius.circular(4),
        onTap: () {
          onPressed();
        },
        hoverColor: hoverStateColor,
        child: AnimatedContainer(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 2),
          duration: AppConsts.defaultAnimation,
          curve: AppConsts.defaultCurve,
          decoration: BoxDecoration(
            border: Border.all(color: theme.borderInputColor.withOpacity(.2), width: .5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(title),
        ),
      ),
    );
  }
}

class GTextButton extends StatelessWidget {
  const GTextButton({Key key, @required this.onPressed, @required this.title}) : super(key: key);

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    var theme = FluentTheme.of(context);

    var defaultStateColor = theme.uncheckedColor;
    var hoverStateColor = theme.accentColor.withOpacity(1);
    var pressedStateColor = theme.accentColor.withOpacity(0.8);

    return HoverButton(
      onPressed: onPressed,
      builder: (p0, state) {
        var textColor = state.isPressing
            ? pressedStateColor
            : state.isHovering
                ? hoverStateColor
                : defaultStateColor;

        return AnimatedDefaultTextStyle(style: TextStyle(color: textColor), duration: AppConsts.defaultAnimation, child: Text(title));
      },
    );
  }
}

class GIconButton extends StatelessWidget {
  const GIconButton({Key key, @required this.onPressed, @required this.icon, this.contrastBackground = false, this.size = 18, this.padding = 8})
      : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;
  final double size, padding;
  final bool contrastBackground;

  @override
  Widget build(BuildContext context) {
    Color defaultStateColor, hoverStateColor, pressedStateColor, iconColor;

    var theme = FluentTheme.of(context);

    if (!contrastBackground) {
      defaultStateColor = theme.checkedColor.withOpacity(0);
      hoverStateColor = theme.checkedColor.withOpacity(.8);
      pressedStateColor = theme.checkedColor.withOpacity(.4);
    } else {
      defaultStateColor = theme.uncheckedColor.withOpacity(1);
      hoverStateColor =  GThemeCreator.alphaBlend(theme.checkedColor.withOpacity(.1), theme.uncheckedColor);
      pressedStateColor = GThemeCreator.alphaBlend(theme.accentColor.withOpacity(.1), theme.uncheckedColor);
      iconColor = theme.checkedColor.withOpacity(1);
    }

    return HoverButton(
      onPressed: () => onPressed(),
      builder: (p0, state) {
        Color bgColor = state.isPressing
            ? pressedStateColor
            : state.isHovering
                ? hoverStateColor
                : defaultStateColor;

        return AnimatedContainer(
          padding: EdgeInsets.all(padding),
          duration: AppConsts.defaultAnimation,
          curve: AppConsts.defaultCurve,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size * 2),
            color: bgColor,
          ),
          child: Icon(icon, size: size, color: iconColor),
        );
      },
    );
  }
}
