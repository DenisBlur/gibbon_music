import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/updated_ui/widgets/custom_scaffold.dart';
import 'package:gibbon_music/updated_ui/widgets/loading_ring.dart';

import '../../constants/app_consts.dart';
import '../utils/dynamic_data.dart';

class PageMore extends StatelessWidget {
  const PageMore({Key? key, this.listData, required this.title, this.future}) : super(key: key);

  final List<dynamic>? listData;
  final String title;
  final Future<List<dynamic>?>? future;

  @override
  Widget build(BuildContext context) {
    return future != null
        ? FutureBuilder<List<dynamic>?>(
            future: future,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                return MoreContent(listData: snapshot.data!, title: title);
              } else {
                return const LoadingRing();
              }
            },
          )
        : MoreContent(listData: listData!, title: title);
  }
}

class MoreContent extends StatelessWidget {
  const MoreContent({Key? key, required this.listData, required this.title}) : super(key: key);

  final List<dynamic> listData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(children: [
      AppConsts.defaultVSpacer,
      Text(
        title,
        style: AppStyle.title(context),
      ),
      AppConsts.defaultVSpacer,
      SliverGrid(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Center(child: getDynamicData(listData, index));
          }, childCount: listData.length),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: AppConsts.pageSize(context).width ~/ (AppConsts.defaultCardHeight - 64),
              childAspectRatio: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: AppConsts.defaultCardHeight))
    ]);
  }
}
