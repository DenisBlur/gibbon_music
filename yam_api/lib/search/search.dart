import 'package:yam_api/search/search_result.dart';

import 'best.dart';

class Search {
  Search({
      this.misspellCorrected, 
      this.nocorrect, 
      this.searchRequestId, 
      this.text, 
      this.best, 
      this.playlists, 
      this.albums, 
      this.podcastEpisodes, 
      this.podcasts, 
      this.artists, 
      this.tracks,});

  Search.fromJson(dynamic json) {
    misspellCorrected = json['misspellCorrected'];
    nocorrect = json['nocorrect'];
    searchRequestId = json['searchRequestId'];
    text = json['text'];
    best = json['best'] != null ? Best.fromJson(json['best']) : null;
    playlists = json['playlists'] != null ? PlaylistSearchResult.fromJson(json['playlists']) : null;
    albums = json['albums'] != null ? AlbumSearchResult.fromJson(json['albums']) : null;
    podcastEpisodes = json['podcast_episodes'] != null ? PodcastSearchResult.fromJson(json['podcast_episodes']) : null;
    podcasts = json['podcasts'] != null ? PodcastSearchResult.fromJson(json['podcasts']) : null;
    artists = json['artists'] != null ? ArtistSearchResult.fromJson(json['artists']) : null;
    tracks = json['tracks'] != null ? TrackSearchResult.fromJson(json['tracks']) : null;
  }
  bool? misspellCorrected;
  bool? nocorrect;
  String? searchRequestId;
  String? text;
  Best? best;
  PlaylistSearchResult? playlists;
  AlbumSearchResult? albums;
  PodcastSearchResult? podcastEpisodes;
  PodcastSearchResult? podcasts;
  ArtistSearchResult? artists;
  TrackSearchResult? tracks;
Search copyWith({  bool? misspellCorrected,
  bool? nocorrect,
  String? searchRequestId,
  String? text,
  Best? best,
  PlaylistSearchResult? playlists,
  AlbumSearchResult? albums,
  PodcastSearchResult? podcastEpisodes,
  PodcastSearchResult? podcasts,
  ArtistSearchResult? artists,
  TrackSearchResult? tracks,
}) => Search(  misspellCorrected: misspellCorrected ?? this.misspellCorrected,
  nocorrect: nocorrect ?? this.nocorrect,
  searchRequestId: searchRequestId ?? this.searchRequestId,
  text: text ?? this.text,
  best: best ?? this.best,
  playlists: playlists ?? this.playlists,
  albums: albums ?? this.albums,
  podcastEpisodes: podcastEpisodes ?? this.podcastEpisodes,
  podcasts: podcasts ?? this.podcasts,
  artists: artists ?? this.artists,
  tracks: tracks ?? this.tracks,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['misspellCorrected'] = misspellCorrected;
    map['nocorrect'] = nocorrect;
    map['searchRequestId'] = searchRequestId;
    map['text'] = text;
    if (best != null) {
      map['best'] = best?.toJson();
    }
    if (albums != null) {
      map['playlists'] = playlists?.toJson();
    }
    if (albums != null) {
      map['albums'] = albums?.toJson();
    }
    if (podcastEpisodes != null) {
      map['podcast_episodes'] = podcastEpisodes?.toJson();
    }
    if (podcasts != null) {
      map['podcasts'] = podcasts?.toJson();
    }
    if (artists != null) {
      map['artists'] = artists?.toJson();
    }
    if (tracks != null) {
      map['tracks'] = tracks?.toJson();
    }
    return map;
  }

}
