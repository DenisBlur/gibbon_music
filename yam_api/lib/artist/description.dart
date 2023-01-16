class Description {
  Description({
    this.text,
    this.uri,});

  Description.fromJson(dynamic json) {
    text = json['text'];
    uri = json['uri'];
  }
  String? text;
  String? uri;
  Description copyWith({  String? text,
    String? uri,
  }) => Description(  text: text ?? this.text,
    uri: uri ?? this.uri,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['uri'] = uri;
    return map;
  }

}