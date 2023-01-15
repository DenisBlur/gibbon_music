import 'package:gibbon_music/api/models/M_Cover.dart';
import 'package:gibbon_music/api/models/M_Playlist.dart';
import 'package:gibbon_music/api/models/M_Track.dart';

import '../M_Album.dart';
import 'M_CustomWave.dart';

class MPageArtist {
  MPageArtist({
      this.artist, 
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
      this.stats, 
      this.customWave, 
      this.playlistIds, 
      this.playlists,});

  MPageArtist.fromJson(dynamic json) {
    artist = json['artist'] != null ? ArtistInfo.fromJson(json['artist']) : null;
    if (json['albums'] != null) {
      albums = [];
      json['albums'].forEach((v) {
        albums.add(MAlbum.fromJson(v));
      });
    }
    if (json['alsoAlbums'] != null) {
      alsoAlbums = [];
      json['alsoAlbums'].forEach((v) {
        alsoAlbums.add(MAlbum.fromJson(v));
      });
    }
    lastReleaseIds = json['lastReleaseIds'] != null ? json['lastReleaseIds'].cast<num>() : [];
    if (json['popularTracks'] != null) {
      popularTracks = [];
      json['popularTracks'].forEach((v) {
        popularTracks.add(MTrack.fromJson(v));
      });
    }
    if (json['similarArtists'] != null) {
      similarArtists = [];
      json['similarArtists'].forEach((v) {
        similarArtists.add(SimilarArtists.fromJson(v));
      });
    }
    if (json['allCovers'] != null) {
      allCovers = [];
      json['allCovers'].forEach((v) {
        allCovers.add(AllCovers.fromJson(v));
      });
    }
    if (json['concerts'] != null) {
      concerts = [];
      json['concerts'].forEach((v) {
        concerts.add(Concerts.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      videos = [];
      json['videos'].forEach((v) {
        videos.add(Videos.fromJson(v));
      });
    }
    if (json['clips'] != null) {
      clips = [];
      json['clips'].forEach((v) {
        clips.add(v);
      });
    }
    if (json['vinyls'] != null) {
      vinyls = [];
      json['vinyls'].forEach((v) {
        vinyls.add(v);
      });
    }
    hasPromotions = json['hasPromotions'];
    if (json['tracksInChart'] != null) {
      tracksInChart = [];
      json['tracksInChart'].forEach((v) {
        tracksInChart.add(TracksInChart.fromJson(v));
      });
    }
    if (json['lastReleases'] != null) {
      lastReleases = [];
      json['lastReleases'].forEach((v) {
        lastReleases.add(MAlbum.fromJson(v));
      });
    }
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
    customWave = json['customWave'] != null ? MCustomWave.fromJson(json['customWave']) : null;
    if (json['playlistIds'] != null) {
      playlistIds = [];
      json['playlistIds'].forEach((v) {
        playlistIds.add(PlaylistIds.fromJson(v));
      });
    }
    if (json['playlists'] != null) {
      playlists = [];
      json['playlists'].forEach((v) {
        playlists.add(MPlaylist.fromJson(v));
      });
    }
  }
  ArtistInfo artist;
  List<MAlbum> albums;
  List<MAlbum> alsoAlbums;
  List<num> lastReleaseIds;
  List<MTrack> popularTracks;
  List<SimilarArtists> similarArtists;
  List<AllCovers> allCovers;
  List<Concerts> concerts;
  List<Videos> videos;
  List<dynamic> clips;
  List<dynamic> vinyls;
  bool hasPromotions;
  List<TracksInChart> tracksInChart;
  List<MAlbum> lastReleases;
  Stats stats;
  MCustomWave customWave;
  List<PlaylistIds> playlistIds;
  List<MPlaylist> playlists;
MPageArtist copyWith({  ArtistInfo artist,
  List<MAlbum> albums,
  List<MAlbum> alsoAlbums,
  List<num> lastReleaseIds,
  List<MTrack> popularTracks,
  List<SimilarArtists> similarArtists,
  List<AllCovers> allCovers,
  List<Concerts> concerts,
  List<Videos> videos,
  List<dynamic> clips,
  List<dynamic> vinyls,
  bool hasPromotions,
  List<TracksInChart> tracksInChart,
  List<MTrack> lastReleases,
  Stats stats,
  MCustomWave customWave,
  List<PlaylistIds> playlistIds,
  List<MPlaylist> playlists,
}) => MPageArtist(  artist: artist ?? this.artist,
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
  stats: stats ?? this.stats,
  customWave: customWave ?? this.customWave,
  playlistIds: playlistIds ?? this.playlistIds,
  playlists: playlists ?? this.playlists,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (artist != null) {
      map['artist'] = artist.toJson();
    }
    if (albums != null) {
      map['albums'] = albums.map((v) => v.toJson()).toList();
    }
    if (alsoAlbums != null) {
      map['alsoAlbums'] = alsoAlbums.map((v) => v.toJson()).toList();
    }
    map['lastReleaseIds'] = lastReleaseIds;
    if (popularTracks != null) {
      map['popularTracks'] = popularTracks.map((v) => v.toJson()).toList();
    }
    if (similarArtists != null) {
      map['similarArtists'] = similarArtists.map((v) => v.toJson()).toList();
    }
    if (allCovers != null) {
      map['allCovers'] = allCovers.map((v) => v.toJson()).toList();
    }
    if (concerts != null) {
      map['concerts'] = concerts.map((v) => v.toJson()).toList();
    }
    if (videos != null) {
      map['videos'] = videos.map((v) => v.toJson()).toList();
    }
    if (clips != null) {
      map['clips'] = clips.map((v) => v.toJson()).toList();
    }
    if (vinyls != null) {
      map['vinyls'] = vinyls.map((v) => v.toJson()).toList();
    }
    map['hasPromotions'] = hasPromotions;
    if (tracksInChart != null) {
      map['tracksInChart'] = tracksInChart.map((v) => v.toJson()).toList();
    }
    if (lastReleases != null) {
      map['lastReleases'] = lastReleases.map((v) => v.toJson()).toList();
    }
    if (stats != null) {
      map['stats'] = stats.toJson();
    }
    if (customWave != null) {
      map['customWave'] = customWave.toJson();
    }
    if (playlistIds != null) {
      map['playlistIds'] = playlistIds.map((v) => v.toJson()).toList();
    }
    if (playlists != null) {
      map['playlists'] = playlists.map((v) => v.toJson()).toList();
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
  num uid;
  num kind;
PlaylistIds copyWith({  num uid,
  num kind,
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



class Stats {
  Stats({
      this.lastMonthListeners,});

  Stats.fromJson(dynamic json) {
    lastMonthListeners = json['lastMonthListeners'];
  }
  num lastMonthListeners;
Stats copyWith({  num lastMonthListeners,
}) => Stats(  lastMonthListeners: lastMonthListeners ?? this.lastMonthListeners,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lastMonthListeners'] = lastMonthListeners;
    return map;
  }

}


class TracksInChart {
  TracksInChart({
      this.trackId, 
      this.position, 
      this.progress, 
      this.listeners, 
      this.shift,});

  TracksInChart.fromJson(dynamic json) {
    trackId = json['trackId'] != null ? TrackId.fromJson(json['trackId']) : null;
    position = json['position'];
    progress = json['progress'];
    listeners = json['listeners'];
    shift = json['shift'];
  }
  TrackId trackId;
  num position;
  String progress;
  num listeners;
  num shift;
TracksInChart copyWith({  TrackId trackId,
  num position,
  String progress,
  num listeners,
  num shift,
}) => TracksInChart(  trackId: trackId ?? this.trackId,
  position: position ?? this.position,
  progress: progress ?? this.progress,
  listeners: listeners ?? this.listeners,
  shift: shift ?? this.shift,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (trackId != null) {
      map['trackId'] = trackId.toJson();
    }
    map['position'] = position;
    map['progress'] = progress;
    map['listeners'] = listeners;
    map['shift'] = shift;
    return map;
  }

}

class TrackId {
  TrackId({
      this.id,});

  TrackId.fromJson(dynamic json) {
    id = json['id'];
  }
  String id;
TrackId copyWith({  String id,
}) => TrackId(  id: id ?? this.id,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    return map;
  }

}

class Videos {
  Videos({
      this.title, 
      this.cover, 
      this.embedUrl, 
      this.provider, 
      this.providerVideoId,});

  Videos.fromJson(dynamic json) {
    title = json['title'];
    cover = json['cover'];
    embedUrl = json['embedUrl'];
    provider = json['provider'];
    providerVideoId = json['providerVideoId'];
  }
  String title;
  String cover;
  String embedUrl;
  String provider;
  String providerVideoId;
Videos copyWith({  String title,
  String cover,
  String embedUrl,
  String provider,
  String providerVideoId,
}) => Videos(  title: title ?? this.title,
  cover: cover ?? this.cover,
  embedUrl: embedUrl ?? this.embedUrl,
  provider: provider ?? this.provider,
  providerVideoId: providerVideoId ?? this.providerVideoId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['cover'] = cover;
    map['embedUrl'] = embedUrl;
    map['provider'] = provider;
    map['providerVideoId'] = providerVideoId;
    return map;
  }

}

class Concerts {
  Concerts({
      this.artist, 
      this.id, 
      this.concertTitle, 
      this.afishaUrl, 
      this.city, 
      this.place, 
      this.address, 
      this.datetime, 
      this.coordinates, 
      this.map, 
      this.mapUrl, 
      this.hash, 
      this.images, 
      this.contentRating, 
      this.datasessionid,});

  Concerts.fromJson(dynamic json) {
    artist = json['artist'] != null ? ArtistInfo.fromJson(json['artist']) : null;
    id = json['id'];
    concertTitle = json['concertTitle'];
    afishaUrl = json['afishaUrl'];
    city = json['city'];
    place = json['place'];
    address = json['address'];
    datetime = json['datetime'];
    coordinates = json['coordinates'] != null ? json['coordinates'].cast<num>() : [];
    map = json['map'];
    mapUrl = json['mapUrl'];
    hash = json['hash'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    contentRating = json['contentRating'];
    datasessionid = json['data-session-id'];
  }
  ArtistInfo artist;
  String id;
  String concertTitle;
  String afishaUrl;
  String city;
  String place;
  String address;
  String datetime;
  List<num> coordinates;
  String map;
  String mapUrl;
  String hash;
  List<String> images;
  String contentRating;
  String datasessionid;
Concerts copyWith({  ArtistInfo artist,
  String id,
  String concertTitle,
  String afishaUrl,
  String city,
  String place,
  String address,
  String datetime,
  List<num> coordinates,
  String map,
  String mapUrl,
  String hash,
  List<String> images,
  String contentRating,
  String datasessionid,
}) => Concerts(  artist: artist ?? this.artist,
  id: id ?? this.id,
  concertTitle: concertTitle ?? this.concertTitle,
  afishaUrl: afishaUrl ?? this.afishaUrl,
  city: city ?? this.city,
  place: place ?? this.place,
  address: address ?? this.address,
  datetime: datetime ?? this.datetime,
  coordinates: coordinates ?? this.coordinates,
  map: map ?? this.map,
  mapUrl: mapUrl ?? this.mapUrl,
  hash: hash ?? this.hash,
  images: images ?? this.images,
  contentRating: contentRating ?? this.contentRating,
  datasessionid: datasessionid ?? this.datasessionid,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (artist != null) {
      map['artist'] = artist.toJson();
    }
    map['id'] = id;
    map['concertTitle'] = concertTitle;
    map['afishaUrl'] = afishaUrl;
    map['city'] = city;
    map['place'] = place;
    map['address'] = address;
    map['datetime'] = datetime;
    map['coordinates'] = coordinates;
    map['map'] = map;
    map['mapUrl'] = mapUrl;
    map['hash'] = hash;
    map['images'] = images;
    map['contentRating'] = contentRating;
    map['data-session-id'] = datasessionid;
    return map;
  }

}

class ArtistInfo {
  ArtistInfo({
      this.id, 
      this.name, 
      this.various, 
      this.composer, 
      this.cover, 
      this.ogImage, 
      this.genres, 
      this.counts, 
      this.available, 
      this.ratings, 
      this.links, 
      this.ticketsAvailable,});

  ArtistInfo.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    various = json['various'];
    composer = json['composer'];
    cover = json['cover'] != null ? MCover.fromJson(json['cover']) : null;
    ogImage = json['ogImage'];
    genres = json['genres'] != null ? json['genres'].cast<String>() : [];
    counts = json['counts'] != null ? Counts.fromJson(json['counts']) : null;
    available = json['available'];
    ratings = json['ratings'] != null ? Ratings.fromJson(json['ratings']) : null;
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links.add(Links.fromJson(v));
      });
    }
    ticketsAvailable = json['ticketsAvailable'];
  }
  String id;
  String name;
  bool various;
  bool composer;
  MCover cover;
  String ogImage;
  List<String> genres;
  Counts counts;
  bool available;
  Ratings ratings;
  List<Links> links;
  bool ticketsAvailable;
ArtistInfo copyWith({  String id,
  String name,
  bool various,
  bool composer,
  MCover cover,
  String ogImage,
  List<String> genres,
  Counts counts,
  bool available,
  Ratings ratings,
  List<Links> links,
  bool ticketsAvailable,
}) => ArtistInfo(  id: id ?? this.id,
  name: name ?? this.name,
  various: various ?? this.various,
  composer: composer ?? this.composer,
  cover: cover ?? this.cover,
  ogImage: ogImage ?? this.ogImage,
  genres: genres ?? this.genres,
  counts: counts ?? this.counts,
  available: available ?? this.available,
  ratings: ratings ?? this.ratings,
  links: links ?? this.links,
  ticketsAvailable: ticketsAvailable ?? this.ticketsAvailable,
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
    map['ogImage'] = ogImage;
    map['genres'] = genres;
    if (counts != null) {
      map['counts'] = counts.toJson();
    }
    map['available'] = available;
    if (ratings != null) {
      map['ratings'] = ratings.toJson();
    }
    if (links != null) {
      map['links'] = links.map((v) => v.toJson()).toList();
    }
    map['ticketsAvailable'] = ticketsAvailable;
    return map;
  }

}

class Links {
  Links({
      this.title, 
      this.href, 
      this.type, 
      this.socialNetwork,});

  Links.fromJson(dynamic json) {
    title = json['title'];
    href = json['href'];
    type = json['type'];
    socialNetwork = json['socialNetwork'];
  }
  String title;
  String href;
  String type;
  String socialNetwork;
Links copyWith({  String title,
  String href,
  String type,
  String socialNetwork,
}) => Links(  title: title ?? this.title,
  href: href ?? this.href,
  type: type ?? this.type,
  socialNetwork: socialNetwork ?? this.socialNetwork,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['href'] = href;
    map['type'] = type;
    map['socialNetwork'] = socialNetwork;
    return map;
  }

}

class Ratings {
  Ratings({
      this.week, 
      this.month, 
      this.day,});

  Ratings.fromJson(dynamic json) {
    week = json['week'];
    month = json['month'];
    day = json['day'];
  }
  num week;
  num month;
  num day;
Ratings copyWith({  num week,
  num month,
  num day,
}) => Ratings(  week: week ?? this.week,
  month: month ?? this.month,
  day: day ?? this.day,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['week'] = week;
    map['month'] = month;
    map['day'] = day;
    return map;
  }

}

class Counts {
  Counts({
      this.tracks, 
      this.directAlbums, 
      this.alsoAlbums, 
      this.alsoTracks,});

  Counts.fromJson(dynamic json) {
    tracks = json['tracks'];
    directAlbums = json['directAlbums'];
    alsoAlbums = json['alsoAlbums'];
    alsoTracks = json['alsoTracks'];
  }
  num tracks;
  num directAlbums;
  num alsoAlbums;
  num alsoTracks;
Counts copyWith({  num tracks,
  num directAlbums,
  num alsoAlbums,
  num alsoTracks,
}) => Counts(  tracks: tracks ?? this.tracks,
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

class AllCovers {
  AllCovers({
      this.type, 
      this.uri, 
      this.prefix,});

  AllCovers.fromJson(dynamic json) {
    type = json['type'];
    uri = json['uri'];
    prefix = json['prefix'];
  }
  String type;
  String uri;
  String prefix;
AllCovers copyWith({  String type,
  String uri,
  String prefix,
}) => AllCovers(  type: type ?? this.type,
  uri: uri ?? this.uri,
  prefix: prefix ?? this.prefix,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['uri'] = uri;
    map['prefix'] = prefix;
    return map;
  }

}

class SimilarArtists {
  SimilarArtists({
      this.id, 
      this.name, 
      this.cover, 
      this.various, 
      this.composer, 
      this.available, 
      this.genres, 
      this.counts, 
      this.ticketsAvailable,});

  SimilarArtists.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    cover = json['cover'] != null ? MCover.fromJson(json['cover']) : null;
    various = json['various'];
    composer = json['composer'];
    available = json['available'];
    genres = json['genres'] != null ? json['genres'].cast<String>() : [];
    counts = json['counts'] != null ? Counts.fromJson(json['counts']) : null;
    ticketsAvailable = json['ticketsAvailable'];
  }
  num id;
  String name;
  MCover cover;
  bool various;
  bool composer;
  bool available;
  List<String> genres;
  Counts counts;
  bool ticketsAvailable;
SimilarArtists copyWith({  num id,
  String name,
  MCover cover,
  bool various,
  bool composer,
  bool available,
  List<String> genres,
  Counts counts,
  bool ticketsAvailable,
}) => SimilarArtists(  id: id ?? this.id,
  name: name ?? this.name,
  cover: cover ?? this.cover,
  various: various ?? this.various,
  composer: composer ?? this.composer,
  available: available ?? this.available,
  genres: genres ?? this.genres,
  counts: counts ?? this.counts,
  ticketsAvailable: ticketsAvailable ?? this.ticketsAvailable,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (cover != null) {
      map['cover'] = cover.toJson();
    }
    map['various'] = various;
    map['composer'] = composer;
    map['available'] = available;
    map['genres'] = genres;
    if (counts != null) {
      map['counts'] = counts.toJson();
    }
    map['ticketsAvailable'] = ticketsAvailable;
    return map;
  }

}

class LyricsInfo {
  LyricsInfo({
      this.hasAvailableSyncLyrics, 
      this.hasAvailableTextLyrics,});

  LyricsInfo.fromJson(dynamic json) {
    hasAvailableSyncLyrics = json['hasAvailableSyncLyrics'];
    hasAvailableTextLyrics = json['hasAvailableTextLyrics'];
  }
  bool hasAvailableSyncLyrics;
  bool hasAvailableTextLyrics;
LyricsInfo copyWith({  bool hasAvailableSyncLyrics,
  bool hasAvailableTextLyrics,
}) => LyricsInfo(  hasAvailableSyncLyrics: hasAvailableSyncLyrics ?? this.hasAvailableSyncLyrics,
  hasAvailableTextLyrics: hasAvailableTextLyrics ?? this.hasAvailableTextLyrics,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hasAvailableSyncLyrics'] = hasAvailableSyncLyrics;
    map['hasAvailableTextLyrics'] = hasAvailableTextLyrics;
    return map;
  }

}

class Artist {
  Artist({
      this.id, 
      this.name, 
      this.various, 
      this.composer, 
      this.cover, 
      this.ogImage, 
      this.genres, 
      this.counts, 
      this.available, 
      this.ratings, 
      this.links, 
      this.ticketsAvailable, 
      this.likesCount, 
      this.fullNames, 
      this.description, 
      this.countries, 
      this.initDate, 
      this.dbAliases,});

  Artist.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    various = json['various'];
    composer = json['composer'];
    cover = json['cover'] != null ? MCover.fromJson(json['cover']) : null;
    ogImage = json['ogImage'];
    genres = json['genres'] != null ? json['genres'].cast<String>() : [];
    counts = json['counts'] != null ? Counts.fromJson(json['counts']) : null;
    available = json['available'];
    ratings = json['ratings'] != null ? Ratings.fromJson(json['ratings']) : null;
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links.add(Links.fromJson(v));
      });
    }
    ticketsAvailable = json['ticketsAvailable'];
    likesCount = json['likesCount'];
    fullNames = json['fullNames'] != null ? json['fullNames'].cast<String>() : [];
    description = json['description'] != null ? Description.fromJson(json['description']) : null;
    countries = json['countries'] != null ? json['countries'].cast<String>() : [];
    initDate = json['initDate'];
    dbAliases = json['dbAliases'] != null ? json['dbAliases'].cast<String>() : [];
  }
  String id;
  String name;
  bool various;
  bool composer;
  MCover cover;
  String ogImage;
  List<String> genres;
  Counts counts;
  bool available;
  Ratings ratings;
  List<Links> links;
  bool ticketsAvailable;
  num likesCount;
  List<String> fullNames;
  Description description;
  List<String> countries;
  String initDate;
  List<String> dbAliases;
ArtistInfo copyWith({  String id,
  String name,
  bool various,
  bool composer,
  MCover cover,
  String ogImage,
  List<String> genres,
  Counts counts,
  bool available,
  Ratings ratings,
  List<Links> links,
  bool ticketsAvailable,
  num likesCount,
  List<String> fullNames,
  Description description,
  List<String> countries,
  String initDate,
  List<String> dbAliases,
}) => ArtistInfo(  id: id ?? this.id,
  name: name ?? this.name,
  various: various ?? this.various,
  composer: composer ?? this.composer,
  cover: cover ?? this.cover,
  ogImage: ogImage ?? this.ogImage,
  genres: genres ?? this.genres,
  counts: counts ?? this.counts,
  available: available ?? this.available,
  ratings: ratings ?? this.ratings,
  links: links ?? this.links,
  ticketsAvailable: ticketsAvailable ?? this.ticketsAvailable,
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
    map['ogImage'] = ogImage;
    map['genres'] = genres;
    if (counts != null) {
      map['counts'] = counts.toJson();
    }
    map['available'] = available;
    if (ratings != null) {
      map['ratings'] = ratings.toJson();
    }
    if (links != null) {
      map['links'] = links.map((v) => v.toJson()).toList();
    }
    map['ticketsAvailable'] = ticketsAvailable;
    map['likesCount'] = likesCount;
    map['fullNames'] = fullNames;
    if (description != null) {
      map['description'] = description.toJson();
    }
    map['countries'] = countries;
    map['initDate'] = initDate;
    map['dbAliases'] = dbAliases;
    return map;
  }

}

class Description {
  Description({
      this.text, 
      this.uri,});

  Description.fromJson(dynamic json) {
    text = json['text'];
    uri = json['uri'];
  }
  String text;
  String uri;
Description copyWith({  String text,
  String uri,
}) => Description(  text: text ?? this.text,
  uri: uri ?? this.uri,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['uri'] = uri;
    return map;
  }

}