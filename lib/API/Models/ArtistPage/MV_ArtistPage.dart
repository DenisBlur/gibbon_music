class MvArtistPage {
  MvArtistPage({
    this.artist,
    this.albums,
    this.alsoAlbums,
    this.lastReleaseIds,
    this.popularTracks,
    this.similarArtists,
    this.allCovers,
    this.concerts,
    this.videos,
    this.hasPromotions,
    this.tracksInChart,
    this.lastReleases,
    this.stats,
    this.customWave,
    this.playlistIds,
    this.playlists,
  });

  MvArtistPage.fromJson(dynamic json) {
    artist = json['artist'] != null ? Artist.fromJson(json['artist']) : null;
    if (json['albums'] != null) {
      albums = [];
      json['albums'].forEach((v) {
        albums.add(Albums.fromJson(v));
      });
    }
    if (json['alsoAlbums'] != null) {
      alsoAlbums = [];
      json['alsoAlbums'].forEach((v) {
        alsoAlbums.add(AlsoAlbums.fromJson(v));
      });
    }
    lastReleaseIds = json['lastReleaseIds'] != null
        ? json['lastReleaseIds'].cast<num>()
        : [];
    if (json['popularTracks'] != null) {
      popularTracks = [];
      json['popularTracks'].forEach((v) {
        popularTracks.add(Track.fromJson(v));
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
        lastReleases.add(LastReleases.fromJson(v));
      });
    }
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
    customWave = json['customWave'] != null
        ? CustomWave.fromJson(json['customWave'])
        : null;
    if (json['playlistIds'] != null) {
      playlistIds = [];
      json['playlistIds'].forEach((v) {
        playlistIds.add(PlaylistIds.fromJson(v));
      });
    }
    if (json['playlists'] != null) {
      playlists = [];
      json['playlists'].forEach((v) {
        playlists.add(Playlists.fromJson(v));
      });
    }
  }

  Artist artist;
  List<Albums> albums;
  List<AlsoAlbums> alsoAlbums;
  List<num> lastReleaseIds;
  List<Track> popularTracks;
  List<SimilarArtists> similarArtists;
  List<AllCovers> allCovers;
  List<Concerts> concerts;
  List<Videos> videos;
  bool hasPromotions;
  List<TracksInChart> tracksInChart;
  List<LastReleases> lastReleases;
  Stats stats;
  CustomWave customWave;
  List<PlaylistIds> playlistIds;
  List<Playlists> playlists;

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

class Playlists {
  Playlists({
    this.uid,
    this.kind,
    this.title,
    this.description,
    this.descriptionFormatted,
    this.cover,
    this.trackCount,
  });

  Playlists.fromJson(dynamic json) {
    uid = json['uid'];
    kind = json['kind'];
    title = json['title'];
    description = json['description'];
    descriptionFormatted = json['descriptionFormatted'];
    cover = json['cover'] != null ? Cover.fromJson(json['cover']) : null;
    trackCount = json['trackCount'];
  }

  num uid;
  num kind;
  String title;
  String description;
  String descriptionFormatted;
  Cover cover;
  num trackCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = uid;
    map['kind'] = kind;
    map['title'] = title;
    map['description'] = description;
    map['descriptionFormatted'] = descriptionFormatted;
    if (cover != null) {
      map['cover'] = cover.toJson();
    }
    map['trackCount'] = trackCount;
    return map;
  }
}

class Cover {
  Cover({
    this.type,
    this.uri,
    this.custom,
  });

  Cover.fromJson(dynamic json) {
    type = json['type'];
    uri = json['uri'];
    custom = json['custom'];
  }

  String type;
  String uri;
  bool custom;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['uri'] = uri;
    map['custom'] = custom;
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

  num uid;
  num kind;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = uid;
    map['kind'] = kind;
    return map;
  }
}

class CustomWave {
  CustomWave({
    this.title,
    this.animationUrl,
  });

  CustomWave.fromJson(dynamic json) {
    title = json['title'];
    animationUrl = json['animationUrl'];
  }

  String title;
  String animationUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['animationUrl'] = animationUrl;
    return map;
  }
}

class Stats {
  Stats({
    this.lastMonthListeners,
  });

