import 'package:fluent_ui/fluent_ui.dart';

class ContentLoader extends StatelessWidget {
  const ContentLoader({Key key, @required this.future, @required this.builder}) : super(key: key);

  final AsyncWidgetBuilder builder;
  final Future<dynamic> future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: builder,
    );
  }
}
