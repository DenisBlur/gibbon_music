class Rating {
  Rating({
    this.week,
    this.month,
    this.day,});

  Rating.fromJson(dynamic json) {
    week = json['week'];
    month = json['month'];
    day = json['day'];
  }
  num? week;
  num? month;
  num? day;
  Rating copyWith({  num? week,
    num? month,
    num? day,
  }) => Rating(  week: week ?? this.week,
    month: month ?? this.month,
    day: day ?? this.day,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['week'] = week;
    map['month'] = month;
    map['day'] = day;
    return map;
  }

}