  Stats.fromJson(dynamic json) {
    lastMonthListeners = json['lastMonthListeners'];
  }

  num lastMonthListeners;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lastMonthListeners'] = lastMonthListeners;
    return map;
  }
}

class LastReleases {
  LastReleases({
    this.id,
    this.title,
    this.metaType,
    this.version,
    this.year,
    this.releaseDate,
    this.coverUri,
    this.ogImage,
    this.genre,
    this.trackCount,
    this.likesCount,
    this.recent,
    this.veryImportant,
    this.artists,
    this.labels,
    this.available,
    this.availableForPremiumUsers,
    this.availableForOptions,
    this.availableForMobile,
    this.availablePartially,
    this.bests,
  });

  LastReleases.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    metaType = json['metaType'];
    version = json['version'];
    year = json['year'];
    releaseDate = json['releaseDate'];
    coverUri = json['coverUri'];
    ogImage = json['ogImage'];
    genre = json['genre'];
    trackCount = json['trackCount'];
    likesCount = json['likesCount'];
    recent = json['recent'];
    veryImportant = json['veryImportant'];
    if (json['artists'] != null) {
      artists = [];
      json['artists'].forEach((v) {
        artists.add(Artists.fromJson(v));
      });
    }
    if (json['labels'] != null) {
      labels = [];
      json['labels'].forEach((v) {
        labels.add(Labels.fromJson(v));
      });
    }
    available = json['available'];
    availableForPremiumUsers = json['availableForPremiumUsers'];
    availableForOptions = json['availableForOptions'] != null
        ? json['availableForOptions'].cast<String>()
        : [];
    availableForMobile = json['availableForMobile'];
    availablePartially = json['availablePartially'];
    bests = json['bests'] != null ? json['bests'].cast<num>() : [];
  }

  num id;
  String title;
  String metaType;
  String version;
  num year;
  String releaseDate;
  String coverUri;
  String ogImage;
  String genre;
  num trackCount;
  num likesCount;
  bool recent;
  bool veryImportant;
  List<Artists> artists;
  List<Labels> labels;
  bool available;
  bool availableForPremiumUsers;
  List<String> availableForOptions;
  bool availableForMobile;
  bool availablePartially;
  List<num> bests;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['metaType'] = metaType;
    map['version'] = version;
    map['year'] = year;
    map['releaseDate'] = releaseDate;
    map['coverUri'] = coverUri;
    map['ogImage'] = ogImage;
    map['genre'] = genre;
    map['trackCount'] = trackCount;
    map['likesCount'] = likesCount;
    map['recent'] = recent;
    map['veryImportant'] = veryImportant;
    if (artists != null) {
      map['artists'] = artists.map((v) => v.toJson()).toList();
    }
    if (labels != null) {
      map['labels'] = labels.map((v) => v.toJson()).toList();
    }
    map['available'] = available;
    map['availableForPremiumUsers'] = availableForPremiumUsers;
    map['availableForOptions'] = availableForOptions;
    map['availableForMobile'] = availableForMobile;
    map['availablePartially'] = availablePartially;
    map['bests'] = bests;
    return map;
  }
}

class Labels {
  Labels({
    this.id,
    this.name,
  });

  Labels.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  num id;
  String name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}

class Artists {
  Artists({
    this.id,
    this.name,
    this.various,
    this.composer,
    this.cover,
    this.genres,
  });

  Artists.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    various = json['various'];
    composer = json['composer'];
    cover = json['cover'] != null ? Cover.fromJson(json['cover']) : null;
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
  Cover cover;
  List<dynamic> genres;

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

class TracksInChart {
  TracksInChart({
    this.trackId,
    this.position,
    this.progress,
    this.listeners,
    this.shift,
  });

  TracksInChart.fromJson(dynamic json) {
    trackId =
        json['trackId'] != null ? TrackId.fromJson(json['trackId']) : null;
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
    this.id,
  });

  TrackId.fromJson(dynamic json) {
    id = json['id'];
  }

