import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/API/Models/ArtistPage/MV_ArtistPage.dart';
import 'package:gibbon_music/DesignWidget/GListView/GInfinityListView.dart';
import 'package:gibbon_music/DesignWidget/ListItems/TrackItem.dart';
import 'package:darq/darq.dart';
import 'package:gibbon_music/DesignWidget/Styles/ConstValue.dart';
import '../../../API/Models/NewHomePage/MV_Track.dart';
import '../../../main.dart';

class ChartSection extends StatelessWidget {
  const ChartSection({Key key, @required this.chartTrackList})
      : super(key: key);

  final List<MvTrack> chartTrackList;

  @override
  Widget build(BuildContext context) {
    List<Track> trackList = chartTrackList.select((e, _) => e.track).toList();

    return Container(
        height: 2000,
        margin: sectionInsets,
        width: MediaQuery.of(context).size.width,
        child: GListView(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return TrackItem(
              callback: () {
                generalNotifyModel.mPlaylist = trackList;
                generalNotifyModel.playTrack(index);
              },
              // key: ,
              track: chartTrackList[index].track,
              chart: chartTrackList[index].chart,
            );
          },
          itemCount: chartTrackList.length,
        ));
  }
}
