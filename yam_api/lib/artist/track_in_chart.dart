class TracksInChart {
  TracksInChart({
    this.trackId,
    this.position,
    this.progress,
    this.listeners,
    this.shift,});

  TracksInChart.fromJson(dynamic json) {
    trackId = json['trackId'] != null ? TrackId.fromJson(json['trackId']) : null;
    position = json['position'];
    progress = json['progress'];
    listeners = json['listeners'];
    shift = json['shift'];
  }
  TrackId? trackId;
  num? position;
  String? progress;
  num? listeners;
  num? shift;
  TracksInChart copyWith({  TrackId? trackId,
    num? position,
    String? progress,
    num? listeners,
    num? shift,
  }) => TracksInChart(  trackId: trackId ?? this.trackId,
    position: position ?? this.position,
    progress: progress ?? this.progress,
    listeners: listeners ?? this.listeners,
    shift: shift ?? this.shift,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (trackId != null) {
      map['trackId'] = trackId?.toJson();
    }
    map['position'] = position;
    map['progress'] = progress;
    map['listeners'] = listeners;
    map['shift'] = shift;
    return map;
  }

}

class TrackId {
  TrackId({
    this.id,});

  TrackId.fromJson(dynamic json) {
    id = json['id'];
  }
  String? id;
  TrackId copyWith({  String? id,
  }) => TrackId(  id: id ?? this.id,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    return map;
  }

}