
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../constants/app_consts.dart';

class LoadingRing extends StatelessWidget {
  const LoadingRing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
          height: pageSize.height,
          width: pageSize.width,
          child: const Center(
            child: CircularProgressIndicator(),
          )
              .animate()
              .fadeIn(duration: AppConsts.defaultAnimation, curve: AppConsts.defaultCurve)
              .moveY(begin: 150, end: 0, duration: AppConsts.defaultAnimation, curve: AppConsts.defaultCurve)),
    );
  }
}
