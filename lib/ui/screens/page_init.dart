import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/ui/widgets/loading_ring.dart';
import 'package:system_theme/system_theme.dart';

class PageInit extends StatelessWidget {
  const PageInit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  child: const Text(
                "Initialize YamApi",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
