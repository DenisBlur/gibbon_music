import 'track.dart';

class TrackSimilar {
  TrackSimilar({
    this.track,
    this.similarTracks,
  });

  TrackSimilar.fromJson(dynamic json) {
    track = json['track'] != null ? Track.fromJson(json['track']) : null;
    if (json['similarTracks'] != null) {
      similarTracks = [];
      json['similarTracks'].forEach((v) {
        similarTracks?.add(Track.fromJson(v));
      });
    }
  }

  Track? track;
  List<Track>? similarTracks;

  TrackSimilar copyWith({
    Track? track,
    List<Track>? similarTracks,
  }) =>
      TrackSimilar(
        track: track ?? this.track,
        similarTracks: similarTracks ?? this.similarTracks,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (track != null) {
      map['track'] = track?.toJson();
    }
    if (similarTracks != null) {
      map['similarTracks'] = similarTracks?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
