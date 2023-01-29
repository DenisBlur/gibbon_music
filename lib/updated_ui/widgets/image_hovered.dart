import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../../constants/app_consts.dart';
import 'ImageThumbnail.dart';

class ImageHovered extends StatelessWidget {
  const ImageHovered(
      {Key? key,
      required this.imageState,
      required this.uri,
      this.uriSize = 200,
      this.width = AppConsts.defaultCardWidth,
      this.height = AppConsts.defaultCardWidth,
      this.linkImage = true})
      : super(key: key);

  final double? imageState, width, height;
  final String uri;
  final bool? linkImage;
  final int? uriSize;

  @override
  Widget build(BuildContext context) {
    var theme = FluentTheme.of(context);
    return AnimatedScale(
        scale: imageState!,
        duration: AppConsts.defaultAnimation,
        curve: AppConsts.defaultCurve,
        child: Container(
          decoration: ShapeDecoration(
              gradient: LinearGradient(colors: [
                theme.scaffoldBackgroundColor.withOpacity(1),
                theme.scaffoldBackgroundColor.withOpacity(0),
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
              shape: SmoothRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                smoothness: 1,
              ),
              shadows: [
                BoxShadow(offset: const Offset(0, 6), blurRadius: 5, color: Colors.black.withOpacity(.1)),
              ]),
          child: ImageThumbnail(url: linkImage! ? uri.linkImage(uriSize!) : uri, width: width!, height: height!, radius: 24),
        ));
  }
}
