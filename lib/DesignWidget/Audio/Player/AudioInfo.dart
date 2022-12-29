import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/DesignWidget/GTextStyles.dart';
import 'package:transparent_image/transparent_image.dart';

class AudioInfo extends StatefulWidget {
  const AudioInfo({Key key}) : super(key: key);

  @override
  State<AudioInfo> createState() => _AudioInfoState();
}

class _AudioInfoState extends State<AudioInfo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FadeInImage.memoryNetwork(
              fit: BoxFit.cover,
              height: 64,
              width: 64,
              placeholder: kTransparentImage,
              image:
                  "https://avatars.yandex.net/get-music-content/41288/c8ad5f3f.a.60058-2/200x200"),
        ),
        SizedBox(width: 16,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Lipsi Ha", style: titleTextStyle,),
            Text("INSTASAMKA", style: subTitleTextStyle,),
          ],
        )
      ],
    );
  }
}
