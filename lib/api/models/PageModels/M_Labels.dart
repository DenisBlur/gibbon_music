class MLabels {
  MLabels({
    this.id,
    this.name,});

  MLabels.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  num id;
  String name;
  MLabels copyWith({  num id,
    String name,
  }) => MLabels(  id: id ?? this.id,
    name: name ?? this.name,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}
