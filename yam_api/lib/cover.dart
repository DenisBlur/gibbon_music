class Cover {
  Cover({
    this.type,
    this.version,
    this.dir,
    this.custom,
    this.prefix,
    this.uri,
  });

  Cover.fromJson(dynamic json) {
    type = json['type'];
    prefix = json['prefix'];
    uri = json['uri'];
    dir = json['dir'];
    version = json['version'];
    custom = json['custom'];
  }

  String? type;
  String? prefix;
  String? uri;
  String? dir;
  String? version;
  bool? custom;

  Cover copyWith({
    String? type,
    String? prefix,
    String? uri,
    String? dir,
    String? version,
    bool? custom,
  }) =>
      Cover(
        type: type ?? this.type,
        prefix: prefix ?? this.prefix,
        uri: uri ?? this.uri,
        dir: dir ?? this.dir,
        version: version ?? this.version,
        custom: custom ?? this.custom,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['prefix'] = prefix;
    map['uri'] = uri;
    map['dir'] = dir;
    map['version'] = version;
    map['custom'] = custom;
    return map;
  }
}
