import 'package:gibbon_music/API/Models/ArtistPage/MV_ArtistPage.dart';

class MvTrack {
  MvTrack({
      this.track, 
      this.chart,});

  MvTrack.fromJson(dynamic json) {
    track = json['track'] != null ? Track.fromJson(json['track']) : null;
    chart = json['chart'] != null ? Chart.fromJson(json['chart']) : null;
  }
  Track track;
  Chart chart;

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

class Chart {
  Chart({
      this.position, 
      this.progress, 
      this.listeners, 
      this.shift,});

  Chart.fromJson(dynamic json) {
    position = json['position'];
    progress = json['progress'];
    listeners = json['listeners'];
    shift = json['shift'];
  }
  num position;
  String progress;
  num listeners;
  num shift;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['position'] = position;
    map['progress'] = progress;
    map['listeners'] = listeners;
    map['shift'] = shift;
    return map;
  }

}

class TrackPosition {
  TrackPosition({
      this.volume, 
      this.index,});

  TrackPosition.fromJson(dynamic json) {
    volume = json['volume'];
    index = json['index'];
  }
  num volume;
  num index;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['volume'] = volume;
    map['index'] = index;
    return map;
  }

}