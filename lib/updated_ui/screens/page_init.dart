import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/updated_ui/screens/page_landing.dart';
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';

import '../../main.dart';
import '../../providers/yandex_provider.dart';

class PageInit extends StatelessWidget {
  const PageInit({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  Widget build(BuildContext context) {

    client.init(token: token).then((value) async {
      if(value) {
        YandexProvider provider = context.read();
        await provider.likeModel.init().whenComplete(() {
          Navigator.pop(context);
          Navigator.push(
              context,
              FluentPageRoute(
                builder: (context) => const UPageLanding(),
              ));
        });
      } else {
        Navigator.pop(context);
      }
    });

    Size pageSize = MediaQuery.of(context).size;
    return ScaffoldPage(
      content: SizedBox(
          height: pageSize.height,
          width: pageSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 0, height: 0, color: SystemTheme.accentColor.accent,),
              FadeInUp(
                  child: Text(
                "получение данных о пользователе.",
                style: AppStyle.subTitle(context),
              )),
              AppConsts.bigVSpacer,
              FadeInUp(
                delay: const Duration(milliseconds: 150),
                child: const ProgressRing(),
              ),
            ],
          )),
    );
  }
}
