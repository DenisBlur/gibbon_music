import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';

import '../../main.dart';
import 'ImageResizer.dart';

String pathName = "";
File fileFiles = File("");

class MicaSupportClass {
  static micaInit() {
    getTemporaryDirectory().then((value) {
      pathName = (value.parent.parent.parent.path
          .substring(9, (value.parent.parent.parent.path.length)));
      ImageSupport.resize(
          "C:/Users/$pathName/AppData/Roaming/Microsoft/Windows/Themes/TranscodedWallpaper")
          .then((value) {
        fileFiles = value;
      });
    });
  }
}

class MicaBackground extends StatefulWidget {
  const MicaBackground({Key? key, required this.widget}) : super(key: key);
  final Widget widget;

  @override
  State<MicaBackground> createState() => _MicaBackgroundState();
}

class _MicaBackgroundState extends State<MicaBackground>
    with WindowListener, SingleTickerProviderStateMixin {
  double x = 0.5;
  double y = 0.5;
  double posX = 0.5;
  double posY = 0.5;
  double _start = 0;
  late Animation<double> animation;
  late AnimationController controller;
  bool show = false;

  late Size valueSize = const Size(0, 0);

  int imageWidth = 0;
  int imageHeight = 0;

  double pX = 0.0;
  double pY = 0.0;

  void setData() async {
    var decodedImage = await decodeImageFromList(fileFiles.readAsBytesSync());
    imageWidth = decodedImage.width;
    imageHeight = decodedImage.height;
  }

  void setImage() {
    if (mounted) {
      windowManager.getPosition().then((value) {
        posX = value.dx;
        posY = value.dy;
      });
      windowManager.getSize().then((value) {
        valueSize = value;
      });
      setState(() {
        if ((posX + valueSize.width / 2) < imageWidth / 2) {
          pX = ((imageWidth / 2) - (posX + valueSize.width / 2)) /
              (imageWidth / 2);
          x = ((posX + valueSize.width / 2) / imageWidth) - pX;
        } else {
          pX = ((imageWidth / 2) - (posX + valueSize.width / 2)) /
              (imageWidth / 2);
          x = ((posX + valueSize.width / 2) / imageWidth) - pX;
        }

        if ((posY + valueSize.height / 2) < imageHeight / 2) {
          pY = ((imageHeight / 2) - (posY + valueSize.height / 2)) /
              (imageHeight / 2);
          y = ((posY + valueSize.height / 2) / imageHeight) - pY;
        } else {
          pY = ((imageHeight / 2) - (posY + valueSize.height / 2)) /
              (imageHeight / 2);
          y = ((posY + valueSize.height / 2) / imageHeight) - pY;
        }
      });
      if (!show) {
        controller.forward();
        show = true;
      }
    }
  }

  @override
  void onWindowMove() {
    windowManager.getSize().then((value) {
      valueSize = value;
    });
    windowManager.getPosition().then((value) {
      posX = value.dx;
      posY = value.dy;
    });
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    animation = Tween<double>(begin: 1, end: .6).animate(controller);

    windowManager.addListener(this);

    const oneSec = Duration(milliseconds: 100);
    Timer.periodic(
      oneSec,
          (Timer timer) {
        if (mounted) {
          _start += 1;
          setData();
          setImage();
        }
        if (_start > 100) {
          timer.cancel();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 1,
        child: Stack(children: [
          Image.file(
            fileFiles,
            repeat: ImageRepeat.repeat,
            width: 5000,
            height: 5000,
            fit: BoxFit.none,
            alignment: FractionalOffset(
                x.isInfinite ? 0.5 : x, y.isInfinite ? 0.5 : y),
          ),
          Center(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(
                  width: 2500,
                  height: 2500,
                  color: FluentTheme.of(context)
                      .acrylicBackgroundColor
                      .withOpacity(animation.value),
                )),
          ),
          Center(
            child: Opacity(
              opacity: .05,
              child: Image.asset("assets/AcrylicNoise.png",
                  repeat: ImageRepeat.repeat,
                  width: 1920,
                  height: 1080,
                  alignment: FractionalOffset(x.isInfinite ? 0.5 : x * -1,
                      y.isInfinite ? 0.5 : y * -1)),
            ),
          ),
          widget.widget,
        ]));
  }
}
