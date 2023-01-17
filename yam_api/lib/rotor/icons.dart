class MtsIcon {
  MtsIcon({
    this.backgroundColor,
    this.imageUrl,
  });

  MtsIcon.fromJson(dynamic json) {
    backgroundColor = json['backgroundColor'];
    imageUrl = json['imageUrl'];
  }

  String? backgroundColor;
  String? imageUrl;

  MtsIcon copyWith({
    String? backgroundColor,
    String? imageUrl,
  }) =>
      MtsIcon(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['backgroundColor'] = backgroundColor;
    map['imageUrl'] = imageUrl;
    return map;
  }
}

class Icon {
  Icon({
    this.backgroundColor,
    this.imageUrl,
  });

  Icon.fromJson(dynamic json) {
    backgroundColor = json['backgroundColor'];
    imageUrl = json['imageUrl'];
  }

  String? backgroundColor;
  String? imageUrl;

  Icon copyWith({
    String? backgroundColor,
    String? imageUrl,
  }) =>
      Icon(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['backgroundColor'] = backgroundColor;
    map['imageUrl'] = imageUrl;
    return map;
  }
}

class Id {
  Id({
    this.type,
    this.tag,
  });

  Id.fromJson(dynamic json) {
    type = json['type'];
    tag = json['tag'];
  }

  String? type;
  String? tag;

  Id copyWith({
    String? type,
    String? tag,
  }) =>
      Id(
        type: type ?? this.type,
        tag: tag ?? this.tag,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['tag'] = tag;
    return map;
  }
}
