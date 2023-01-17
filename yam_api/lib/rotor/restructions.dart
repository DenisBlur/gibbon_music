import 'enums.dart';

class Restrictions2 {
  Restrictions2({
    this.diversity,
    this.moodEnergy,
    this.language,});

  Restrictions2.fromJson(dynamic json) {
    diversity = json['diversity'] != null ? Diversity.fromJson(json['diversity']) : null;
    moodEnergy = json['moodEnergy'] != null ? MoodEnergy.fromJson(json['moodEnergy']) : null;
    language = json['language'] != null ? Language.fromJson(json['language']) : null;
  }
  Diversity? diversity;
  MoodEnergy? moodEnergy;
  Language? language;
  Restrictions2 copyWith({  Diversity? diversity,
    MoodEnergy? moodEnergy,
    Language? language,
  }) => Restrictions2(  diversity: diversity ?? this.diversity,
    moodEnergy: moodEnergy ?? this.moodEnergy,
    language: language ?? this.language,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (diversity != null) {
      map['diversity'] = diversity?.toJson();
    }
    if (moodEnergy != null) {
      map['moodEnergy'] = moodEnergy?.toJson();
    }
    if (language != null) {
      map['language'] = language?.toJson();
    }
    return map;
  }

}

class Restrictions {
  Restrictions({
    this.language,
    this.mood,
    this.energy,
    this.diversity,});

  Restrictions.fromJson(dynamic json) {
    language = json['language'] != null ? Language.fromJson(json['language']) : null;
    mood = json['mood'] != null ? Mood.fromJson(json['mood']) : null;
    energy = json['energy'] != null ? Energy.fromJson(json['energy']) : null;
    diversity = json['diversity'] != null ? Diversity.fromJson(json['diversity']) : null;
  }
  Language? language;
  Mood? mood;
  Energy? energy;
  Diversity? diversity;
  Restrictions copyWith({  Language? language,
    Mood? mood,
    Energy? energy,
    Diversity? diversity,
  }) => Restrictions(  language: language ?? this.language,
    mood: mood ?? this.mood,
    energy: energy ?? this.energy,
    diversity: diversity ?? this.diversity,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (language != null) {
      map['language'] = language?.toJson();
    }
    if (mood != null) {
      map['mood'] = mood?.toJson();
    }
    if (energy != null) {
      map['energy'] = energy?.toJson();
    }
    if (diversity != null) {
      map['diversity'] = diversity?.toJson();
    }
    return map;
  }

}