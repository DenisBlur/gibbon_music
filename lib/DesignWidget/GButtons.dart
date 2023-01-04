import 'package:fluent_ui/fluent_ui.dart';

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
              color: state.isHovering
                  ? FluentTheme.of(context).accentColor
                  : FluentTheme.of(context).uncheckedColor.withOpacity(.5),
            ),
            duration: const Duration(milliseconds: 100),
            child: Text(text));
      },
    );
  }
}
