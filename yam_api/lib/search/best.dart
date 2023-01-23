class Best {
  Best({
    this.type,
    this.result,
  });

  Best.fromJson(dynamic json) {
    type = json['type'];
    result = json['result'];
  }

  String? type;
  dynamic result;

  Best copyWith({
    String? type,
    dynamic result,
  }) =>
      Best(
        type: type ?? this.type,
        result: result ?? this.result,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }
}
