class PlayCounter {
  PlayCounter({
    this.value,
    this.description,
    this.descriptionNext,
    this.updated,});

  PlayCounter.fromJson(dynamic json) {
    value = json['value'];
    description = json['description'];
    descriptionNext = json['descriptionNext'];
    updated = json['updated'];
  }
  num? value;
  String? description;
  String? descriptionNext;
  bool? updated;
  PlayCounter copyWith({  num? value,
    String? description,
    String? descriptionNext,
    bool? updated,
  }) => PlayCounter(  value: value ?? this.value,
    description: description ?? this.description,
    descriptionNext: descriptionNext ?? this.descriptionNext,
    updated: updated ?? this.updated,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['description'] = description;
    map['descriptionNext'] = descriptionNext;
    map['updated'] = updated;
    return map;
  }

}