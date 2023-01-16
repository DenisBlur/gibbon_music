class Supplement {
  Supplement({
      this.id, 
      this.lyrics,});

  Supplement.fromJson(dynamic json) {
    id = json['id'];
    lyrics = json['lyrics'] != null ? Lyrics.fromJson(json['lyrics']) : null;
  }
  String? id;
  Lyrics? lyrics;
Supplement copyWith({  String? id,
  Lyrics? lyrics,
}) => Supplement(  id: id ?? this.id,
  lyrics: lyrics ?? this.lyrics,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (lyrics != null) {
      map['lyrics'] = lyrics?.toJson();
    }
    return map;
  }

}

class Lyrics {
  Lyrics({
      this.id, 
      this.lyrics, 
      this.fullLyrics, 
      this.hasRights, 
      this.textLanguage, 
      this.showTranslation,});

  Lyrics.fromJson(dynamic json) {
    id = json['id'];
    lyrics = json['lyrics'];
    fullLyrics = json['fullLyrics'];
    hasRights = json['hasRights'];
    textLanguage = json['textLanguage'];
    showTranslation = json['showTranslation'];
  }
  num? id;
  String? lyrics;
  String? fullLyrics;
  bool? hasRights;
  String? textLanguage;
  bool? showTranslation;
Lyrics copyWith({  num? id,
  String? lyrics,
  String? fullLyrics,
  bool? hasRights,
  String? textLanguage,
  bool? showTranslation,
}) => Lyrics(  id: id ?? this.id,
  lyrics: lyrics ?? this.lyrics,
  fullLyrics: fullLyrics ?? this.fullLyrics,
  hasRights: hasRights ?? this.hasRights,
  textLanguage: textLanguage ?? this.textLanguage,
  showTranslation: showTranslation ?? this.showTranslation,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['lyrics'] = lyrics;
    map['fullLyrics'] = fullLyrics;
    map['hasRights'] = hasRights;
    map['textLanguage'] = textLanguage;
    map['showTranslation'] = showTranslation;
    return map;
  }

}