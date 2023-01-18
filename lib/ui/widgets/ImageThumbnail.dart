import 'package:fluent_ui/fluent_ui.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageThumbnail extends StatelessWidget {
  const ImageThumbnail({Key? key, required this.url, this.radius = 8, this.width = 56, this.height = 56}) : super(key: key);

  final String url;
  final double radius, width, height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: BorderRadius.circular(radius),child: FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: url,
      width: width,
      height: height,
      fit: BoxFit.cover,
    ),);
  }
}
