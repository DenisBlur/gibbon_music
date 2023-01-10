import 'package:darq/darq.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/DesignWidget/GListView/GInfinityListView.dart';
import 'package:gibbon_music/DesignWidget/ListItems/TrackItem.dart';
import 'package:gibbon_music/NewAPI/models/CombineModel/M_CombineChartTrack.dart';
import 'package:gibbon_music/NewAPI/models/M_Track.dart';

import '../../../main.dart';

class ChartSection extends StatelessWidget {
  const ChartSection({Key key, @required this.chartTrackList}) : super(key: key);

  final List<MCombineChartTrack> chartTrackList;

  @override
  Widget build(BuildContext context) {
    List<MTrack> trackList = chartTrackList.select((e, _) => e.track).toList();

    return Row(
      children: [
        Expanded(
          child: SizedBox(
              height: 64.0 * 5.0,
              child: GListView(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TrackItem(
                      callback: () {
                        generalNotifyModel.mPlaylist = trackList;
                        generalNotifyModel.playTrack(index);
                      },
                      // key: ,
                      track: chartTrackList[index].track,
                      chart: chartTrackList[index].chart,
                    ),
                  );
                },
                itemCount: 5,
              )),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: SizedBox(
              height: 64.0 * 5.0,
              child: GListView(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TrackItem(
                      callback: () {
                        generalNotifyModel.mPlaylist = trackList;
                        generalNotifyModel.playTrack(index + 5);
                      },
                      // key: ,
                      track: chartTrackList[index + 5].track,
                      chart: chartTrackList[index + 5].chart,
                    ),
                  );
                },
                itemCount: 5,
              )),
        ),
      ],
    );
  }
}
