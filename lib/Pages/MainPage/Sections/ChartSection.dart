import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/DesignWidget/Audio/ListItems/TrackItem.dart';

import '../../../API/Models/NewHomePage/MV_Track.dart';

class ChartSection extends StatelessWidget {
  const ChartSection({Key key, @required this.chartTrackList})
      : super(key: key);

  final List<MvTrack> chartTrackList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: (chartTrackList.length * 64).toDouble(),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 10,
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
