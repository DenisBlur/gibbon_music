import 'package:yam_api/album/album.dart';
import 'package:yam_api/artist/brief_info.dart';
import 'package:yam_api/playlist/playlist.dart';
import 'package:yam_api/podcast/podcast.dart';
import 'package:yam_api/track/track.dart';

class PlaylistSearchResult {
  PlaylistSearchResult({
    this.total,
    this.perPage,
    this.order,
    this.results,
  });

  PlaylistSearchResult.fromJson(dynamic json) {
    total = json['total'];
    perPage = json['perPage'];
    order = json['order'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(MPlaylist.fromJson(v));
      });
    }
  }

  num? total;
  num? perPage;
  num? order;
  List<MPlaylist>? results;

  PlaylistSearchResult copyWith({
    num? total,
    num? perPage,
    num? order,
    List<MPlaylist>? results,
  }) =>
      PlaylistSearchResult(
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
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TrackSearchResult {
  TrackSearchResult({
    this.total,
    this.perPage,
    this.order,
    this.results,
  });

  TrackSearchResult.fromJson(dynamic json) {
    total = json['total'];
    perPage = json['perPage'];
    order = json['order'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Track.fromJson(v));
      });
    }
  }

  num? total;
  num? perPage;
  num? order;
  List<Track>? results;

  TrackSearchResult copyWith({
    num? total,
    num? perPage,
    num? order,
    List<Track>? results,
  }) =>
      TrackSearchResult(
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
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ArtistSearchResult {
  ArtistSearchResult({
    this.total,
    this.perPage,
    this.order,
    this.results,
  });

  ArtistSearchResult.fromJson(dynamic json) {
    total = json['total'];
    perPage = json['perPage'];
    order = json['order'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(BriefInfo.fromJson(v));
      });
    }
  }

  num? total;
  num? perPage;
  num? order;
  List<BriefInfo>? results;

  ArtistSearchResult copyWith({
    num? total,
    num? perPage,
    num? order,
    List<BriefInfo>? results,
  }) =>
      ArtistSearchResult(
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
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class AlbumSearchResult {
  AlbumSearchResult({
    this.total,
    this.perPage,
    this.order,
    this.results,
  });

  AlbumSearchResult.fromJson(dynamic json) {
    total = json['total'];
    perPage = json['perPage'];
    order = json['order'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Album.fromJson(v));
      });
    }
  }

  num? total;
  num? perPage;
  num? order;
  List<Album>? results;

  AlbumSearchResult copyWith({
    num? total,
    num? perPage,
    num? order,
    List<Album>? results,
  }) =>
      AlbumSearchResult(
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
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class PodcastSearchResult {
  PodcastSearchResult({
    this.total,
    this.perPage,
    this.order,
    this.results,
  });

  PodcastSearchResult.fromJson(dynamic json) {
    total = json['total'];
    perPage = json['perPage'];
    order = json['order'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Podcast.fromJson(v));
      });
    }
  }

  num? total;
  num? perPage;
  num? order;
  List<Podcast>? results;

  PodcastSearchResult copyWith({
    num? total,
    num? perPage,
    num? order,
    List<Podcast>? results,
  }) =>
      PodcastSearchResult(
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
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
