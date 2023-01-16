class Stats {
  Stats({
    this.lastMonthListeners,});

  Stats.fromJson(dynamic json) {
    lastMonthListeners = json['lastMonthListeners'];
  }
  num? lastMonthListeners;
  Stats copyWith({  num? lastMonthListeners,
  }) => Stats(  lastMonthListeners: lastMonthListeners ?? this.lastMonthListeners,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lastMonthListeners'] = lastMonthListeners;
    return map;
  }

}