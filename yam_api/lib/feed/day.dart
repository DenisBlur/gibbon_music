import 'package:yam_api/feed/track_with_ads.dart';
import 'package:yam_api/track/track.dart';

import 'event.dart';

class Day {
  Day({
    this.day,
    this.events,
    this.tracksToPlay,
    this.tracksToPlayWithAds,});

  Day.fromJson(dynamic json) {
    day = json['day'];
    if (json['events'] != null) {
      events = [];
      json['events'].forEach((v) {
        events?.add(Events.fromJson(v));
      });
    }
    if (json['tracksToPlay'] != null) {
      tracksToPlay = [];
      json['tracksToPlay'].forEach((v) {
        tracksToPlay?.add(Track.fromJson(v));
      });
    }
    if (json['tracksToPlayWithAds'] != null) {
      tracksToPlayWithAds = [];
      json['tracksToPlayWithAds'].forEach((v) {
        tracksToPlayWithAds?.add(TrackWithAds.fromJson(v));
      });
    }
  }
  String? day;
  List<Events>? events;
  List<Track>? tracksToPlay;
  List<TrackWithAds>? tracksToPlayWithAds;
  Day copyWith({  String? day,
    List<Events>? events,
    List<Track>? tracksToPlay,
    List<TrackWithAds>? tracksToPlayWithAds,
  }) => Day(  day: day ?? this.day,
    events: events ?? this.events,
    tracksToPlay: tracksToPlay ?? this.tracksToPlay,
    tracksToPlayWithAds: tracksToPlayWithAds ?? this.tracksToPlayWithAds,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    if (events != null) {
      map['events'] = events?.map((v) => v.toJson()).toList();
    }
    if (tracksToPlay != null) {
      map['tracksToPlay'] = tracksToPlay?.map((v) => v.toJson()).toList();
    }
    if (tracksToPlayWithAds != null) {
      map['tracksToPlayWithAds'] = tracksToPlayWithAds?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}