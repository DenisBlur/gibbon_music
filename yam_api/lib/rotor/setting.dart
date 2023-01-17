class Settings2 {
  Settings2({
    this.language,
    this.moodEnergy,
    this.diversity,});

  Settings2.fromJson(dynamic json) {
    language = json['language'];
    moodEnergy = json['moodEnergy'];
    diversity = json['diversity'];
  }
  String? language;
  String? moodEnergy;
  String? diversity;
  Settings2 copyWith({  String? language,
    String? moodEnergy,
    String? diversity,
  }) => Settings2(  language: language ?? this.language,
    moodEnergy: moodEnergy ?? this.moodEnergy,
    diversity: diversity ?? this.diversity,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['language'] = language;
    map['moodEnergy'] = moodEnergy;
    map['diversity'] = diversity;
    return map;
  }

}

class Settings {
  Settings({
    this.language,
    this.mood,
    this.energy,
    this.diversity,});

  Settings.fromJson(dynamic json) {
    language = json['language'];
    mood = json['mood'];
    energy = json['energy'];
    diversity = json['diversity'];
  }
  String? language;
  num? mood;
  num? energy;
  String? diversity;
  Settings copyWith({  String? language,
    num? mood,
    num? energy,
    String? diversity,
  }) => Settings(  language: language ?? this.language,
    mood: mood ?? this.mood,
    energy: energy ?? this.energy,
    diversity: diversity ?? this.diversity,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['language'] = language;
    map['mood'] = mood;
    map['energy'] = energy;
    map['diversity'] = diversity;
    return map;
  }

}