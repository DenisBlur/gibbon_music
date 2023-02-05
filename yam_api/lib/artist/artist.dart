import 'package:yam_api/artist/brief_info.dart';
import 'package:yam_api/artist/video.dart';

import '../album/album.dart';
import '../cover.dart';
import '../custom_wave.dart';
import '../playlist/playlist.dart';
import '../track/track.dart';
import 'concert.dart';
import 'stats.dart';
import 'track_in_chart.dart';

class Artist {
  Artist({
      this.briefInfo,
      this.albums, 
      this.alsoAlbums, 
      this.lastReleaseIds, 
      this.popularTracks, 
      this.similarArtists, 
      this.allCovers, 
      this.concerts, 
      this.videos, 
      this.clips, 
      this.vinyls, 
      this.hasPromotions, 
      this.tracksInChart, 
      this.lastReleases, 
      this.backgroundVideoUrl, 
      this.stats, 
      this.customWave, 
      this.playlistIds, 
      this.playlists,});

  Artist.fromJson(dynamic json) {
    briefInfo = json['artist'] != null ? BriefInfo.fromJson(json['artist']) : null;
    if (json['albums'] != null) {
      albums = [];
      json['albums'].forEach((v) {
        albums?.add(Album.fromJson(v));
      });
    }
    if (json['alsoAlbums'] != null) {
      alsoAlbums = [];
      json['alsoAlbums'].forEach((v) {
        alsoAlbums?.add(Album.fromJson(v));
      });
    }
    if (json['lastReleaseIds'] != null) {
      lastReleaseIds = [];
      json['lastReleaseIds'].forEach((v) {
        lastReleaseIds?.add(v);
      });
    }
    if (json['popularTracks'] != null) {
      popularTracks = [];
      json['popularTracks'].forEach((v) {
        popularTracks?.add(Track.fromJson(v));
      });
    }
    if (json['similarArtists'] != null) {
      similarArtists = [];
      json['similarArtists'].forEach((v) {
        similarArtists?.add(BriefInfo.fromJson(v));
      });
    }
    if (json['allCovers'] != null) {
      allCovers = [];
      json['allCovers'].forEach((v) {
        allCovers?.add(Cover.fromJson(v));
      });
    }
    if (json['concerts'] != null) {
      concerts = [];
      json['concerts'].forEach((v) {
        concerts?.add(Concert.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      videos = [];
      json['videos'].forEach((v) {
        videos?.add(Video.fromJson(v));
      });
    }
    hasPromotions = json['hasPromotions'];
    if (json['tracksInChart'] != null) {
      tracksInChart = [];
      json['tracksInChart'].forEach((v) {
        tracksInChart?.add(TracksInChart.fromJson(v));
      });
    }
    if (json['lastReleases'] != null) {
      lastReleases = [];
      json['lastReleases'].forEach((v) {
        lastReleases?.add(v);
      });
    }
    backgroundVideoUrl = json['backgroundVideoUrl'];
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
    customWave = json['customWave'] != null ? CustomWave.fromJson(json['customWave']) : null;
    if (json['playlistIds'] != null) {
      playlistIds = [];
      json['playlistIds'].forEach((v) {
        playlistIds?.add(PlaylistIds.fromJson(v));
      });
    }
    if (json['playlists'] != null) {
      playlists = [];
      json['playlists'].forEach((v) {
        playlists?.add(MPlaylist.fromJson(v));
      });
    }
  }
  BriefInfo? briefInfo;
  List<Album>? albums;
  List<Album>? alsoAlbums;
  List<dynamic>? lastReleaseIds;
  List<Track>? popularTracks;
  List<BriefInfo>? similarArtists;
  List<Cover>? allCovers;
  List<Concert>? concerts;
  List<Video>? videos;
  List<dynamic>? clips;
  List<dynamic>? vinyls;
  bool? hasPromotions;
  List<TracksInChart>? tracksInChart;
  List<dynamic>? lastReleases;
  String? backgroundVideoUrl;
  Stats? stats;
  CustomWave? customWave;
  List<PlaylistIds>? playlistIds;
  List<MPlaylist>? playlists = [];
Artist copyWith({  Artist? artist,
  List<Album>? albums,
  List<Album>? alsoAlbums,
  List<dynamic>? lastReleaseIds,
  List<Track>? popularTracks,
  List<BriefInfo>? similarArtists,
  List<Cover>? allCovers,
  List<Concert>? concerts,
  List<Video>? videos,
  List<dynamic>? clips,
  List<dynamic>? vinyls,
  bool? hasPromotions,
  List<TracksInChart>? tracksInChart,
  List<dynamic>? lastReleases,
  String? backgroundVideoUrl,
  Stats? stats,
  CustomWave? customWave,
  List<PlaylistIds>? playlistIds,
  List<MPlaylist>? playlists,
}) => Artist(  briefInfo: briefInfo ?? briefInfo,
  albums: albums ?? this.albums,
  alsoAlbums: alsoAlbums ?? this.alsoAlbums,
  lastReleaseIds: lastReleaseIds ?? this.lastReleaseIds,
  popularTracks: popularTracks ?? this.popularTracks,
  similarArtists: similarArtists ?? this.similarArtists,
  allCovers: allCovers ?? this.allCovers,
  concerts: concerts ?? this.concerts,
  videos: videos ?? this.videos,
  clips: clips ?? this.clips,
  vinyls: vinyls ?? this.vinyls,
  hasPromotions: hasPromotions ?? this.hasPromotions,
  tracksInChart: tracksInChart ?? this.tracksInChart,
  lastReleases: lastReleases ?? this.lastReleases,
  backgroundVideoUrl: backgroundVideoUrl ?? this.backgroundVideoUrl,
  stats: stats ?? this.stats,
  customWave: customWave ?? this.customWave,
  playlistIds: playlistIds ?? this.playlistIds,
  playlists: playlists ?? this.playlists,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (briefInfo != null) {
      map['artist'] = briefInfo?.toJson();
    }
    if (albums != null) {
      map['albums'] = albums?.map((v) => v.toJson()).toList();
    }
    if (alsoAlbums != null) {
      map['alsoAlbums'] = alsoAlbums?.map((v) => v.toJson()).toList();
    }
    if (lastReleaseIds != null) {
      map['lastReleaseIds'] = lastReleaseIds?.map((v) => v.toJson()).toList();
    }
    if (popularTracks != null) {
      map['popularTracks'] = popularTracks?.map((v) => v.toJson()).toList();
    }
    if (similarArtists != null) {
      map['similarArtists'] = similarArtists?.map((v) => v.toJson()).toList();
    }
    if (allCovers != null) {
      map['allCovers'] = allCovers?.map((v) => v.toJson()).toList();
    }
    if (concerts != null) {
      map['concerts'] = concerts?.map((v) => v.toJson()).toList();
    }
    if (videos != null) {
      map['videos'] = videos?.map((v) => v.toJson()).toList();
    }
    if (clips != null) {
      map['clips'] = clips?.map((v) => v.toJson()).toList();
    }
    if (vinyls != null) {
      map['vinyls'] = vinyls?.map((v) => v.toJson()).toList();
    }
    map['hasPromotions'] = hasPromotions;
    if (tracksInChart != null) {
      map['tracksInChart'] = tracksInChart?.map((v) => v.toJson()).toList();
    }
    if (lastReleases != null) {
      map['lastReleases'] = lastReleases?.map((v) => v.toJson()).toList();
    }
    map['backgroundVideoUrl'] = backgroundVideoUrl;
    if (stats != null) {
      map['stats'] = stats?.toJson();
    }
    if (customWave != null) {
      map['customWave'] = customWave?.toJson();
    }
    if (playlistIds != null) {
      map['playlistIds'] = playlistIds?.map((v) => v.toJson()).toList();
    }
    if (playlists != null) {
      map['playlists'] = playlists?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class PlaylistIds {
  PlaylistIds({
      this.uid, 
      this.kind,});

  PlaylistIds.fromJson(dynamic json) {
    uid = json['uid'];
    kind = json['kind'];
  }
  num? uid;
  num? kind;
PlaylistIds copyWith({  num? uid,
  num? kind,
}) => PlaylistIds(  uid: uid ?? this.uid,
  kind: kind ?? this.kind,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = uid;
    map['kind'] = kind;
    return map;
  }

}