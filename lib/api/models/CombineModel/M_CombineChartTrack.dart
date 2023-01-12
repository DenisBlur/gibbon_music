import 'package:gibbon_music/api/models/M_ChartPosition.dart';

import '../M_Track.dart';

class MCombineChartTrack {
  MCombineChartTrack({
    this.track,
    this.chart,
  });

  MCombineChartTrack.fromJson(dynamic json) {
    track = json['track'] != null ? MTrack.fromJson(json['track']) : null;
    chart = json['chart'] != null ? MChartPosition.fromJson(json['chart']) : null;
  }

  MTrack track;
  MChartPosition chart;

  MCombineChartTrack copyWith({
    MTrack track,
    MChartPosition chart,
  }) =>
      MCombineChartTrack(
        track: track ?? this.track,
        chart: chart ?? this.chart,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (track != null) {
      map['track'] = track.toJson();
    }
    if (chart != null) {
      map['chart'] = chart.toJson();
    }
    return map;
  }
}
