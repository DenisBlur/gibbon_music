import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';

import 'Styles/ConstValue.dart';

class GTextButton extends StatelessWidget {
  const GTextButton({Key key, @required this.onPress, @required this.text})
      : super(key: key);

  final String text;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return HoverButton(
      onPressed: onPress,
      builder: (p0, state) {
        return AnimatedDefaultTextStyle(
            style: TextStyle(
              fontSize: Platform.isAndroid ? 18 : 16,
              color: state.isHovering || state.isPressing
                  ? FluentTheme.of(context).accentColor
                  : FluentTheme.of(context).uncheckedColor.withOpacity(.5),
            ),
            duration: fastAnimation,
            child: Text(text));
      },
    );
  }
}
