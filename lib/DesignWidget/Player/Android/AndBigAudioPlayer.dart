import 'package:audioplayers/audioplayers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/API/MainMethod/GMethod.dart';
import 'package:gibbon_music/API/Models/NewHomePage/MV_Track.dart';
import 'package:gibbon_music/API/Models/NotifyModels/GeneralNotifyModel.dart';
import 'package:gibbon_music/DesignWidget/ListItems/TrackItem.dart';
import 'package:gibbon_music/main.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class BigAudioWidget extends StatefulWidget {
  const BigAudioWidget({Key key}) : super(key: key);

  @override
  State<BigAudioWidget> createState() => _BigAudioWidgetState();
}

class _BigAudioWidgetState extends State<BigAudioWidget> {

  IconData mainIcon = m.Icons.cabin;
  int position = 0;
  int duration = 0;

  @override
  void initState() {
    super.initState();

    player.player.onPositionChanged.listen((event) {
      setState(() {
        position = event.inMilliseconds;
      });
    });

    player.player.onDurationChanged.listen((event) {
      setState(() {
        duration = event.inMilliseconds;
      });
    });

    player.player.onPlayerStateChanged.listen((event) {
      setState(() {
        switch (event) {
          case PlayerState.paused:
            mainIcon = m.Icons.play_arrow_rounded;
            break;
          case PlayerState.playing:
            mainIcon = m.Icons.pause;
            break;
          case PlayerState.completed:
            mainIcon = m.Icons.play_arrow_rounded;
            break;
          case PlayerState.stopped:
            mainIcon = m.Icons.stop;
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String image =
        "https://avatars.yandex.net/get-music-content/5502420/7e294c2d.a.18837614-4/200x200";
    String title = "";
    List<Artists> artist = [];

    if (context.watch<GeneralNotifyModel>().mTrack != null) {
      Track track = context.watch<GeneralNotifyModel>().mTrack.track;
      image = linkImage(track.coverUri, 400, 400);
      title = track.title;
      artist = track.artists;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FadeInImage.memoryNetwork(
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              placeholder: kTransparentImage,
              image: image,
            ),
          ),
        ),
        Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
        ArtistsWidget(listArtists: artist),
        Container(
          margin: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Text(timeTrack(position)),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Slider(
                    label: timeTrack(position),
                    value: position.toDouble(),
                    max: duration.toDouble(),
                    min: 0,
                    onChanged: (value) {
                      player.setSeek(value.toInt());
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(timeTrack(duration)),
              ],
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(m.Icons.skip_previous_rounded, size: 36),
              onPressed: () {},
            ),
            const SizedBox(width: 32,),
            IconButton(
              icon: Icon(mainIcon, size: 56),
              onPressed: () {
                if (player.getState() == PlayerState.paused) {
                  player.playAudio();
                } else {
                  player.pauseAudio();
                }
              },
            ),
            const SizedBox(width: 32,),
            IconButton(
              icon: const Icon(m.Icons.skip_next_rounded, size: 36),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
