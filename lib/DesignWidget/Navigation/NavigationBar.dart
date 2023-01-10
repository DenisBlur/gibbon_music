import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/API/NotifyModels/UxNotifyModel.dart';
import 'package:gibbon_music/DesignWidget/Styles/ConstValue.dart';
import 'package:gibbon_music/main.dart';
import 'package:provider/provider.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key key}) : super(key: key);

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UxNotifyModel>(
      builder: (context, value, child) {
        bool isOpenNavigationBar = context.read<UxNotifyModel>().isOpenNavigationBar;
        double top = isOpenNavigationBar ? 60 : 44;
        double bottom = isOpenNavigationBar ? 116 : 100;
        double left = isOpenNavigationBar ? 16 : 0;
        double width = isOpenNavigationBar ? 300 : 56;
        Color bgColor = isOpenNavigationBar
            ? FluentTheme.of(context).cardColor.withOpacity(.5)
            : FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(1);
        return AnimatedContainer(
          width: width,
          height: MediaQuery.of(context).size.height,
          duration: slowAnimation,
          curve: Curves.fastLinearToSlowEaseIn,
          margin: EdgeInsets.only(top: top, bottom: bottom, left: left),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 50, sigmaX: 50),
                child: AnimatedContainer(
                  duration: fastAnimation,
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    color: bgColor,
                  ),
                  child: IconButton(
                    icon: const Icon(FluentIcons.add),
                    onPressed: () {
                      uxNotifyModel.changeNavigationBarState();
                    },
                  ),
                )),
          ),
        );
      },
    );
  }
}
