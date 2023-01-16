import '../track/track.dart';
import 'other.dart';

class Events {
  Events({
    this.id,
    this.type,
    this.typeForFrom,
    this.title,
    this.genre,
    this.radioIsAvailable,
    this.tracks,});

  Events.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    typeForFrom = json['typeForFrom'];
    if (json['title'] != null) {
      title = [];
      json['title'].forEach((v) {
        title?.add(Title.fromJson(v));
      });
    }
    genre = json['genre'];
    radioIsAvailable = json['radioIsAvailable'];
    if (json['tracks'] != null) {
      tracks = [];
      json['tracks'].forEach((v) {
        tracks?.add(Track.fromJson(v));
      });
    }
  }
  String? id;
  String? type;
  String? typeForFrom;
  List<Title>? title;
  String? genre;
  bool? radioIsAvailable;
  List<Track>? tracks;
  Events copyWith({  String? id,
    String? type,
    String? typeForFrom,
    List<Title>? title,
    String? genre,
    bool? radioIsAvailable,
    List<Track>? tracks,
  }) => Events(  id: id ?? this.id,
    type: type ?? this.type,
    typeForFrom: typeForFrom ?? this.typeForFrom,
    title: title ?? this.title,
    genre: genre ?? this.genre,
    radioIsAvailable: radioIsAvailable ?? this.radioIsAvailable,
    tracks: tracks ?? this.tracks,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['typeForFrom'] = typeForFrom;
    if (title != null) {
      map['title'] = title?.map((v) => v.toJson()).toList();
    }
    map['genre'] = genre;
    map['radioIsAvailable'] = radioIsAvailable;
    if (tracks != null) {
      map['tracks'] = tracks?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}