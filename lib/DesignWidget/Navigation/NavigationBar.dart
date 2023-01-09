import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/API/Models/NotifyModels/GeneralNotifyModel.dart';
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
    return HoverButton(
      onPressed: () {},
      builder: (p0, state) {
        double top = state.isHovering ? 60 : 44;
        double bottom = state.isHovering ? 132 : 116;
        double left = state.isHovering ? 16 : 0;
        double width = state.isHovering ? 300 : 56;
        Color bgColor = state.isHovering
            ? FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(.1)
            : FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(1);

        return AnimatedContainer(
          width: width,
          height: MediaQuery.of(context).size.height,
          duration: const Duration(milliseconds: 650),
          curve: Curves.fastLinearToSlowEaseIn,
          margin: EdgeInsets.only(top: top, bottom: bottom, left: left),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 50, sigmaX: 50),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 650),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    color: bgColor,
                  ),
                  child: Column(
                    children: [
                      for (int i = 0;
                          i <
                              context
                                  .watch<GeneralNotifyModel>()
                                  .mPlaylist
                                  .length;
                          i++)
                        HoverButton(
                          onPressed: () {
                            generalNotifyModel.playTrack(i);
                          },
                          builder: (p0, state) {
                            return AnimatedContainer(
                              decoration: BoxDecoration(
                                  color: context
                                              .watch<GeneralNotifyModel>()
                                              .currentIndex ==
                                          i
                                      ? Colors.blue
                                      : Colors.transparent),
                              duration: Duration(milliseconds: 250),
                              child: Text(context
                                  .watch<GeneralNotifyModel>()
                                  .mPlaylist[i]
                                  .title),
                            );
                          },
                        )
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