  String id;

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
    this.providerVideoId,
  });

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
    this.datasessionid,
  });

  Concerts.fromJson(dynamic json) {
    artist = json['artist'] != null ? Artist.fromJson(json['artist']) : null;
    id = json['id'];
    concertTitle = json['concertTitle'];
    afishaUrl = json['afishaUrl'];
    city = json['city'];
    place = json['place'];
    address = json['address'];
    datetime = json['datetime'];
    coordinates =
        json['coordinates'] != null ? json['coordinates'].cast<num>() : [];
    map = json['map'];
    mapUrl = json['mapUrl'];
    hash = json['hash'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    contentRating = json['contentRating'];
    datasessionid = json['data-session-id'];
  }

  Artist artist;
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
  });

  Artist.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    various = json['various'];
    composer = json['composer'];
    cover = json['cover'] != null ? Cover.fromJson(json['cover']) : null;
    ogImage = json['ogImage'];
    genres = json['genres'] != null ? json['genres'].cast<String>() : [];
    counts = json['counts'] != null ? Counts.fromJson(json['counts']) : null;
    available = json['available'];
    ratings =
        json['ratings'] != null ? Ratings.fromJson(json['ratings']) : null;
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
  Cover cover;
  String ogImage;
  List<String> genres;
  Counts counts;
  bool available;
  Ratings ratings;
  List<Links> links;
  bool ticketsAvailable;

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
    this.socialNetwork,
  });

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
    this.day,
  });

  Ratings.fromJson(dynamic json) {
    week = json['week'];
    month = json['month'];
    day = json['day'];
  }

  num week;
  num month;
  num day;

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
    this.alsoTracks,
  });

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
    this.prefix,
  });

  AllCovers.fromJson(dynamic json) {
    type = json['type'];
    uri = json['uri'];
    prefix = json['prefix'];
  }

  String type;
  String uri;
  String prefix;

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
    this.ticketsAvailable,
  });

  SimilarArtists.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    cover = json['cover'] != null ? Cover.fromJson(json['cover']) : null;
    various = json['various'];
    composer = json['composer'];
    available = json['available'];
    genres = json['genres'] != null ? json['genres'].cast<String>() : [];
    counts = json['counts'] != null ? Counts.fromJson(json['counts']) : null;
    ticketsAvailable = json['ticketsAvailable'];
  }

  num id;
  String name;
  Cover cover;
  bool various;
  bool composer;
  bool available;
  List<String> genres;
  Counts counts;
  bool ticketsAvailable;

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

class Track {
  Track({
    this.id,
    this.realId,
    this.title,
    this.major,
    this.available,
    this.availableForPremiumUsers,
    this.availableFullWithoutPermission,
    this.availableForOptions,
    this.storageDir,
    this.durationMs,
    this.fileSize,
    this.r128,
    this.previewDurationMs,
    this.artists,
    this.albums,
    this.coverUri,
    this.ogImage,
    this.lyricsAvailable,
    this.type,
    this.rememberPosition,
    this.trackSharingFlag,
    this.lyricsInfo,
    this.trackSource,
  });

  Track.fromJson(dynamic json) {
    id = json['id'];
    realId = json['realId'];
    title = json['title'];
    major = json['major'] != null ? Major.fromJson(json['major']) : null;
    available = json['available'];
    availableForPremiumUsers = json['availableForPremiumUsers'];
    availableFullWithoutPermission = json['availableFullWithoutPermission'];
    availableForOptions = json['availableForOptions'] != null
        ? json['availableForOptions'].cast<String>()
        : [];
    storageDir = json['storageDir'];
    durationMs = json['durationMs'];
    fileSize = json['fileSize'];
    r128 = json['r128'] != null ? R128.fromJson(json['r128']) : null;
    previewDurationMs = json['previewDurationMs'];
    if (json['artists'] != null) {
      artists = [];
      json['artists'].forEach((v) {
        artists.add(Artists.fromJson(v));
      });
    }
    if (json['albums'] != null) {
      albums = [];
      json['albums'].forEach((v) {
        albums.add(Albums.fromJson(v));
      });
    }
    coverUri = json['coverUri'];
    ogImage = json['ogImage'];
    lyricsAvailable = json['lyricsAvailable'];
    type = json['type'];
    rememberPosition = json['rememberPosition'];
    trackSharingFlag = json['trackSharingFlag'];
    lyricsInfo = json['lyricsInfo'] != null
        ? LyricsInfo.fromJson(json['lyricsInfo'])
        : null;
    trackSource = json['trackSource'];
  }

