class MCover {
  MCover({
    this.type,
    this.prefix,
    this.uri,});

  MCover.fromJson(dynamic json) {
    type = json['type'];
    prefix = json['prefix'];
    uri = json['uri'];
  }
  String type;
  String prefix;
  String uri;
  MCover copyWith({  String type,
    String prefix,
    String uri,
  }) => MCover(  type: type ?? this.type,
    prefix: prefix ?? this.prefix,
    uri: uri ?? this.uri,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['prefix'] = prefix;
    map['uri'] = uri;
    return map;
  }

}