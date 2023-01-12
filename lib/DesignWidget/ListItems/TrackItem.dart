import 'package:fluent_ui/fluent_ui.dart';

// ignore: library_prefixes
import 'package:flutter/material.dart' as m;
import 'package:gibbon_music/API/MainMethod/GMethod.dart';
import 'package:gibbon_music/DesignWidget/ContextMenu.dart';
import 'package:gibbon_music/DesignWidget/GButtons.dart';
import 'package:gibbon_music/NewAPI/models/InnerModel/M_InnerArtist.dart';
import 'package:gibbon_music/NewAPI/models/M_ChartPosition.dart';
import 'package:gibbon_music/NewAPI/models/M_Track.dart';
import 'package:transparent_image/transparent_image.dart';

import '../Styles/ConstValue.dart';

class TrackItem extends StatelessWidget {
  const TrackItem({Key key, @required this.track, this.chart, this.imageSize = 56, this.callback}) : super(key: key);
  final MChartPosition chart;
  final MTrack track;
  final double imageSize;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return HoverButton(
      onPressed: callback,
      builder: (p0, state) {
        return AnimatedContainer(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: FluentTheme.of(context).cardColor.withOpacity(state.isHovering || state.isPressing ? .5 : 0)),
          duration: fastAnimation,
          child: Row(
            children: [
              chart != null ? ChartInfoWidget(chart: chart) : const SizedBox(),
              SizedBox(
                width: imageSize,
                height: imageSize,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage, image: track.coverUri != null ? linkImage(track.coverUri, 100) : imagePlaceholder),
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
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  ArtistsWidget(listArtists: track.artists)
                ],
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Text(track.durationMs != null ? timeTrack(track.durationMs) : ""),
            ],
          ),
        );
      },
    );
  }
}

class ArtistsWidget extends StatelessWidget {
  const ArtistsWidget({Key key, @required this.listArtists, this.shortText = true}) : super(key: key);

  final List<MInnerArtist> listArtists;
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
        title = ", ${element.name}";
      }

      artists.add(GTextButton(
        text: title,
        onPress: () {
          goToArtist(context, element.id);
        },
      ));
    }

    return Row(
      children: artists,
    );
  }
}

class ChartInfoWidget extends StatelessWidget {
  const ChartInfoWidget({Key key, @required this.chart}) : super(key: key);

  final MChartPosition chart;

  @override
  Widget build(BuildContext context) {
    Color iconColor = FluentTheme.of(context).uncheckedColor;
    IconData data = m.Icons.arrow_drop_down_rounded;
    String progress = chart.progress;
    switch (progress) {
      case "same":
        data = m.Icons.remove;
        break;
      case "up":
        data = m.Icons.arrow_drop_up_rounded;
        iconColor = Colors.green;
        break;
      default:
        data = m.Icons.arrow_drop_down_rounded;
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
