import 'package:fluent_ui/fluent_ui.dart';
// ignore: library_prefixes
import 'package:flutter/material.dart' as mIcon;
import 'package:gibbon_music/API/MainMethod/GMethod.dart';
import 'package:gibbon_music/API/Models/ArtistPage/MV_ArtistPage.dart';
import 'package:gibbon_music/API/Models/NewHomePage/MV_Track.dart';
import 'package:gibbon_music/DesignWidget/ContextMenu.dart';
import 'package:gibbon_music/DesignWidget/GButtons.dart';
import 'package:gibbon_music/main.dart';
import 'package:transparent_image/transparent_image.dart';
// ignore: depend_on_referenced_packages
import 'package:yam_api/yam_api.dart';

class TrackItem extends StatelessWidget {
  const TrackItem({Key key, @required this.track, this.chart, this.imageSize = 56})
      : super(key: key);

  final Chart chart;
  final Track track;
  final double imageSize;

  void playTrack() async {
    String urlTrack = await YamApi.downloadTrack(track.id);
    generalNotifyModel.mTrack = track;
    player.setAudio(urlTrack);
  }

  @override
  Widget build(BuildContext context) {
    return HoverButton(
      onPressed: () {
        playTrack();
      },
      builder: (p0, state) {
        return AnimatedContainer(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: FluentTheme.of(context)
                  .cardColor
                  .withOpacity(state.isHovering || state.isPressing ? .5 : 0)),
          duration: const Duration(milliseconds: 150),
          child: Row(
            children: [
              chart != null ? ChartInfoWidget(chart: chart) : const SizedBox(),
              SizedBox(
                width: imageSize,
                height: imageSize,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: linkImage(track.coverUri, 100)),
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
                    track.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  ArtistsWidget(listArtists: track.artists)
                ],
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Text(timeTrack(track.durationMs)),
            ],
          ),
        );
      },
    );
  }
}

class ArtistsWidget extends StatelessWidget {
  const ArtistsWidget(
      {Key key, @required this.listArtists, this.shortText = true})
      : super(key: key);

  final List<Artists> listArtists;
  final bool shortText;

  @override
  Widget build(BuildContext context) {
    String title = "";
    List<Widget> artists = [];

    for (int i = 0; i < listArtists.length; i++) {
      var element = listArtists[i];
      if (i == 0) {
        title = element.name;
      } else {
        title = "$title, ${element.name}";
      }

      artists.add(GTextButton(
        text: element.name,
        onPress: () {
          Navigator.pop(context);
          goToArtist(context, element.id);
        },
      ));
    }

    if (shortText) {
      title = "${listArtists.first.name} и еще ${artists.length - 1}";
    }

    return artists.length > 1
        ? ContextMenuArea(
            verticalPadding: 0,
            child: GTextButton(
              text: title,
              onPress: () {

              },
            ),
            builder: (context) => artists,
          )
        : GTextButton(
            text: listArtists.first.name,
            onPress: () {
              goToArtist(context, listArtists.first.id);
            },
          );
  }
}

class ChartInfoWidget extends StatelessWidget {
  const ChartInfoWidget({Key key, @required this.chart}) : super(key: key);

  final Chart chart;

  @override
  Widget build(BuildContext context) {
    Color iconColor = FluentTheme.of(context).uncheckedColor;
    IconData data = mIcon.Icons.arrow_drop_down_rounded;
    String progress = chart.progress;
    switch (progress) {
      case "same":
        data = mIcon.Icons.remove;
        break;
      case "up":
        data = mIcon.Icons.arrow_drop_up_rounded;
        iconColor = Colors.green;
        break;
      default:
        data = mIcon.Icons.arrow_drop_down_rounded;
        iconColor = Colors.red;
        break;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(chart.position.toString()),
        Icon(data, color: iconColor),
      ],
    );
  }
}
