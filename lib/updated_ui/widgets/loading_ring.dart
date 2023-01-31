import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../constants/app_consts.dart';

class LoadingRing extends StatelessWidget {
  const LoadingRing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;

    return ScaffoldPage(
      content: SizedBox(
          height: pageSize.height,
          width: pageSize.width,
          child: const Center(
            child: ProgressRing(),
          )
              .animate()
              .fadeIn(duration: AppConsts.defaultAnimation, curve: AppConsts.defaultCurve)
              .moveY(begin: 150, end: 0, duration: AppConsts.defaultAnimation, curve: AppConsts.defaultCurve)),
    );
  }
}
