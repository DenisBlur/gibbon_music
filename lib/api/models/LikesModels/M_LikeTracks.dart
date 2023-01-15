class MLikeTracks {
  MLikeTracks({
      this.library,});

  MLikeTracks.fromJson(dynamic json) {
    library = json['library'] != null ? Library.fromJson(json['library']) : null;
  }
  Library library;
MLikeTracks copyWith({  Library library,
}) => MLikeTracks(  library: library ?? this.library,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (library != null) {
      map['library'] = library.toJson();
    }
    return map;
  }

}

class Library {
  Library({
      this.uid, 
      this.revision, 
      this.playlistUuid, 
      this.tracks,});

  Library.fromJson(dynamic json) {
    uid = json['uid'];
    revision = json['revision'];
    playlistUuid = json['playlistUuid'];
    if (json['tracks'] != null) {
      tracks = [];
      json['tracks'].forEach((v) {
        tracks.add(Tracks.fromJson(v));
      });
    }
  }
  num uid;
  num revision;
  String playlistUuid;
  List<Tracks> tracks;
Library copyWith({  num uid,
  num revision,
  String playlistUuid,
  List<Tracks> tracks,
}) => Library(  uid: uid ?? this.uid,
  revision: revision ?? this.revision,
  playlistUuid: playlistUuid ?? this.playlistUuid,
  tracks: tracks ?? this.tracks,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = uid;
    map['revision'] = revision;
    map['playlistUuid'] = playlistUuid;
    if (tracks != null) {
      map['tracks'] = tracks.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Tracks {
  Tracks({
      this.id, 
      this.albumId, 
      this.timestamp,});

  Tracks.fromJson(dynamic json) {
    id = json['id'];
    albumId = json['albumId'];
    timestamp = json['timestamp'];
  }
  String id;
  String albumId;
  String timestamp;
Tracks copyWith({  String id,
  String albumId,
  String timestamp,
}) => Tracks(  id: id ?? this.id,
  albumId: albumId ?? this.albumId,
  timestamp: timestamp ?? this.timestamp,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['albumId'] = albumId;
    map['timestamp'] = timestamp;
    return map;
  }

}