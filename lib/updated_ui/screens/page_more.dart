import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/updated_ui/widgets/custom_scaffold.dart';

import '../../constants/app_consts.dart';
import '../utils/dynamic_data.dart';

class PageMore extends StatelessWidget {
  const PageMore({Key? key, required this.listData, required this.title}) : super(key: key);

  final List<dynamic> listData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(children: [
      Text(
        title,
        style: AppStyle.title(context),
      ),
      AppConsts.defaultVSpacer,
      SliverGrid(
          delegate: SliverChildBuilderDelegate((context, index) {
            return getDynamicData(listData, index);
          }, childCount: listData.length),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: AppConsts.pageSize(context).width ~/ (AppConsts.defaultCardHeight - 64), childAspectRatio: 8, crossAxisSpacing: 8, mainAxisExtent: AppConsts.defaultCardHeight))
    ]);
  }
}
