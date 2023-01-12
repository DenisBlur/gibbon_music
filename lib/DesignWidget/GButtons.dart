import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';

import 'Styles/ConstValue.dart';

class GTextButton extends StatelessWidget {
  GTextButton({Key key, @required this.onPress, @required this.text, this.defaultColor = Colors.errorPrimaryColor})
      : super(key: key);

  final String text;
  final VoidCallback onPress;
  Color defaultColor;

  @override
  Widget build(BuildContext context) {

    if (defaultColor == Colors.errorPrimaryColor) {
      defaultColor = FluentTheme.of(context).uncheckedColor.withOpacity(.5);
    }

    return HoverButton(
      onPressed: onPress,
      builder: (p0, state) {
        return AnimatedDefaultTextStyle(
            style: TextStyle(
              fontSize: Platform.isAndroid ? 18 : 16,
              color: state.isHovering || state.isPressing
                  ? FluentTheme.of(context).accentColor
                  : defaultColor,
            ),
            duration: fastAnimation,
            child: Text(text));
      },
    );
  }
}