  String id;
  String realId;
  String title;
  Major major;
  bool available;
  bool availableForPremiumUsers;
  bool availableFullWithoutPermission;
  List<String> availableForOptions;
  String storageDir;
  num durationMs;
  num fileSize;
  R128 r128;
  num previewDurationMs;
  List<Artists> artists;
  List<Albums> albums;
  String coverUri;
  String ogImage;
  bool lyricsAvailable;
  String type;
  bool rememberPosition;
  String trackSharingFlag;
  LyricsInfo lyricsInfo;
  String trackSource;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['realId'] = realId;
    map['title'] = title;
    if (major != null) {
      map['major'] = major.toJson();
    }
    map['available'] = available;
    map['availableForPremiumUsers'] = availableForPremiumUsers;
    map['availableFullWithoutPermission'] = availableFullWithoutPermission;
    map['availableForOptions'] = availableForOptions;
    map['storageDir'] = storageDir;
    map['durationMs'] = durationMs;
    map['fileSize'] = fileSize;
    if (r128 != null) {
      map['r128'] = r128.toJson();
    }
    map['previewDurationMs'] = previewDurationMs;
    if (artists != null) {
      map['artists'] = artists.map((v) => v.toJson()).toList();
    }
    if (albums != null) {
      map['albums'] = albums.map((v) => v.toJson()).toList();
    }
    map['coverUri'] = coverUri;
    map['ogImage'] = ogImage;
    map['lyricsAvailable'] = lyricsAvailable;
    map['type'] = type;
    map['rememberPosition'] = rememberPosition;
    map['trackSharingFlag'] = trackSharingFlag;
    if (lyricsInfo != null) {
      map['lyricsInfo'] = lyricsInfo.toJson();
    }
    map['trackSource'] = trackSource;
    return map;
  }
}

class LyricsInfo {
  LyricsInfo({
    this.hasAvailableSyncLyrics,
    this.hasAvailableTextLyrics,
  });

  LyricsInfo.fromJson(dynamic json) {
    hasAvailableSyncLyrics = json['hasAvailableSyncLyrics'];
    hasAvailableTextLyrics = json['hasAvailableTextLyrics'];
  }

  bool hasAvailableSyncLyrics;
  bool hasAvailableTextLyrics;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hasAvailableSyncLyrics'] = hasAvailableSyncLyrics;
    map['hasAvailableTextLyrics'] = hasAvailableTextLyrics;
    return map;
  }
}

class Albums {
  Albums({
    this.id,
    this.title,
    this.metaType,
    this.version,
    this.year,
    this.releaseDate,
    this.coverUri,
    this.ogImage,
    this.genre,
    this.trackCount,
    this.likesCount,
    this.recent,
    this.veryImportant,
    this.artists,
    this.labels,
    this.available,
    this.availableForPremiumUsers,
    this.availableForOptions,
    this.availableForMobile,
    this.availablePartially,
    this.bests,
    this.trackPosition,
  });

