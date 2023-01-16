class Menu {
  Menu({
    this.items,});

  Menu.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }
  List<Items>? items;
  Menu copyWith({  List<Items>? items,
  }) => Menu(  items: items ?? this.items,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Items {
  Items({
    this.title,
    this.url,
    this.selected,});

  Items.fromJson(dynamic json) {
    title = json['title'];
    url = json['url'];
    selected = json['selected'];
  }
  String? title;
  String? url;
  bool? selected;
  Items copyWith({  String? title,
    String? url,
    bool? selected,
  }) => Items(  title: title ?? this.title,
    url: url ?? this.url,
    selected: selected ?? this.selected,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['url'] = url;
    map['selected'] = selected;
    return map;
  }

}