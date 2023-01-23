import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:gibbon_music/enums/e_list_typer.dart';
import 'package:gibbon_music/router.dart';
import 'package:gibbon_music/updated_ui/utils/dynamic_data.dart';

import '../../constants/style_consts.dart';
import '../controls/buttons.dart';

class DynamicListWidget extends StatelessWidget {
  const DynamicListWidget({Key? key, required this.listData, required this.title, this.listType = ListType.standart, this.canMore = true}) : super(key: key);

  final List<dynamic> listData;
  final String title;
  final ListType? listType;
  final bool? canMore;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: AppConsts.pageOffset,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppStyle.subTitle(context),
                  ),
                  AppConsts.fillSpacer,
                  canMore! ? GButton(onPressed: () {
                    AppRouter().gotoMore(context, listData, title);
                  }, title: "More") : const SizedBox(),
                ],
              ),
            ),
            AppConsts.smallVSpacer,
            SizedBox(
              width: AppConsts.pageSize(context).width,
              height: listType == ListType.standart ? AppConsts.defaultCardHeight : AppConsts.wideCardHeight(context),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: index == 0 ? AppConsts.pageOffset.horizontal / 2 : 0, right: AppConsts.pageOffset.horizontal / 2),
                    child: getDynamicData(listData, index),
                  );
                },
                itemCount: listData.length,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
