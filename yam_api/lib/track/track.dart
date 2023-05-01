import 'package:yam_api/artist/brief_info.dart';

import '../album/album.dart';
import 'lyric_info.dart';
import 'major.dart';
import 'r128.dart';

class Track {
  Track({
    this.id,
    this.realId,
    this.title,
    this.trackSource,
    this.major,
    this.available,
    this.availableForPremiumUsers,
    this.availableFullWithoutPermission,
    this.availableForOptions,
    this.durationMs,
    this.storageDir,
    this.fileSize,
    this.r128,
    this.previewDurationMs,
    this.artists,
    this.albums,
    this.coverUri,
    this.ogImage,
    this.lyricsAvailable,
    this.lyricsInfo,
    this.type,
    this.rememberPosition,
    this.trackSharingFlag,
    this.backgroundVideoUri,
  });

  Track.fromJson(dynamic json) {
    id = json['id'].toString();
    realId = json['realId'];
    title = json['title'];
    trackSource = json['trackSource'];
    major = json['major'] != null ? Major.fromJson(json['major']) : null;
    available = json['available'];
    availableForPremiumUsers = json['availableForPremiumUsers'];
    availableFullWithoutPermission = json['availableFullWithoutPermission'];
    availableForOptions = json['availableForOptions'] != null ? json['availableForOptions'].cast<String>() : [];
    durationMs = json['durationMs'];
    storageDir = json['storageDir'];
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
    lyricsInfo = json['lyricsInfo'] != null ? LyricsInfo.fromJson(json['lyricsInfo']) : null;
    type = json['type'];
    rememberPosition = json['rememberPosition'];
    trackSharingFlag = json['trackSharingFlag'];
    backgroundVideoUri = json['backgroundVideoUri'] ?? "";
  }

  String? id;
  String? realId;
  String? title;
  String? trackSource;
  Major? major;
  bool? available;
  bool? availableForPremiumUsers;
  bool? availableFullWithoutPermission;
  List<String>? availableForOptions;
  num? durationMs;
  String? storageDir;
  num? fileSize;
  R128? r128;
  num? previewDurationMs;
  List<BriefInfo>? artists;
  List<Album>? albums;
  String? coverUri;
  String? ogImage;
  bool? lyricsAvailable;
  LyricsInfo? lyricsInfo;
  String? type;
  bool? rememberPosition;
  String? trackSharingFlag;
  String? backgroundVideoUri;

  Track copyWith({
    String? id,
    String? realId,
    String? title,
    String? trackSource,
    Major? major,
    bool? available,
    bool? availableForPremiumUsers,
    bool? availableFullWithoutPermission,
    List<String>? availableForOptions,
    num? durationMs,
    String? storageDir,
    num? fileSize,
    R128? r128,
    num? previewDurationMs,
    List<BriefInfo>? artists,
    List<Album>? albums,
    String? coverUri,
    String? ogImage,
    bool? lyricsAvailable,
    LyricsInfo? lyricsInfo,
    String? type,
    bool? rememberPosition,
    String? trackSharingFlag,
    String? backgroundVideoUri,
  }) =>
      Track(
        id: id ?? this.id,
        realId: realId ?? this.realId,
        title: title ?? this.title,
        trackSource: trackSource ?? this.trackSource,
        major: major ?? this.major,
        available: available ?? this.available,
        availableForPremiumUsers: availableForPremiumUsers ?? this.availableForPremiumUsers,
        availableFullWithoutPermission: availableFullWithoutPermission ?? this.availableFullWithoutPermission,
        availableForOptions: availableForOptions ?? this.availableForOptions,
        durationMs: durationMs ?? this.durationMs,
        storageDir: storageDir ?? this.storageDir,
        fileSize: fileSize ?? this.fileSize,
        r128: r128 ?? this.r128,
        previewDurationMs: previewDurationMs ?? this.previewDurationMs,
        artists: artists ?? this.artists,
        albums: albums ?? this.albums,
        coverUri: coverUri ?? this.coverUri,
        ogImage: ogImage ?? this.ogImage,
        lyricsAvailable: lyricsAvailable ?? this.lyricsAvailable,
        lyricsInfo: lyricsInfo ?? this.lyricsInfo,
        type: type ?? this.type,
        rememberPosition: rememberPosition ?? this.rememberPosition,
        trackSharingFlag: trackSharingFlag ?? this.trackSharingFlag,
        backgroundVideoUri: backgroundVideoUri ?? this.backgroundVideoUri,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['realId'] = realId;
    map['title'] = title;
    map['trackSource'] = trackSource;
    if (major != null) {
      map['major'] = major?.toJson();
    }
    map['available'] = available;
    map['availableForPremiumUsers'] = availableForPremiumUsers;
    map['availableFullWithoutPermission'] = availableFullWithoutPermission;
    map['availableForOptions'] = availableForOptions;
    map['durationMs'] = durationMs;
    map['storageDir'] = storageDir;
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
    if (lyricsInfo != null) {
      map['lyricsInfo'] = lyricsInfo?.toJson();
    }
    map['type'] = type;
    map['rememberPosition'] = rememberPosition;
    map['trackSharingFlag'] = trackSharingFlag;
    map['backgroundVideoUri'] = backgroundVideoUri;
    return map;
  }
}