  Albums.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    metaType = json['metaType'];
    version = json['version'];
    year = json['year'];
    releaseDate = json['releaseDate'];
    coverUri = json['coverUri'];
    ogImage = json['ogImage'];
    genre = json['genre'];
    trackCount = json['trackCount'];
    likesCount = json['likesCount'];
    recent = json['recent'];
    veryImportant = json['veryImportant'];
    if (json['artists'] != null) {
      artists = [];
      json['artists'].forEach((v) {
        artists.add(Artists.fromJson(v));
      });
    }
    if (json['labels'] != null) {
      labels = [];
      json['labels'].forEach((v) {
        labels.add(Labels.fromJson(v));
      });
    }
    available = json['available'];
    availableForPremiumUsers = json['availableForPremiumUsers'];
    availableForOptions = json['availableForOptions'] != null
        ? json['availableForOptions'].cast<String>()
        : [];
    availableForMobile = json['availableForMobile'];
    availablePartially = json['availablePartially'];
    bests = json['bests'] != null ? json['bests'].cast<num>() : [];
    trackPosition = json['trackPosition'] != null
        ? TrackPosition.fromJson(json['trackPosition'])
        : null;
  }

  num id;
  String title;
  String metaType;
  String version;
  num year;
  String releaseDate;
  String coverUri;
  String ogImage;
  String genre;
  num trackCount;
  num likesCount;
  bool recent;
  bool veryImportant;
  List<Artists> artists;
  List<Labels> labels;
  bool available;
  bool availableForPremiumUsers;
  List<String> availableForOptions;
  bool availableForMobile;
  bool availablePartially;
  List<num> bests;
  TrackPosition trackPosition;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['metaType'] = metaType;
    map['version'] = version;
    map['year'] = year;
    map['releaseDate'] = releaseDate;
    map['coverUri'] = coverUri;
    map['ogImage'] = ogImage;
    map['genre'] = genre;
    map['trackCount'] = trackCount;
    map['likesCount'] = likesCount;
    map['recent'] = recent;
    map['veryImportant'] = veryImportant;
    if (artists != null) {
      map['artists'] = artists.map((v) => v.toJson()).toList();
    }
    if (labels != null) {
      map['labels'] = labels.map((v) => v.toJson()).toList();
    }
    map['available'] = available;
    map['availableForPremiumUsers'] = availableForPremiumUsers;
    map['availableForOptions'] = availableForOptions;
    map['availableForMobile'] = availableForMobile;
    map['availablePartially'] = availablePartially;
    map['bests'] = bests;
    if (trackPosition != null) {
      map['trackPosition'] = trackPosition.toJson();
    }
    return map;
  }
}

class TrackPosition {
  TrackPosition({
    this.volume,
    this.index,
  });

  TrackPosition.fromJson(dynamic json) {
    volume = json['volume'];
    index = json['index'];
  }

  num volume;
  num index;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['volume'] = volume;
    map['index'] = index;
    return map;
  }
}

class R128 {
  R128({
    this.i,
    this.tp,
  });

  R128.fromJson(dynamic json) {
    i = json['i'];
    tp = json['tp'];
  }

  num i;
  num tp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['i'] = i;
    map['tp'] = tp;
    return map;
  }
}

class Major {
  Major({
    this.id,
    this.name,
  });

  Major.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  num id;
  String name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}

class AlsoAlbums {
  AlsoAlbums({
    this.id,
    this.title,
    this.type,
    this.metaType,
    this.contentWarning,
    this.year,
    this.releaseDate,
    this.coverUri,
    this.ogImage,
    this.genre,
    this.trackCount,
    this.likesCount,
    this.recent,
    this.veryImportant,
    this.artists,
    this.labels,
    this.available,
    this.availableForPremiumUsers,
    this.availableForOptions,
    this.availableForMobile,
    this.availablePartially,
    this.bests,
  });

  AlsoAlbums.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    metaType = json['metaType'];
    contentWarning = json['contentWarning'];
    year = json['year'];
    releaseDate = json['releaseDate'];
    coverUri = json['coverUri'];
    ogImage = json['ogImage'];
    genre = json['genre'];
    trackCount = json['trackCount'];
    likesCount = json['likesCount'];
    recent = json['recent'];
    veryImportant = json['veryImportant'];
    if (json['artists'] != null) {
      artists = [];
      json['artists'].forEach((v) {
        artists.add(Artists.fromJson(v));
      });
    }
    if (json['labels'] != null) {
      labels = [];
      json['labels'].forEach((v) {
        labels.add(Labels.fromJson(v));
      });
    }
    available = json['available'];
    availableForPremiumUsers = json['availableForPremiumUsers'];
    availableForOptions = json['availableForOptions'] != null
        ? json['availableForOptions'].cast<String>()
        : [];
    availableForMobile = json['availableForMobile'];
    availablePartially = json['availablePartially'];
    bests = json['bests'] != null ? json['bests'].cast<num>() : [];
  }

  num id;
  String title;
  String type;
  String metaType;
  String contentWarning;
  num year;
  String releaseDate;
  String coverUri;
  String ogImage;
  String genre;
  num trackCount;
  num likesCount;
  bool recent;
  bool veryImportant;
  List<Artists> artists;
  List<Labels> labels;
  bool available;
  bool availableForPremiumUsers;
  List<String> availableForOptions;
  bool availableForMobile;
  bool availablePartially;
  List<num> bests;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['type'] = type;
    map['metaType'] = metaType;
    map['contentWarning'] = contentWarning;
    map['year'] = year;
    map['releaseDate'] = releaseDate;
    map['coverUri'] = coverUri;
    map['ogImage'] = ogImage;
    map['genre'] = genre;
    map['trackCount'] = trackCount;
    map['likesCount'] = likesCount;
    map['recent'] = recent;
    map['veryImportant'] = veryImportant;
    if (artists != null) {
      map['artists'] = artists.map((v) => v.toJson()).toList();
    }
    if (labels != null) {
      map['labels'] = labels.map((v) => v.toJson()).toList();
    }
    map['available'] = available;
    map['availableForPremiumUsers'] = availableForPremiumUsers;
    map['availableForOptions'] = availableForOptions;
    map['availableForMobile'] = availableForMobile;
    map['availablePartially'] = availablePartially;
    map['bests'] = bests;
    return map;
  }
}

