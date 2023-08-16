class TrackLyric {
  TrackLyric({
      this.error,
      this.lines,
      this.syncType,});

  TrackLyric.fromJson(dynamic json) {
    error = json['error'];
    if (json['lines'] != null) {
      lines = [];
      json['lines'].forEach((v) {
        lines?.add(Lines.fromJson(v));
      });
    }
    syncType = json['syncType'];
  }
  bool? error;
  List<Lines>? lines;
  String? syncType;
TrackLyric copyWith({  bool? error,
  List<Lines>? lines,
  String? syncType,
}) => TrackLyric(  error: error ?? this.error,
  lines: lines ?? this.lines,
  syncType: syncType ?? this.syncType,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    if (lines != null) {
      map['lines'] = lines?.map((v) => v.toJson()).toList();
    }
    map['syncType'] = syncType;
    return map;
  }

}

class Lines {
  Lines({
      this.endTimeMs,
      this.startTimeMs,
      this.words,});

  Lines.fromJson(dynamic json) {
    endTimeMs = json['endTimeMs'];
    startTimeMs = json['startTimeMs'];
    words = json['words'];
  }
  String? endTimeMs;
  String? startTimeMs;
  String? words;
Lines copyWith({  String? endTimeMs,
  String? startTimeMs,
  String? words,
}) => Lines(  endTimeMs: endTimeMs ?? this.endTimeMs,
  startTimeMs: startTimeMs ?? this.startTimeMs,
  words: words ?? this.words,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['endTimeMs'] = endTimeMs;
    map['startTimeMs'] = startTimeMs;
    map['words'] = words;
    return map;
  }

}