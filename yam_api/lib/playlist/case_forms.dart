class CaseForms {
  CaseForms({
    this.nominative,
    this.genitive,
    this.dative,
    this.accusative,
    this.instrumental,
    this.prepositional,});

  CaseForms.fromJson(dynamic json) {
    nominative = json['nominative'];
    genitive = json['genitive'];
    dative = json['dative'];
    accusative = json['accusative'];
    instrumental = json['instrumental'];
    prepositional = json['prepositional'];
  }
  String? nominative;
  String? genitive;
  String? dative;
  String? accusative;
  String? instrumental;
  String? prepositional;
  CaseForms copyWith({  String? nominative,
    String? genitive,
    String? dative,
    String? accusative,
    String? instrumental,
    String? prepositional,
  }) => CaseForms(  nominative: nominative ?? this.nominative,
    genitive: genitive ?? this.genitive,
    dative: dative ?? this.dative,
    accusative: accusative ?? this.accusative,
    instrumental: instrumental ?? this.instrumental,
    prepositional: prepositional ?? this.prepositional,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nominative'] = nominative;
    map['genitive'] = genitive;
    map['dative'] = dative;
    map['accusative'] = accusative;
    map['instrumental'] = instrumental;
    map['prepositional'] = prepositional;
    return map;
  }

}