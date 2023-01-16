class Promotion {
  Promotion({
    this.type,
    this.notify,
    this.previewDescription,
    this.ready,
    this.description,
    this.data,});

  Promotion.fromJson(dynamic json) {
    type = json['type'];
    notify = json['notify'];
    previewDescription = json['previewDescription'];
    ready = json['ready'];
    if (json['description'] != null) {
      description = [];
      json['description'].forEach((v) {
        description?.add(v);
      });
    }
    data = json['data'] != null ? Promotion.fromJson(json['data']) : null;
  }
  String? type;
  bool? notify;
  String? previewDescription;
  bool? ready;
  List<dynamic>? description;
  Promotion? data;
  Promotion copyWith({  String? type,
    bool? notify,
    String? previewDescription,
    bool? ready,
    List<dynamic>? description,
    Promotion? data,
  }) => Promotion(  type: type ?? this.type,
    notify: notify ?? this.notify,
    previewDescription: previewDescription ?? this.previewDescription,
    ready: ready ?? this.ready,
    description: description ?? this.description,
    data: data ?? this.data,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['notify'] = notify;
    map['previewDescription'] = previewDescription;
    map['ready'] = ready;
    if (description != null) {
      map['description'] = description?.map((v) => v.toJson()).toList();
    }
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}