import 'package:gibbon_music/api/models/M_Album.dart';
import 'package:gibbon_music/api/models/M_Artist.dart';
import 'package:gibbon_music/api/models/M_Playlist.dart';
import 'package:gibbon_music/api/models/M_Track.dart';

class MSearch {
  MSearch({
    this.misspellCorrected,
    this.nocorrect,
    this.searchRequestId,
    this.text,
    this.best,
    this.tracks,
    this.playlists,
    this.artists,
    this.albums,
  });

  MSearch.fromJson(dynamic json) {
    misspellCorrected = json['misspellCorrected'];
    nocorrect = json['nocorrect'];
    searchRequestId = json['searchRequestId'];
    text = json['text'];
    best = json['best'] != null ? Best.fromJson(json['best']) : null;
    tracks = json['tracks'] != null ? Tracks.fromJson(json['tracks']) : null;
    playlists = json['playlists'] != null ? Playlists.fromJson(json['playlists']) : null;
    artists = json['artists'] != null ? Artists.fromJson(json['artists']) : null;
    albums = json['albums'] != null ? Albums.fromJson(json['albums']) : null;
  }

  bool misspellCorrected;
  bool nocorrect;
  String searchRequestId;
  String text;
  Best best;
  Tracks tracks;
  Playlists playlists;
  Artists artists;
  Albums albums;

  MSearch copyWith({
    bool misspellCorrected,
    bool nocorrect,
    String searchRequestId,
    String text,
    Best best,
    Tracks tracks,
    Playlists playlists,
    Artists artists,
    Albums albums,
  }) =>
      MSearch(
        misspellCorrected: misspellCorrected ?? this.misspellCorrected,
        nocorrect: nocorrect ?? this.nocorrect,
        searchRequestId: searchRequestId ?? this.searchRequestId,
        text: text ?? this.text,
        best: best ?? this.best,
        tracks: tracks ?? this.tracks,
        playlists: playlists ?? this.playlists,
        artists: artists ?? this.artists,
        albums: albums ?? this.albums,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['misspellCorrected'] = misspellCorrected;
    map['nocorrect'] = nocorrect;
    map['searchRequestId'] = searchRequestId;
    map['text'] = text;
    if (best != null) {
      map['best'] = best.toJson();
    }
    if (tracks != null) {
      map['tracks'] = tracks.toJson();
    }
    map['playlists'] = playlists;
    if (artists != null) {
      map['artists'] = artists.toJson();
    }
    if (albums != null) {
      map['albums'] = albums.toJson();
    }
    return map;
  }
}

class Albums {
  Albums({
    this.total,
    this.perPage,
    this.order,
    this.results,
  });

  Albums.fromJson(dynamic json) {
    total = json['total'];
    perPage = json['perPage'];
    order = json['order'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(MAlbum.fromJson(v));
      });
    }
  }

  num total;
  num perPage;
  num order;
  List<MAlbum> results;

  Albums copyWith({
    num total,
    num perPage,
    num order,
    List<MAlbum> results,
  }) =>
      Albums(
        total: total ?? this.total,
        perPage: perPage ?? this.perPage,
        order: order ?? this.order,
        results: results ?? this.results,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['perPage'] = perPage;
    map['order'] = order;
    if (results != null) {
      map['results'] = results.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Artists {
  Artists({
    this.total,
    this.perPage,
    this.order,
    this.results,
  });

  Artists.fromJson(dynamic json) {
    total = json['total'];
    perPage = json['perPage'];
    order = json['order'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(MArtist.fromJson(v));
      });
    }
  }

  num total;
  num perPage;
  num order;
  List<MArtist> results;

  Artists copyWith({
    num total,
    num perPage,
    num order,
    List<MArtist> results,
  }) =>
      Artists(
        total: total ?? this.total,
        perPage: perPage ?? this.perPage,
        order: order ?? this.order,
        results: results ?? this.results,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['perPage'] = perPage;
    map['order'] = order;
    if (results != null) {
      map['results'] = results.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Playlists {
  Playlists({
    this.total,
    this.perPage,
    this.order,
    this.results,
  });

  Playlists.fromJson(dynamic json) {
    total = json['total'];
    perPage = json['perPage'];
    order = json['order'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(MPlaylist.fromJson(v));
      });
    }
  }

  num total;
  num perPage;
  num order;
  List<MPlaylist> results;

  Playlists copyWith({
    num total,
    num perPage,
    num order,
    List<MPlaylist> results,
  }) =>
      Playlists(
        total: total ?? this.total,
        perPage: perPage ?? this.perPage,
        order: order ?? this.order,
        results: results ?? this.results,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['perPage'] = perPage;
    map['order'] = order;
    if (results != null) {
      map['results'] = results.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Tracks {
  Tracks({
    this.total,
    this.perPage,
    this.order,
    this.results,
  });

  Tracks.fromJson(dynamic json) {
    total = json['total'];
    perPage = json['perPage'];
    order = json['order'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(MTrack.fromJson(v));
      });
    }
  }

  num total;
  num perPage;
  num order;
  List<MTrack> results;

  Tracks copyWith({
    num total,
    num perPage,
    num order,
    List<MTrack> results,
  }) =>
      Tracks(
        total: total ?? this.total,
        perPage: perPage ?? this.perPage,
        order: order ?? this.order,
        results: results ?? this.results,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['perPage'] = perPage;
    map['order'] = order;
    if (results != null) {
      map['results'] = results.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Best {
  Best({
    this.type,
    this.result,
  });

  Best.fromJson(dynamic json) {
    type = json['type'];
    result = json['result'] != null ? result = json['result'] : null;
  }

  String type;
  dynamic result;

  Best copyWith({
    String type,
    MArtist result,
  }) =>
      Best(
        type: type ?? this.type,
        result: result ?? this.result,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    if (result != null) {
      map['result'] = result.toJson();
    }
    return map;
  }
}
