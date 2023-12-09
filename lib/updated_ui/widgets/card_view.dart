import 'package:flutter/material.dart';
import '../../constants/app_consts.dart';

class GCardView extends StatelessWidget {
  const GCardView({Key? key, required this.child,required this.onPressed, this.radius = 8}) : super(key: key);

  final Widget child;
  final double radius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onPressed,child: AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      duration: AppConsts.defaultAnimation,
      curve: AppConsts.defaultCurve,
      child: child,
    ),);

  }
}
