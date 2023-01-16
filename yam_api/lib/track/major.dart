class Major {
  Major({
    this.id,
    this.name,});

  Major.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  num? id;
  String? name;
  Major copyWith({  num? id,
    String? name,
  }) => Major(  id: id ?? this.id,
    name: name ?? this.name,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}