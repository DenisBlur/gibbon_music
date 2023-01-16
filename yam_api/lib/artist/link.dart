class Link {
  Link({
    this.title,
    this.href,
    this.type,});

  Link.fromJson(dynamic json) {
    title = json['title'];
    href = json['href'];
    type = json['type'];
  }
  String? title;
  String? href;
  String? type;
  Link copyWith({  String? title,
    String? href,
    String? type,
  }) => Link(  title: title ?? this.title,
    href: href ?? this.href,
    type: type ?? this.type,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['href'] = href;
    map['type'] = type;
    return map;
  }

}