class R128 {
  R128({
    this.i,
    this.tp,});

  R128.fromJson(dynamic json) {
    i = json['i'];
    tp = json['tp'];
  }
  num? i;
  num? tp;
  R128 copyWith({  num? i,
    num? tp,
  }) => R128(  i: i ?? this.i,
    tp: tp ?? this.tp,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['i'] = i;
    map['tp'] = tp;
    return map;
  }

}