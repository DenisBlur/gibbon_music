class NewPlaylists {
  NewPlaylists({
    this.id,
    this.type,
    this.typeForFrom,
    this.title,
    this.newPlaylists,
  });

  NewPlaylists.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    typeForFrom = json['typeForFrom'];
    title = json['title'];
    if (json['newPlaylists'] != null) {
      newPlaylists = [];
      json['newPlaylists'].forEach((v) {
        newPlaylists?.add(NewPlaylists.fromJson(v));
      });
    }
  }

  String? id;
  String? type;
  String? typeForFrom;
  String? title;
  List<NewPlaylists>? newPlaylists;

  NewPlaylists copyWith({
    String? id,
    String? type,
    String? typeForFrom,
    String? title,
    List<NewPlaylists>? newPlaylists,
  }) =>
      NewPlaylists(
        id: id ?? this.id,
        type: type ?? this.type,
        typeForFrom: typeForFrom ?? this.typeForFrom,
        title: title ?? this.title,
        newPlaylists: newPlaylists ?? this.newPlaylists,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['typeForFrom'] = typeForFrom;
    map['title'] = title;
    if (newPlaylists != null) {
      map['newPlaylists'] = newPlaylists?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class PlaylistIds {
  PlaylistIds({
    this.uid,
    this.kind,
  });

  PlaylistIds.fromJson(dynamic json) {
    uid = json['uid'];
    kind = json['kind'];
  }

  num? uid;
  num? kind;

  PlaylistIds copyWith({
    num? uid,
    num? kind,
  }) =>
      PlaylistIds(
        uid: uid ?? this.uid,
        kind: kind ?? this.kind,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = uid;
    map['kind'] = kind;
    return map;
  }
}
