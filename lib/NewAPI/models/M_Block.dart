class MBlock {
  MBlock({
      this.id, 
      this.type, 
      this.typeForFrom, 
      this.title, 
      this.entities,});

  MBlock.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    typeForFrom = json['typeForFrom'];
    title = json['title'];
    if (json['entities'] != null) {
      entities = [];
      json['entities'].forEach((v) {
        entities.add(Entities.fromJson(v));
      });
    }
  }
  String id;
  String type;
  String typeForFrom;
  String title;
  List<Entities> entities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['typeForFrom'] = typeForFrom;
    map['title'] = title;
    if (entities != null) {
      map['entities'] = entities.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

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