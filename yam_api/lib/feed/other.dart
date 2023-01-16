class Title {
  Title({
    this.type,
    this.text,});

  Title.fromJson(dynamic json) {
    type = json['type'];
    text = json['text'];
  }
  String? type;
  String? text;
  Title copyWith({  String? type,
    String? text,
  }) => Title(  type: type ?? this.type,
    text: text ?? this.text,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['text'] = text;
    return map;
  }

}

class Headlines {
  Headlines({
    this.type,
    this.id,
    this.message,});

  Headlines.fromJson(dynamic json) {
    type = json['type'];
    id = json['id'];
    message = json['message'];
  }
  String? type;
  String? id;
  String? message;
  Headlines copyWith({  String? type,
    String? id,
    String? message,
  }) => Headlines(  type: type ?? this.type,
    id: id ?? this.id,
    message: message ?? this.message,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['id'] = id;
    map['message'] = message;
    return map;
  }

}