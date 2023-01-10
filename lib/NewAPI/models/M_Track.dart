import 'InnerModel/M_InnerAlbum.dart';
import 'InnerModel/M_InnerArtist.dart';
import 'M_Album.dart';
import 'M_Artist.dart';

class MTrack {
  MTrack({
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

  MTrack.fromJson(dynamic json) {
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
        artists.add(MInnerArtist.fromJson(v));
      });
    }
    if (json['albums'] != null) {
      albums = [];
      json['albums'].forEach((v) {
        albums.add(MInnerAlbum.fromJson(v));
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
  List<MInnerArtist> artists;
  List<MInnerAlbum> albums;
  String coverUri;
  String ogImage;
  bool lyricsAvailable;
MTrack copyWith({  String id,
  String realId,
  String trackSource,
  String title,
  Major major,
  bool available,
  bool availableForPremiumUsers,
  bool availableFullWithoutPermission,
  List<String> availableForOptions,
  String type,
  bool rememberPosition,
  num durationMs,
  String storageDir,
  num fileSize,
  num previewDurationMs,
  R128 r128,
  List<MArtist> artists,
  List<MAlbum> albums,
  String coverUri,
  String ogImage,
  bool lyricsAvailable,
}) => MTrack(  id: id ?? this.id,
  realId: realId ?? this.realId,
  trackSource: trackSource ?? this.trackSource,
  title: title ?? this.title,
  major: major ?? this.major,
  available: available ?? this.available,
  availableForPremiumUsers: availableForPremiumUsers ?? this.availableForPremiumUsers,
  availableFullWithoutPermission: availableFullWithoutPermission ?? this.availableFullWithoutPermission,
  availableForOptions: availableForOptions ?? this.availableForOptions,
  type: type ?? this.type,
  rememberPosition: rememberPosition ?? this.rememberPosition,
  durationMs: durationMs ?? this.durationMs,
  storageDir: storageDir ?? this.storageDir,
  fileSize: fileSize ?? this.fileSize,
  previewDurationMs: previewDurationMs ?? this.previewDurationMs,
  r128: r128 ?? this.r128,
  artists: artists ?? this.artists,
  albums: albums ?? this.albums,
  coverUri: coverUri ?? this.coverUri,
  ogImage: ogImage ?? this.ogImage,
  lyricsAvailable: lyricsAvailable ?? this.lyricsAvailable,
);
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
TrackPosition copyWith({  num volume,
  num index,
}) => TrackPosition(  volume: volume ?? this.volume,
  index: index ?? this.index,
);
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
Labels copyWith({  num id,
  String name,
}) => Labels(  id: id ?? this.id,
  name: name ?? this.name,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
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
Cover copyWith({  String type,
  String prefix,
  String uri,
}) => Cover(  type: type ?? this.type,
  prefix: prefix ?? this.prefix,
  uri: uri ?? this.uri,
);
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
R128 copyWith({  num i,
  num tp,
}) => R128(  i: i ?? this.i,
  tp: tp ?? this.tp,
);
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
Major copyWith({  num id,
  String name,
}) => Major(  id: id ?? this.id,
  name: name ?? this.name,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}