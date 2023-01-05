import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/DesignWidget/ListItems/TrackItem.dart';

import '../../../API/Models/NewHomePage/MV_Track.dart';

class ChartSection extends StatelessWidget {
  const ChartSection({Key key, @required this.chartTrackList})
      : super(key: key);

  final List<MvTrack> chartTrackList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Platform.isAndroid ? 16 : 0, right: Platform.isAndroid ? 16 : 0 ),
      width: MediaQuery.of(context).size.width,
      height: (chartTrackList.length * (Platform.isAndroid ? 86 : 32)).toDouble(),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: Platform.isAndroid ? 1 : 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: Platform.isAndroid ? 6 : 10,
        children: List.generate(
          chartTrackList.length,
          (index) => FadeInRight(
            duration: const Duration(milliseconds: 250),
            delay: Duration(milliseconds: 50 * index),
            child: TrackItem(track: chartTrackList[index], isChart: true),
          ),
        ),
      ),
    );
  }
}
