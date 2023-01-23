
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/ui_consts.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageThumbnail extends StatelessWidget {
  const ImageThumbnail({Key? key, required this.url, this.radius = 8, this.width = 56, this.height = 56}) : super(key: key);

  final String url;
  final double radius, width, height;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppConsts.defaultAnimation,
      curve: AppConsts.defaultCurve,
      width: width,
      height: height,
      child: SmoothClipRRect(
        smoothness: 1,
        borderRadius: BorderRadius.circular(radius),
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: url,
          width: AppConsts.pageSize(context).width,
          height: AppConsts.pageSize(context).height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
