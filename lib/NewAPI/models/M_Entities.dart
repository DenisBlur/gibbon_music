class MEntities {
  MEntities({
    this.id,
    this.type,
    this.data,});

  MEntities.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    data = json['data'];
  }
  String id;
  String type;
  dynamic data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['data'] = data;
    return map;
  }

}