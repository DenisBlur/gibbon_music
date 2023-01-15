import 'package:fluent_ui/fluent_ui.dart';

class AppStyle {

  AppStyle._();

  static TextStyle subHeader1Style(BuildContext context) {
    return TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: FluentTheme.of(context).uncheckedColor.withOpacity(.6)
    );
  }

  static const TextStyle header1Style = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle subTrackHeaderStyle(BuildContext context) {
    return TextStyle(
        fontSize: 16,
        color: FluentTheme.of(context).uncheckedColor.withOpacity(.6)
    );
  }

  static TextStyle upCardHeaderStyle(BuildContext context) {
    return TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: FluentTheme.of(context).accentColor
    );
  }

  static const TextStyle trackHeaderStyle = TextStyle(
    fontSize: 16,
  );

  static const TextStyle cardHeaderStyle = TextStyle(
    fontSize: 14,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis
  );

}
