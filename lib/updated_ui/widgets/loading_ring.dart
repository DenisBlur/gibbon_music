import 'package:fluent_ui/fluent_ui.dart';
import 'package:animate_do/animate_do.dart';

class LoadingRing extends StatelessWidget {
  const LoadingRing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;

    return ScaffoldPage(
      content: SizedBox(
        height: pageSize.height,
        width: pageSize.width,
        child: FadeInUp(
            child: Center(
              child: ProgressRing(),
            )),
      ),
    );
  }
}
