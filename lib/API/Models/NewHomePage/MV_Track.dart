class MvTrack {
  MvTrack({
      this.track, 
      this.chart,});

  MvTrack.fromJson(dynamic json) {
    track = json['track'] != null ? Track.fromJson(json['track']) : null;
    chart = json['chart'] != null ? Chart.fromJson(json['chart']) : null;
  }
  Track track;
  Chart chart;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (track != null) {
      map['track'] = track.toJson();
    }
    if (chart != null) {
      map['chart'] = chart.toJson();
    }
    return map;
  }

}

class Chart {
  Chart({
      this.position, 
      this.progress, 
      this.listeners, 
      this.shift,});

  Chart.fromJson(dynamic json) {
    position = json['position'];
    progress = json['progress'];
    listeners = json['listeners'];
    shift = json['shift'];
  }
  num position;
  String progress;
  num listeners;
  num shift;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['position'] = position;
    map['progress'] = progress;
    map['listeners'] = listeners;
    map['shift'] = shift;
    return map;
  }

}

class Track {
  Track({
      this.id, 
      this.realId, 
      this.trackSource, 
      this.title, 
      this.major, 
      this.available, 
      this.availableForPremiumUsers, 
      this.availableFullWithoutPermission, 
      this.availableForOptions, 
      this.type, 
      this.rememberPosition, 
      this.durationMs, 
      this.storageDir, 
      this.fileSize, 
      this.previewDurationMs, 
      this.r128, 
      this.artists, 
      this.albums, 
      this.coverUri, 
      this.ogImage, 
      this.lyricsAvailable,});

  Track.fromJson(dynamic json) {
    id = json['id'];
    realId = json['realId'];
    trackSource = json['trackSource'];
    title = json['title'];
    major = json['major'] != null ? Major.fromJson(json['major']) : null;
    available = json['available'];
    availableForPremiumUsers = json['availableForPremiumUsers'];
    availableFullWithoutPermission = json['availableFullWithoutPermission'];
    availableForOptions = json['availableForOptions'] != null ? json['availableForOptions'].cast<String>() : [];
    type = json['type'];
    rememberPosition = json['rememberPosition'];
    durationMs = json['durationMs'];
    storageDir = json['storageDir'];
    fileSize = json['fileSize'];
    previewDurationMs = json['previewDurationMs'];
    r128 = json['r128'] != null ? R128.fromJson(json['r128']) : null;
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
  }
  String id;
  String realId;
  String trackSource;
  String title;
  Major major;
  bool available;
  bool availableForPremiumUsers;
  bool availableFullWithoutPermission;
  List<String> availableForOptions;
  String type;
  bool rememberPosition;
  num durationMs;
  String storageDir;
  num fileSize;
  num previewDurationMs;
  R128 r128;
  List<Artists> artists;
  List<Albums> albums;
  String coverUri;
  String ogImage;
  bool lyricsAvailable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['realId'] = realId;
    map['trackSource'] = trackSource;
    map['title'] = title;
    if (major != null) {
      map['major'] = major.toJson();
    }
    map['available'] = available;
    map['availableForPremiumUsers'] = availableForPremiumUsers;
    map['availableFullWithoutPermission'] = availableFullWithoutPermission;
    map['availableForOptions'] = availableForOptions;
    map['type'] = type;
    map['rememberPosition'] = rememberPosition;
    map['durationMs'] = durationMs;
    map['storageDir'] = storageDir;
    map['fileSize'] = fileSize;
    map['previewDurationMs'] = previewDurationMs;
    if (r128 != null) {
      map['r128'] = r128.toJson();
    }
    if (artists != null) {
      map['artists'] = artists.map((v) => v.toJson()).toList();
    }
    if (albums != null) {
      map['albums'] = albums.map((v) => v.toJson()).toList();
    }
    map['coverUri'] = coverUri;
    map['ogImage'] = ogImage;
    map['lyricsAvailable'] = lyricsAvailable;
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
      this.trackPosition,});

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
    availableForOptions = json['availableForOptions'] != null ? json['availableForOptions'].cast<String>() : [];
    availableForMobile = json['availableForMobile'];
    availablePartially = json['availablePartially'];
    bests = json['bests'] != null ? json['bests'].cast<num>() : [];
    trackPosition = json['trackPosition'] != null ? TrackPosition.fromJson(json['trackPosition']) : null;
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
      this.index,});

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

class Labels {
  Labels({
      this.id, 
      this.name,});

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
      this.genres,});

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

class Cover {
  Cover({
      this.type, 
      this.prefix, 
      this.uri,});

  Cover.fromJson(dynamic json) {
    type = json['type'];
    prefix = json['prefix'];
    uri = json['uri'];
  }
  String type;
  String prefix;
  String uri;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['prefix'] = prefix;
    map['uri'] = uri;
    return map;
  }

}

class R128 {
  R128({
      this.i, 
      this.tp,});

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
      this.name,});

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