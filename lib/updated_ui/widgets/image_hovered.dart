import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/extensions/string.dart';
import '../../constants/app_consts.dart';
import 'Image_thumbnail.dart';

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
          child: ImageThumbnail(url: linkImage! ? uri.linkImage(uriSize!) : uri, width: width!, height: height!, radius: 24),
        ));
  }
}
