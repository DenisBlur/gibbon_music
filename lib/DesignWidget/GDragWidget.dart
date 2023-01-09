import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/DesignWidget/Player/Android/AndAudioPlayer.dart';
import 'package:gibbon_music/DesignWidget/Player/Android/AndBigAudioPlayer.dart';
import 'package:gibbon_music/DesignWidget/Styles/ConstValue.dart';

class GDragWidget extends StatefulWidget {
  const GDragWidget({Key key}) : super(key: key);

  @override
  State<GDragWidget> createState() => _GDragWidgetState();
}

class _GDragWidgetState extends State<GDragWidget> {
  double maxWidth = 0;
  double maxHeight = 0;
  double minHeight = 64;
  double height = 0;
  double opacity = 0;

  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    height = minHeight;
  }

  @override
  Widget build(BuildContext context) {
    maxWidth = MediaQuery.of(context).size.width;
    maxHeight = MediaQuery.of(context).size.height;

    return Draggable(
      onDragUpdate: (details) {
        setState(() {
          height = (height - details.delta.dy).clamp(0, maxHeight).toDouble();
        });
      },
      onDragEnd: (details) {
        setState(() {
          if (height > maxHeight / 4) {
            height = maxHeight;
            isOpen = true;
          } else {
            height = minHeight;
            isOpen = false;
          }
        });
      },
      feedback: const SizedBox(),
      axis: Axis.vertical,
      child: AnimatedContainer(
          constraints: BoxConstraints(
            minHeight: minHeight,
          ),
          curve: Curves.fastLinearToSlowEaseIn,
          duration: slowAnimation,
          width: MediaQuery.of(context).size.width,
          height: height,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    offset: const Offset(0, -4),
                    blurRadius: 10)
              ],),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: FluentTheme.of(context).cardColor.withOpacity(.8)
                ),
                child: Column(
                  children: [
                    SizedBox(height: minHeight, child: AnimatedOpacity(
                      opacity: (1-((height) / maxHeight)).clamp(0.0, 1.0),
                      duration: dragAnimation,
                      child: const AudioPlayerWidget(),
                    ),),
                    Expanded(
                      child: AnimatedOpacity(
                        opacity: ((height-minHeight) / maxHeight).clamp(0.0, 1.0),
                        duration: dragAnimation,
                        child: const BigAudioWidget(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
