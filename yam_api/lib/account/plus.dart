class Plus {
  Plus({
    bool? hasPlus,
    bool? isTutorialCompleted,}){
    _hasPlus = hasPlus;
    _isTutorialCompleted = isTutorialCompleted;
  }

  Plus.fromJson(dynamic json) {
    _hasPlus = json['hasPlus'];
    _isTutorialCompleted = json['isTutorialCompleted'];
  }
  bool? _hasPlus;
  bool? _isTutorialCompleted;
  Plus copyWith({  bool? hasPlus,
    bool? isTutorialCompleted,
  }) => Plus(  hasPlus: hasPlus ?? _hasPlus,
    isTutorialCompleted: isTutorialCompleted ?? _isTutorialCompleted,
  );
  bool? get hasPlus => _hasPlus;
  bool? get isTutorialCompleted => _isTutorialCompleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hasPlus'] = _hasPlus;
    map['isTutorialCompleted'] = _isTutorialCompleted;
    return map;
  }

}