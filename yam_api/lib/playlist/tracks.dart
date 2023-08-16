import '../track/track.dart';

/// id : 109140203
/// track : {"id":"109140203","realId":"109140203","title":"ЗА ДЕНЬГИ ДА","trackSource":"OWN","major":{"id":87,"name":"BELIEVE_DIGITAL"},"available":true,"availableForPremiumUsers":true,"availableFullWithoutPermission":false,"availableForOptions":["bookmate"],"durationMs":119470,"storageDir":"","fileSize":0,"r128":{"i":-7.22,"tp":1.19},"previewDurationMs":30000,"artists":[{"id":7461723,"name":"INSTASAMKA","various":false,"composer":false,"cover":{"type":"from-artist-photos","prefix":"03ed6f53.p.7461723/","uri":"avatars.yandex.net/get-music-content/8316823/03ed6f53.p.7461723/%%"},"genres":[]}],"albums":[{"id":24375438,"title":"POPSTAR","metaType":"music","version":"Deluxe Version","year":2022,"releaseDate":"2022-12-16T00:00:00+03:00","coverUri":"avatars.yandex.net/get-music-content/5502420/686d2bf8.a.24375438-1/%%","ogImage":"avatars.yandex.net/get-music-content/5502420/686d2bf8.a.24375438-1/%%","genre":"ruspop","trackCount":23,"likesCount":19248,"recent":false,"veryImportant":true,"artists":[{"id":7461723,"name":"INSTASAMKA","various":false,"composer":false,"cover":{"type":"from-artist-photos","prefix":"03ed6f53.p.7461723/","uri":"avatars.yandex.net/get-music-content/8316823/03ed6f53.p.7461723/%%"},"genres":[]}],"labels":[{"id":1688767,"name":"NaMneCash"}],"available":true,"availableForPremiumUsers":true,"availableForOptions":["bookmate"],"availableForMobile":true,"availablePartially":false,"bests":[107281308,109989526,109140203],"trackPosition":{"volume":1,"index":9}}],"coverUri":"avatars.yandex.net/get-music-content/5502420/686d2bf8.a.24375438-1/%%","ogImage":"avatars.yandex.net/get-music-content/5502420/686d2bf8.a.24375438-1/%%","lyricsAvailable":false,"lyricsInfo":{"hasAvailableSyncLyrics":true,"hasAvailableTextLyrics":true},"type":"music","rememberPosition":false,"trackSharingFlag":"COVER_ONLY"}
/// timestamp : "2022-12-20T09:59:22+00:00"
/// playCount : 0
/// chart : {"position":1,"progress":"same","listeners":0,"shift":0,"bgColor":"#FFFFFF"}
/// recent : false

class Tracks {
  Tracks({
      this.id, 
      this.track, 
      this.timestamp, 
      this.playCount, 
      this.chart, 
      this.recent,});

  Tracks.fromJson(dynamic json) {
    id = json['id'].toString();
    track = json['track'] != null ? Track.fromJson(json['track']) : null;
    timestamp = json['timestamp'];
    playCount = json['playCount'];
    chart = json['chart'] != null ? Chart.fromJson(json['chart']) : null;
    recent = json['recent'];
  }
  String? id;
  Track? track;
  String? timestamp;
  num? playCount;
  Chart? chart;
  bool? recent;
Tracks copyWith({  String? id,
  Track? track,
  String? timestamp,
  num? playCount,
  Chart? chart,
  bool? recent,
}) => Tracks(  id: id ?? this.id,
  track: track ?? this.track,
  timestamp: timestamp ?? this.timestamp,
  playCount: playCount ?? this.playCount,
  chart: chart ?? this.chart,
  recent: recent ?? this.recent,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (track != null) {
      map['track'] = track?.toJson();
    }
    map['timestamp'] = timestamp;
    map['playCount'] = playCount;
    if (chart != null) {
      map['chart'] = chart?.toJson();
    }
    map['recent'] = recent;
    return map;
  }

}

/// position : 1
/// progress : "same"
/// listeners : 0
/// shift : 0
/// bgColor : "#FFFFFF"

class Chart {
  Chart({
      this.position, 
      this.progress, 
      this.listeners, 
      this.shift, 
      this.bgColor,});

  Chart.fromJson(dynamic json) {
    position = json['position'];
    progress = json['progress'];
    listeners = json['listeners'];
    shift = json['shift'];
    bgColor = json['bgColor'];
  }
  num? position;
  String? progress;
  num? listeners;
  num? shift;
  String? bgColor;
Chart copyWith({  num? position,
  String? progress,
  num? listeners,
  num? shift,
  String? bgColor,
}) => Chart(  position: position ?? this.position,
  progress: progress ?? this.progress,
  listeners: listeners ?? this.listeners,
  shift: shift ?? this.shift,
  bgColor: bgColor ?? this.bgColor,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['position'] = position;
    map['progress'] = progress;
    map['listeners'] = listeners;
    map['shift'] = shift;
    map['bgColor'] = bgColor;
    return map;
  }

}