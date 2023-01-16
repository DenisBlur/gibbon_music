class LyricsInfo {
  LyricsInfo({
    this.hasAvailableSyncLyrics,
    this.hasAvailableTextLyrics,});

  LyricsInfo.fromJson(dynamic json) {
    hasAvailableSyncLyrics = json['hasAvailableSyncLyrics'];
    hasAvailableTextLyrics = json['hasAvailableTextLyrics'];
  }
  bool? hasAvailableSyncLyrics;
  bool? hasAvailableTextLyrics;
  LyricsInfo copyWith({  bool? hasAvailableSyncLyrics,
    bool? hasAvailableTextLyrics,
  }) => LyricsInfo(  hasAvailableSyncLyrics: hasAvailableSyncLyrics ?? this.hasAvailableSyncLyrics,
    hasAvailableTextLyrics: hasAvailableTextLyrics ?? this.hasAvailableTextLyrics,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hasAvailableSyncLyrics'] = hasAvailableSyncLyrics;
    map['hasAvailableTextLyrics'] = hasAvailableTextLyrics;
    return map;
  }

}