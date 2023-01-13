import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/router.dart';
import 'package:gibbon_music/ui/controls/buttons.dart';
import 'package:go_router/go_router.dart';

import '../../constants/ui_consts.dart';
import '../widgets/scroller_scaffold.dart';

class PageHome extends StatelessWidget {
  const PageHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldScroller(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              AppConsts.defaultVSpacer,
              GButton(
                  onPressed: () {
                    AppRouter().gotoTest(context);
                  },
                  title: "Go to TestPage".toUpperCase()),
              GButton(
                  onPressed: () {
                    AppRouter().gotoDashboard(context);
                    // context.push("/dashboard");
                  },
                  title: "Go to Dashboard".toUpperCase())
            ],
          ),
        ),
      ],
    );
  }
}
