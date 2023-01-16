import '../track/track.dart';

class TrackWithAds {
  TrackWithAds({
    this.type,
    this.track,});

  TrackWithAds.fromJson(dynamic json) {
    type = json['type'];
    track = json['track'] != null ? Track.fromJson(json['track']) : null;
  }
  String? type;
  Track? track;
  TrackWithAds copyWith({  String? type,
    Track? track,
  }) => TrackWithAds(  type: type ?? this.type,
    track: track ?? this.track,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    if (track != null) {
      map['track'] = track?.toJson();
    }
    return map;
  }

}