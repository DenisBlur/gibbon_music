import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/API/MainMethod/GMethod.dart';
import 'package:gibbon_music/DesignWidget/ListItems/TrackItem.dart';
import 'package:gibbon_music/NewAPI/models/InnerModel/M_InnerArtist.dart';
import 'package:gibbon_music/NewAPI/models/M_Track.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../API/NotifyModels/GeneralNotifyModel.dart';

class AudioInfo extends StatelessWidget {
  const AudioInfo({Key key, this.height = 64, this.width = 64, this.hasImage = true}) : super(key: key);

  final double height;
  final double width;
  final bool hasImage;

  @override
  Widget build(BuildContext context) {
    String image = "https://avatars.yandex.net/get-music-content/5502420/7e294c2d.a.18837614-4/200x200";
    String title = "";
    List<MInnerArtist> artist = [];

    if (context.watch<GeneralNotifyModel>().mTrack != null) {
      MTrack track = context.watch<GeneralNotifyModel>().mTrack;
      image = linkImage(track.coverUri, 150);
      title = track.title;
      artist = track.artists;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        hasImage
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FadeInImage.memoryNetwork(
                  fit: BoxFit.cover,
                  height: width,
                  width: height,
                  placeholder: kTransparentImage,
                  image: image,
                ),
              )
            : const SizedBox(),
        SizedBox(
          width: hasImage ? 16 : 0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            ArtistsWidget(listArtists: artist, shortText: false),
          ],
        )
      ],
    );
  }
}
