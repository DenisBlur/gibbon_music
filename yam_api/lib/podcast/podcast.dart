import 'package:yam_api/artist/brief_info.dart';

import '../album/album.dart';
import '../track/lyric_info.dart';
import '../track/major.dart';
import '../track/r128.dart';

class Podcast {
  Podcast({
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
      this.shortDescription, 
      this.podcastEpisodeType, 
      this.pubDate, 
      this.trackSharingFlag, 
      this.lyricsInfo, 
      this.trackSource, 
      this.availableAsRbt, 
      this.explicit, 
      this.regions,});

  Podcast.fromJson(dynamic json) {
    id = json['id'];
    realId = json['realId'];
    title = json['title'];
    major = json['major'] != null ? Major.fromJson(json['major']) : null;
    available = json['available'];
    availableForPremiumUsers = json['availableForPremiumUsers'];
    availableFullWithoutPermission = json['availableFullWithoutPermission'];
    availableForOptions = json['availableForOptions'] != null ? json['availableForOptions'].cast<String>() : [];
    storageDir = json['storageDir'];
    durationMs = json['durationMs'];
    fileSize = json['fileSize'];
    r128 = json['r128'] != null ? R128.fromJson(json['r128']) : null;
    previewDurationMs = json['previewDurationMs'];
    if (json['artists'] != null) {
      artists = [];
      json['artists'].forEach((v) {
        artists?.add(BriefInfo.fromJson(v));
      });
    }
    if (json['albums'] != null) {
      albums = [];
      json['albums'].forEach((v) {
        albums?.add(Album.fromJson(v));
      });
    }
    coverUri = json['coverUri'];
    ogImage = json['ogImage'];
    lyricsAvailable = json['lyricsAvailable'];
    type = json['type'];
    rememberPosition = json['rememberPosition'];
    shortDescription = json['shortDescription'];
    podcastEpisodeType = json['podcastEpisodeType'];
    pubDate = json['pubDate'];
    trackSharingFlag = json['trackSharingFlag'];
    lyricsInfo = json['lyricsInfo'] != null ? LyricsInfo.fromJson(json['lyricsInfo']) : null;
    trackSource = json['trackSource'];
    availableAsRbt = json['availableAsRbt'];
    explicit = json['explicit'];
    regions = json['regions'] != null ? json['regions'].cast<String>() : [];
  }
  num? id;
  String? realId;
  String? title;
  Major? major;
  bool? available;
  bool? availableForPremiumUsers;
  bool? availableFullWithoutPermission;
  List<String>? availableForOptions;
  String? storageDir;
  num? durationMs;
  num? fileSize;
  R128? r128;
  num? previewDurationMs;
  List<BriefInfo>? artists;
  List<Album>? albums;
  String? coverUri;
  String? ogImage;
  bool? lyricsAvailable;
  String? type;
  bool? rememberPosition;
  String? shortDescription;
  String? podcastEpisodeType;
  String? pubDate;
  String? trackSharingFlag;
  LyricsInfo? lyricsInfo;
  String? trackSource;
  bool? availableAsRbt;
  bool? explicit;
  List<String>? regions;
Podcast copyWith({  num? id,
  String? realId,
  String? title,
  Major? major,
  bool? available,
  bool? availableForPremiumUsers,
  bool? availableFullWithoutPermission,
  List<String>? availableForOptions,
  String? storageDir,
  num? durationMs,
  num? fileSize,
  R128? r128,
  num? previewDurationMs,
  List<BriefInfo>? artists,
  List<Album>? albums,
  String? coverUri,
  String? ogImage,
  bool? lyricsAvailable,
  String? type,
  bool? rememberPosition,
  String? shortDescription,
  String? podcastEpisodeType,
  String? pubDate,
  String? trackSharingFlag,
  LyricsInfo? lyricsInfo,
  String? trackSource,
  bool? availableAsRbt,
  bool? explicit,
  List<String>? regions,
}) => Podcast(  id: id ?? this.id,
  realId: realId ?? this.realId,
  title: title ?? this.title,
  major: major ?? this.major,
  available: available ?? this.available,
  availableForPremiumUsers: availableForPremiumUsers ?? this.availableForPremiumUsers,
  availableFullWithoutPermission: availableFullWithoutPermission ?? this.availableFullWithoutPermission,
  availableForOptions: availableForOptions ?? this.availableForOptions,
  storageDir: storageDir ?? this.storageDir,
  durationMs: durationMs ?? this.durationMs,
  fileSize: fileSize ?? this.fileSize,
  r128: r128 ?? this.r128,
  previewDurationMs: previewDurationMs ?? this.previewDurationMs,
  artists: artists ?? this.artists,
  albums: albums ?? this.albums,
  coverUri: coverUri ?? this.coverUri,
  ogImage: ogImage ?? this.ogImage,
  lyricsAvailable: lyricsAvailable ?? this.lyricsAvailable,
  type: type ?? this.type,
  rememberPosition: rememberPosition ?? this.rememberPosition,
  shortDescription: shortDescription ?? this.shortDescription,
  podcastEpisodeType: podcastEpisodeType ?? this.podcastEpisodeType,
  pubDate: pubDate ?? this.pubDate,
  trackSharingFlag: trackSharingFlag ?? this.trackSharingFlag,
  lyricsInfo: lyricsInfo ?? this.lyricsInfo,
  trackSource: trackSource ?? this.trackSource,
  availableAsRbt: availableAsRbt ?? this.availableAsRbt,
  explicit: explicit ?? this.explicit,
  regions: regions ?? this.regions,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['realId'] = realId;
    map['title'] = title;
    if (major != null) {
      map['major'] = major?.toJson();
    }
    map['available'] = available;
    map['availableForPremiumUsers'] = availableForPremiumUsers;
    map['availableFullWithoutPermission'] = availableFullWithoutPermission;
    map['availableForOptions'] = availableForOptions;
    map['storageDir'] = storageDir;
    map['durationMs'] = durationMs;
    map['fileSize'] = fileSize;
    if (r128 != null) {
      map['r128'] = r128?.toJson();
    }
    map['previewDurationMs'] = previewDurationMs;
    if (artists != null) {
      map['artists'] = artists?.map((v) => v.toJson()).toList();
    }
    if (albums != null) {
      map['albums'] = albums?.map((v) => v.toJson()).toList();
    }
    map['coverUri'] = coverUri;
    map['ogImage'] = ogImage;
    map['lyricsAvailable'] = lyricsAvailable;
    map['type'] = type;
    map['rememberPosition'] = rememberPosition;
    map['shortDescription'] = shortDescription;
    map['podcastEpisodeType'] = podcastEpisodeType;
    map['pubDate'] = pubDate;
    map['trackSharingFlag'] = trackSharingFlag;
    if (lyricsInfo != null) {
      map['lyricsInfo'] = lyricsInfo?.toJson();
    }
    map['trackSource'] = trackSource;
    map['availableAsRbt'] = availableAsRbt;
    map['explicit'] = explicit;
    map['regions'] = regions;
    return map;
  }

}