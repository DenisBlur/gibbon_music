import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/updated_ui/controls/buttons.dart';
import 'package:provider/provider.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../../constants/ui_consts.dart';
import '../../providers/ux_provider.dart';

class ContextWidget extends StatefulWidget {
  const ContextWidget({Key? key}) : super(key: key);

  @override
  State<ContextWidget> createState() => _ContextWidgetState();
}

class _ContextWidgetState extends State<ContextWidget> {
  final GlobalKey _keyRed = GlobalKey();
  var x = 0.0;
  var y = 0.0;

  @override
  Widget build(BuildContext context) {
    UxProvider ux = context.watch();
    print("$x : $y");
    return StreamBuilder<TapUpDetails>(
      stream: ux.onChangeDetails.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData && ux.isContextMenu) {
          var x = snapshot.data!.globalPosition.dx.toInt();
          var y = snapshot.data!.globalPosition.dy.toInt();

          return FadeInUp(
            duration: AppConsts.fastAnimation,
            child: Stack(
              children: [
                HoverButton(onTapDown: () {
                  ux.isContextMenu = false;
                }, builder: (p0, state) {
                  return Container(
                    color: Colors.black.withOpacity(.5),
                    width: AppConsts.pageSize(context).width,
                    height: AppConsts.pageSize(context).height,
                  );
                }),
                Consumer<UxProvider>(builder: (context, value, child) {
                  if (x > AppConsts.pageSize(context).width / 2) {
                    x -= 266;
                  }
                  if (y > AppConsts.pageSize(context).height / 2) {
                    y -= (25*2)+16;
                  }
                  return Positioned(
                    left: x.toDouble(),
                    top: y.toDouble(),
                    child: FadeInUp(
                      duration: Duration(milliseconds: 100),
                        child: SmoothContainer(
                      padding: const EdgeInsets.all(8),
                      key: _keyRed,
                      smoothness: 1,
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.teal,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 250,
                            height: 25,
                            child: GButton(onPressed: () {}, title: "Hello!"),
                          ),
                          SizedBox(
                            width: 250,
                            height: 25,
                            child: GButton(onPressed: () {}, title: "Hello!"),
                          )
                        ],
                      ),
                    )),
                  );
                })
              ],
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
