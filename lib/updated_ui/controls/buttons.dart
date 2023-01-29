import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/updated_ui/theme_data.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../../constants/app_consts.dart';
import '../widgets/image_hovered.dart';

class GButton extends StatelessWidget {
  const GButton({Key? key, required this.onPressed, required this.title}) : super(key: key);

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    Color defaultStateColor, hoverStateColor, pressedStateColor;

    var theme = FluentTheme.of(context);

    defaultStateColor = GThemeCreator().alphaBlend(theme.accentColor.withOpacity(.1), theme.cardColor);
    hoverStateColor = GThemeCreator().alphaBlend(theme.accentColor.withOpacity(.4), theme.cardColor);
    pressedStateColor = GThemeCreator().alphaBlend(theme.accentColor.withOpacity(.2), theme.cardColor);

    return HoverButton(
      onPressed: () => onPressed(),
      builder: (p0, state) {
        Color bgColor = state.isPressing
            ? pressedStateColor
            : state.isHovering
                ? hoverStateColor
                : defaultStateColor;

        return SmoothClipRRect(
          smoothness: 1,
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: theme.borderInputColor.withOpacity(state.isHovering ? .2 : 0), width: .3),
          child: AnimatedContainer(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 4),
            duration: AppConsts.defaultAnimation,
            curve: AppConsts.defaultCurve,
            color: bgColor,
            child: Text(
              title.toLowerCase(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}

class GImageButton extends StatelessWidget {
  const GImageButton({Key? key, required this.onPressed, required this.uri, this.width = 48, this.height = 48}) : super(key: key);

  final VoidCallback onPressed;
  final String uri;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return HoverButton(
      onPressed: onPressed,
      builder: (p0, state) {
        double imageState = 1.0;
        if (state.isPressing) {
          imageState = 0.9;
        } else if (state.isHovering) {
          imageState = 0.98;
        } else {
          imageState = .95;
        }

        return ImageHovered(
          imageState: imageState,
          uri: uri,
          linkImage: false,
          width: width,
          height: height,
        );
      },
    );
  }
}

class GTextButton extends StatelessWidget {
  const GTextButton({Key? key, required this.onPressed, required this.title}) : super(key: key);

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

        return AnimatedDefaultTextStyle(
            style: TextStyle(color: textColor),
            duration: AppConsts.defaultAnimation,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ));
      },
    );
  }
}

class GIconButton extends StatelessWidget {
  const GIconButton(
      {Key? key,
      required this.onPressed,
      required this.icon,
      this.contrastBackground = false,
      this.size = 18,
      this.padding = 8,
      this.iconColor = Colors.transparent})
      : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;
  final double size, padding;
  final bool contrastBackground;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    Color defaultStateColor, hoverStateColor, pressedStateColor, iColor;

    var theme = FluentTheme.of(context);

    if (!contrastBackground) {
      defaultStateColor = theme.cardColor.withOpacity(0);
      hoverStateColor = theme.cardColor.withOpacity(.8);
      pressedStateColor = theme.cardColor.withOpacity(.4);
    } else {
      defaultStateColor = theme.uncheckedColor.withOpacity(1);
      hoverStateColor = GThemeCreator().alphaBlend(theme.checkedColor.withOpacity(.1), theme.uncheckedColor);
      pressedStateColor = GThemeCreator().alphaBlend(theme.accentColor.withOpacity(.1), theme.uncheckedColor);
    }

    if (iconColor == Colors.transparent) {
      iColor = !contrastBackground ? theme.uncheckedColor.withOpacity(1) : theme.checkedColor.withOpacity(1);
    } else {
      iColor = iconColor;
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
          child: Icon(icon, size: size, color: iColor),
        );
      },
    );
  }
}
