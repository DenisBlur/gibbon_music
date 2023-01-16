class NewReleases {
  NewReleases({
      this.id, 
      this.type, 
      this.typeForFrom, 
      this.title, 
      this.newReleases,});

  NewReleases.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    typeForFrom = json['typeForFrom'];
    title = json['title'];
    newReleases = json['newReleases'] != null ? json['newReleases'].cast<num>() : [];
  }
  String? id;
  String? type;
  String? typeForFrom;
  String? title;
  List<num>? newReleases;
NewReleases copyWith({  String? id,
  String? type,
  String? typeForFrom,
  String? title,
  List<num>? newReleases,
}) => NewReleases(  id: id ?? this.id,
  type: type ?? this.type,
  typeForFrom: typeForFrom ?? this.typeForFrom,
  title: title ?? this.title,
  newReleases: newReleases ?? this.newReleases,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['typeForFrom'] = typeForFrom;
    map['title'] = title;
    map['newReleases'] = newReleases;
    return map;
  }

}