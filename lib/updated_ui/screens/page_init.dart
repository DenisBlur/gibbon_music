import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/updated_ui/widgets/overlay_container.dart';
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';

import '../../main.dart';
import '../../providers/yandex_provider.dart';

class PageInit extends StatefulWidget {
  const PageInit({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<PageInit> createState() => _PageInitState();
}

class _PageInitState extends State<PageInit> {
  @override
  void initState() {
    super.initState();
    client.init(token: widget.token).then((value) async {
      if (value) {
        YandexProvider provider = context.read();
        await provider.likeModel.init().whenComplete(() {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OverlayContainer(),
              ));
        });
      } else {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
          height: pageSize.height,
          width: pageSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 0,
                height: 0,
                color: SystemTheme.accentColor.accent,
              ),
              const Text(
                "получение данных о пользователе.",
              )
                  .animate()
                  .fadeIn(duration: AppConsts.defaultAnimation, curve: AppConsts.defaultCurve)
                  .moveY(begin: 150, end: 0, duration: AppConsts.defaultAnimation, curve: AppConsts.defaultCurve),
              AppConsts.bigVSpacer,
              const CircularProgressIndicator()
                  .animate(delay: 250.ms)
                  .fadeIn(duration: AppConsts.defaultAnimation, curve: AppConsts.defaultCurve)
                  .moveY(begin: 150, end: 0, duration: AppConsts.defaultAnimation, curve: AppConsts.defaultCurve),
            ],
          )),
    );
  }
}