class Duplicates {
  Duplicates({
    this.id,
    this.title,
    this.metaType,
    this.year,
    this.releaseDate,
    this.coverUri,
    this.ogImage,
    this.genre,
    this.trackCount,
    this.likesCount,
    this.recent,
    this.veryImportant,
    this.artists,
    this.labels,
    this.available,
    this.availableForPremiumUsers,
    this.availableForOptions,
    this.availableForMobile,
    this.availablePartially,
    this.bests,
  });

  Duplicates.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    metaType = json['metaType'];
    year = json['year'];
    releaseDate = json['releaseDate'];
    coverUri = json['coverUri'];
    ogImage = json['ogImage'];
    genre = json['genre'];
    trackCount = json['trackCount'];
    likesCount = json['likesCount'];
    recent = json['recent'];
    veryImportant = json['veryImportant'];
    if (json['artists'] != null) {
      artists = [];
      json['artists'].forEach((v) {
        artists.add(Artists.fromJson(v));
      });
    }
    if (json['labels'] != null) {
      labels = [];
      json['labels'].forEach((v) {
        labels.add(Labels.fromJson(v));
      });
    }
    available = json['available'];
    availableForPremiumUsers = json['availableForPremiumUsers'];
    availableForOptions = json['availableForOptions'] != null
        ? json['availableForOptions'].cast<String>()
        : [];
    availableForMobile = json['availableForMobile'];
    availablePartially = json['availablePartially'];
    bests = json['bests'] != null ? json['bests'].cast<num>() : [];
  }

  num id;
  String title;
  String metaType;
  num year;
  String releaseDate;
  String coverUri;
  String ogImage;
  String genre;
  num trackCount;
  num likesCount;
  bool recent;
  bool veryImportant;
  List<Artists> artists;
  List<Labels> labels;
  bool available;
  bool availableForPremiumUsers;
  List<String> availableForOptions;
  bool availableForMobile;
  bool availablePartially;
  List<num> bests;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['metaType'] = metaType;
    map['year'] = year;
    map['releaseDate'] = releaseDate;
    map['coverUri'] = coverUri;
    map['ogImage'] = ogImage;
    map['genre'] = genre;
    map['trackCount'] = trackCount;
    map['likesCount'] = likesCount;
    map['recent'] = recent;
    map['veryImportant'] = veryImportant;
    if (artists != null) {
      map['artists'] = artists.map((v) => v.toJson()).toList();
    }
    if (labels != null) {
      map['labels'] = labels.map((v) => v.toJson()).toList();
    }
    map['available'] = available;
    map['availableForPremiumUsers'] = availableForPremiumUsers;
    map['availableForOptions'] = availableForOptions;
    map['availableForMobile'] = availableForMobile;
    map['availablePartially'] = availablePartially;
    map['bests'] = bests;
    return map;
  }
}

class Description {
  Description({
    this.text,
    this.uri,
  });

  Description.fromJson(dynamic json) {
    text = json['text'];
    uri = json['uri'];
  }

  String text;
  String uri;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['uri'] = uri;
    return map;
  }
}
