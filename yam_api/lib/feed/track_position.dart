class TrackPosition {
  TrackPosition({
    this.volume,
    this.index,});

  TrackPosition.fromJson(dynamic json) {
    volume = json['volume'];
    index = json['index'];
  }
  num? volume;
  num? index;
  TrackPosition copyWith({  num? volume,
    num? index,
  }) => TrackPosition(  volume: volume ?? this.volume,
    index: index ?? this.index,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['volume'] = volume;
    map['index'] = index;
    return map;
  }

}