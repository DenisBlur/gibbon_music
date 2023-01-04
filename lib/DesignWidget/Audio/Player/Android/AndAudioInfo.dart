import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/API/MainMethod/GMethod.dart';
import 'package:gibbon_music/API/Models/NewHomePage/MV_Track.dart';
import 'package:gibbon_music/API/Models/NotifyModels/PlayerNotifyModel.dart';
import 'package:gibbon_music/DesignWidget/Audio/ListItems/TrackItem.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class AudioInfo extends StatelessWidget {
  const AudioInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String image =
        "https://avatars.yandex.net/get-music-content/5502420/7e294c2d.a.18837614-4/200x200";
    String title = "";
    List<Artists> artist = [];

    if (context.watch<PlayerNotifyModel>().mTrack != null) {
      Track track = context.watch<PlayerNotifyModel>().mTrack.track;
      image = linkImage(track.coverUri, 150, 150);
      title = track.title;
      artist = track.artists;
    }

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
            image: image,
          ),
        ),
        const SizedBox(
          width: 16,
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
