class Language {
  Language({
    this.type,
    this.name,
    this.possibleValues,});

  Language.fromJson(dynamic json) {
    type = json['type'];
    name = json['name'];
    if (json['possibleValues'] != null) {
      possibleValues = [];
      json['possibleValues'].forEach((v) {
        possibleValues?.add(PossibleValues.fromJson(v));
      });
    }
  }
  String? type;
  String? name;
  List<PossibleValues>? possibleValues;
  Language copyWith({  String? type,
    String? name,
    List<PossibleValues>? possibleValues,
  }) => Language(  type: type ?? this.type,
    name: name ?? this.name,
    possibleValues: possibleValues ?? this.possibleValues,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['name'] = name;
    if (possibleValues != null) {
      map['possibleValues'] = possibleValues?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Diversity {
  Diversity({
    this.type,
    this.name,
    this.possibleValues,});

  Diversity.fromJson(dynamic json) {
    type = json['type'];
    name = json['name'];
    if (json['possibleValues'] != null) {
      possibleValues = [];
      json['possibleValues'].forEach((v) {
        possibleValues?.add(PossibleValues.fromJson(v));
      });
    }
  }
  String? type;
  String? name;
  List<PossibleValues>? possibleValues;
  Diversity copyWith({  String? type,
    String? name,
    List<PossibleValues>? possibleValues,
  }) => Diversity(  type: type ?? this.type,
    name: name ?? this.name,
    possibleValues: possibleValues ?? this.possibleValues,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['name'] = name;
    if (possibleValues != null) {
      map['possibleValues'] = possibleValues?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class MoodEnergy {
  MoodEnergy({
    this.type,
    this.name,
    this.possibleValues,});

  MoodEnergy.fromJson(dynamic json) {
    type = json['type'];
    name = json['name'];
    if (json['possibleValues'] != null) {
      possibleValues = [];
      json['possibleValues'].forEach((v) {
        possibleValues?.add(PossibleValues.fromJson(v));
      });
    }
  }
  String? type;
  String? name;
  List<PossibleValues>? possibleValues;
  MoodEnergy copyWith({  String? type,
    String? name,
    List<PossibleValues>? possibleValues,
  }) => MoodEnergy(  type: type ?? this.type,
    name: name ?? this.name,
    possibleValues: possibleValues ?? this.possibleValues,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['name'] = name;
    if (possibleValues != null) {
      map['possibleValues'] = possibleValues?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class PossibleValues {
  PossibleValues({
    this.value,
    this.name,
    this.serializedSeed,});

  PossibleValues.fromJson(dynamic json) {
    value = json['value'];
    name = json['name'];
    serializedSeed = json['serializedSeed'];
  }
  String? value;
  String? name;
  String? serializedSeed;
  PossibleValues copyWith({  String? value,
    String? name,
    String? serializedSeed,
  }) => PossibleValues(  value: value ?? this.value,
    name: name ?? this.name,
    serializedSeed: serializedSeed ?? this.serializedSeed,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['name'] = name;
    map['serializedSeed'] = serializedSeed;
    return map;
  }

}

class Energy {
  Energy({
    this.type,
    this.name,
    this.min,
    this.max,});

  Energy.fromJson(dynamic json) {
    type = json['type'];
    name = json['name'];
    min = json['min'] != null ? Min.fromJson(json['min']) : null;
    max = json['max'] != null ? Max.fromJson(json['max']) : null;
  }
  String? type;
  String? name;
  Min? min;
  Max? max;
  Energy copyWith({  String? type,
    String? name,
    Min? min,
    Max? max,
  }) => Energy(  type: type ?? this.type,
    name: name ?? this.name,
    min: min ?? this.min,
    max: max ?? this.max,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['name'] = name;
    if (min != null) {
      map['min'] = min?.toJson();
    }
    if (max != null) {
      map['max'] = max?.toJson();
    }
    return map;
  }

}

class Max {
  Max({
    this.value,
    this.name,});

  Max.fromJson(dynamic json) {
    value = json['value'];
    name = json['name'];
  }
  num? value;
  String? name;
  Max copyWith({  num? value,
    String? name,
  }) => Max(  value: value ?? this.value,
    name: name ?? this.name,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['name'] = name;
    return map;
  }

}

class Min {
  Min({
    this.value,
    this.name,});

  Min.fromJson(dynamic json) {
    value = json['value'];
    name = json['name'];
  }
  num? value;
  String? name;
  Min copyWith({  num? value,
    String? name,
  }) => Min(  value: value ?? this.value,
    name: name ?? this.name,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['name'] = name;
    return map;
  }

}

class Mood {
  Mood({
    this.type,
    this.name,
    this.min,
    this.max,});

  Mood.fromJson(dynamic json) {
    type = json['type'];
    name = json['name'];
    min = json['min'] != null ? Min.fromJson(json['min']) : null;
    max = json['max'] != null ? Max.fromJson(json['max']) : null;
  }
  String? type;
  String? name;
  Min? min;
  Max? max;
  Mood copyWith({  String? type,
    String? name,
    Min? min,
    Max? max,
  }) => Mood(  type: type ?? this.type,
    name: name ?? this.name,
    min: min ?? this.min,
    max: max ?? this.max,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['name'] = name;
    if (min != null) {
      map['min'] = min?.toJson();
    }
    if (max != null) {
      map['max'] = max?.toJson();
    }
    return map;
  }

}
