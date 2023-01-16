class Entities {
  Entities({
    this.id,
    this.type,
    this.data,});

  Entities.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    data = json['data'];
  }
  String? id;
  String? type;
  dynamic data;
  Entities copyWith({  String? id,
    String? type,
    dynamic data,
  }) => Entities(  id: id ?? this.id,
    type: type ?? this.type,
    data: data ?? this.data,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}