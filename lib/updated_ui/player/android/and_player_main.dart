import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:provider/provider.dart';
import '../../../providers/ux_provider.dart';
import 'and_player_info.dart';

class AndPlayerMain extends StatelessWidget {
  const AndPlayerMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: AppConsts.defaultAnimation,
        curve: AppConsts.defaultCurve,
        decoration: BoxDecoration(
          color: FluentTheme.of(context).cardColor,
        ),
        child: const AndPlayerInfo());
  }
}
