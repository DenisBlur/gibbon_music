class Count {
  Count({
    this.tracks,
    this.directAlbums,
    this.alsoAlbums,
    this.alsoTracks,});

  Count.fromJson(dynamic json) {
    tracks = json['tracks'];
    directAlbums = json['directAlbums'];
    alsoAlbums = json['alsoAlbums'];
    alsoTracks = json['alsoTracks'];
  }
  num? tracks;
  num? directAlbums;
  num? alsoAlbums;
  num? alsoTracks;
  Count copyWith({  num? tracks,
    num? directAlbums,
    num? alsoAlbums,
    num? alsoTracks,
  }) => Count(  tracks: tracks ?? this.tracks,
    directAlbums: directAlbums ?? this.directAlbums,
    alsoAlbums: alsoAlbums ?? this.alsoAlbums,
    alsoTracks: alsoTracks ?? this.alsoTracks,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tracks'] = tracks;
    map['directAlbums'] = directAlbums;
    map['alsoAlbums'] = alsoAlbums;
    map['alsoTracks'] = alsoTracks;
    return map;
  }

}