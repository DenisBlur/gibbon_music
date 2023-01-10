import '../M_Cover.dart';

class MInnerArtist {
  MInnerArtist({
      this.id, 
      this.name, 
      this.various, 
      this.composer, 
      this.cover, 
      this.genres,});

  MInnerArtist.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    various = json['various'];
    composer = json['composer'];
    cover = json['cover'] != null ? MCover.fromJson(json['cover']) : null;
    if (json['genres'] != null) {
      genres = [];
      json['genres'].forEach((v) {
        genres.add(v);
      });
    }
  }
  num id;
  String name;
  bool various;
  bool composer;
  MCover cover;
  List<dynamic> genres;
MInnerArtist copyWith({  num id,
  String name,
  bool various,
  bool composer,
  MCover cover,
  List<dynamic> genres,
}) => MInnerArtist(  id: id ?? this.id,
  name: name ?? this.name,
  various: various ?? this.various,
  composer: composer ?? this.composer,
  cover: cover ?? this.cover,
  genres: genres ?? this.genres,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['various'] = various;
    map['composer'] = composer;
    if (cover != null) {
      map['cover'] = cover.toJson();
    }
    if (genres != null) {
      map['genres'] = genres.map((v) => v.toJson()).toList();
    }
    return map;
  }

}