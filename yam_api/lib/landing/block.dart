import 'entities.dart';

class Block {
  Block({
    this.id,
    this.type,
    this.typeForFrom,
    this.title,
    this.data,
    this.entities,});

  Block.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    typeForFrom = json['typeForFrom'];
    title = json['title'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['entities'] != null) {
      entities = [];
      json['entities'].forEach((v) {
        entities?.add(Entities.fromJson(v));
      });
    }
  }
  String? id;
  String? type;
  String? typeForFrom;
  String? title;
  Data? data;
  List<Entities>? entities;
  Block copyWith({  String? id,
    String? type,
    String? typeForFrom,
    String? title,
    Data? data,
    List<Entities>? entities,
  }) => Block(  id: id ?? this.id,
    type: type ?? this.type,
    typeForFrom: typeForFrom ?? this.typeForFrom,
    title: title ?? this.title,
    data: data ?? this.data,
    entities: entities ?? this.entities,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['typeForFrom'] = typeForFrom;
    map['title'] = title;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (entities != null) {
      map['entities'] = entities?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    this.isWizardPassed,});

  Data.fromJson(dynamic json) {
    isWizardPassed = json['isWizardPassed'];
  }
  bool? isWizardPassed;
  Data copyWith({  bool? isWizardPassed,
  }) => Data(  isWizardPassed: isWizardPassed ?? this.isWizardPassed,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isWizardPassed'] = isWizardPassed;
    return map;
  }

}