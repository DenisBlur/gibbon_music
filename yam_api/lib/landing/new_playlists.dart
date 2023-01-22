class NewPlaylists {
  NewPlaylists({
    this.id,
    this.type,
    this.typeForFrom,
    this.title,
    this.playlistIds,
  });

  NewPlaylists.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    typeForFrom = json['typeForFrom'];
    title = json['title'];
    if (json['newPlaylists'] != null) {
      playlistIds = [];
      json['newPlaylists'].forEach((v) {
        playlistIds?.add(PlaylistIds.fromJson(v));
      });
    }
  }

  String? id;
  String? type;
  String? typeForFrom;
  String? title;
  List<PlaylistIds>? playlistIds;

  NewPlaylists copyWith({
    String? id,
    String? type,
    String? typeForFrom,
    String? title,
    List<PlaylistIds>? playlistIds,
  }) =>
      NewPlaylists(
        id: id ?? this.id,
        type: type ?? this.type,
        typeForFrom: typeForFrom ?? this.typeForFrom,
        title: title ?? this.title,
        playlistIds: playlistIds ?? this.playlistIds,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['typeForFrom'] = typeForFrom;
    map['title'] = title;
    if (playlistIds != null) {
      map['newPlaylists'] = playlistIds?.map((v) => v.toJson()).toList();
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
