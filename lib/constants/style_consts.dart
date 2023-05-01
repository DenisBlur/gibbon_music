import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/updated_ui/utils/ui_utils.dart';

class AppStyle {

  AppStyle._();

  static TextStyle title(BuildContext context) {
    return TextStyle(
      fontSize: Responsive.isDesktop(context) ? 32 : 32,
      fontWeight: FontWeight.bold
    );
  }

  static TextStyle subTitle(BuildContext context) {
    return TextStyle(
        fontSize: Responsive.isDesktop(context) ? 20 : 20,
        fontWeight: FontWeight.bold,
        color: FluentTheme.of(context).uncheckedColor.withOpacity(.9)
    );
  }

  static TextStyle prTitle(BuildContext context) {
    return const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold
    );
  }

  static TextStyle prSubTitle(BuildContext context) {
    return TextStyle(
        fontSize: 14,
        color: FluentTheme.of(context).uncheckedColor.withOpacity(.9)
    );
  }

  static TextStyle prHeading(BuildContext context) {
    return TextStyle(
        fontSize: 14,
        color: FluentTheme.of(context).accentColor.withOpacity(.9)
    );
  }


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
