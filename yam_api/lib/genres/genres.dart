class Genres {
  Genres({
      this.id, 
      this.weight, 
      this.composerTop, 
      this.title, 
      this.fullTitle, 
      this.titles, 
      this.images, 
      this.showInMenu,});

  Genres.fromJson(dynamic json) {
    id = json['id'];
    weight = json['weight'];
    composerTop = json['composerTop'];
    title = json['title'];
    fullTitle = json['fullTitle'];
    titles = json['titles'];
    images = json['images'];
    showInMenu = json['showInMenu'];
  }
  String? id;
  num? weight;
  bool? composerTop;
  String? title;
  String? fullTitle;
  dynamic titles;
  dynamic images;
  bool? showInMenu;
Genres copyWith({  String? id,
  num? weight,
  bool? composerTop,
  String? title,
  String? fullTitle,
  dynamic titles,
  dynamic images,
  bool? showInMenu,
}) => Genres(  id: id ?? this.id,
  weight: weight ?? this.weight,
  composerTop: composerTop ?? this.composerTop,
  title: title ?? this.title,
  fullTitle: fullTitle ?? this.fullTitle,
  titles: titles ?? this.titles,
  images: images ?? this.images,
  showInMenu: showInMenu ?? this.showInMenu,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['weight'] = weight;
    map['composerTop'] = composerTop;
    map['title'] = title;
    map['fullTitle'] = fullTitle;
    if (titles != null) {
      map['titles'] = titles?.toJson();
    }
    map['images'] = images;
    map['showInMenu'] = showInMenu;
    return map;
  }

}

class Ru {
  Ru({
      this.title, 
      this.fullTitle,});

  Ru.fromJson(dynamic json) {
    title = json['title'];
    fullTitle = json['fullTitle'];
  }
  String? title;
  String? fullTitle;
Ru copyWith({  String? title,
  String? fullTitle,
}) => Ru(  title: title ?? this.title,
  fullTitle: fullTitle ?? this.fullTitle,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['fullTitle'] = fullTitle;
    return map;
  }

}