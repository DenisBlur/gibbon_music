import 'package:yam_api/playlist/user_info.dart';

import '../cover.dart';
import '../owner.dart';
import 'case_forms.dart';
import 'play_counter.dart';
import 'tracks.dart';

class Playlist {
  Playlist({
    this.owner,
    this.playlistUuid,
    this.available,
    this.uid,
    this.kind,
    this.title,
    this.description,
    this.descriptionFormatted,
    this.revision,
    this.snapshot,
    this.trackCount,
    this.visibility,
    this.collective,
    this.created,
    this.modified,
    this.isBanner,
    this.isPremiere,
    this.idForFrom,
    this.everPlayed,
    this.coverWithoutText,
    this.urlPart,
    this.durationMs,
    this.cover,
    this.animatedCoverUri,
    this.ogImage,
    this.ogTitle,
    this.tracks,
    this.tags,
    this.madeFor,
    this.playCounter,
    this.generatedPlaylistType,
    this.backgroundVideoUrl,
    this.backgroundImageUrl,});

  Playlist.fromJson(dynamic json) {
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    playlistUuid = json['playlistUuid'];
    available = json['available'];
    uid = json['uid'];
    kind = json['kind'];
    title = json['title'];
    description = json['description'];
    descriptionFormatted = json['descriptionFormatted'];
    revision = json['revision'];
    snapshot = json['snapshot'];
    trackCount = json['trackCount'];
    visibility = json['visibility'];
    collective = json['collective'];
    created = json['created'];
    modified = json['modified'];
    isBanner = json['isBanner'];
    isPremiere = json['isPremiere'];
    idForFrom = json['idForFrom'];
    everPlayed = json['everPlayed'];
    coverWithoutText = json['coverWithoutText'] != null ? Cover.fromJson(json['coverWithoutText']) : null;
    urlPart = json['urlPart'];
    durationMs = json['durationMs'];
    cover = json['cover'] != null ? Cover.fromJson(json['cover']) : null;
    animatedCoverUri = json['animatedCoverUri'];
    ogImage = json['ogImage'];
    ogTitle = json['ogTitle'];
    if (json['tracks'] != null) {
      tracks = [];
      json['tracks'].forEach((v) {
        tracks?.add(Tracks.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) {
        tags?.add(v);
      });
    }
    madeFor = json['madeFor'] != null ? MadeFor.fromJson(json['madeFor']) : null;
    playCounter = json['playCounter'] != null ? PlayCounter.fromJson(json['playCounter']) : null;
    generatedPlaylistType = json['generatedPlaylistType'];
    backgroundVideoUrl = json['backgroundVideoUrl'];
    backgroundImageUrl = json['backgroundImageUrl'];
  }
  Owner? owner;
  String? playlistUuid;
  bool? available;
  num? uid;
  num? kind;
  String? title;
  String? description;
  String? descriptionFormatted;
  num? revision;
  num? snapshot;
  num? trackCount;
  String? visibility;
  bool? collective;
  String? created;
  String? modified;
  bool? isBanner;
  bool? isPremiere;
  String? idForFrom;
  bool? everPlayed;
  Cover? coverWithoutText;
  String? urlPart;
  num? durationMs;
  Cover? cover;
  String? animatedCoverUri;
  String? ogImage;
  String? ogTitle;
  List<Tracks>? tracks;
  List<dynamic>? tags;
  MadeFor? madeFor;
  PlayCounter? playCounter;
  String? generatedPlaylistType;
  String? backgroundVideoUrl;
  String? backgroundImageUrl;
  Playlist copyWith({Owner? owner,
    String? playlistUuid,
    bool? available,
    num? uid,
    num? kind,
    String? title,
    String? description,
    String? descriptionFormatted,
    num? revision,
    num? snapshot,
    num? trackCount,
    String? visibility,
    bool? collective,
    String? created,
    String? modified,
    bool? isBanner,
    bool? isPremiere,
    String? idForFrom,
    bool? everPlayed,
    Cover? coverWithoutText,
    String? urlPart,
    num? durationMs,
    Cover? cover,
    String? animatedCoverUri,
    String? ogImage,
    String? ogTitle,
    List<Tracks>? tracks,
    List<dynamic>? tags,
    MadeFor? madeFor,
    PlayCounter? playCounter,
    String? generatedPlaylistType,
    String? backgroundVideoUrl,
    String? backgroundImageUrl,
  }) => Playlist(  owner: owner ?? this.owner,
    playlistUuid: playlistUuid ?? this.playlistUuid,
    available: available ?? this.available,
    uid: uid ?? this.uid,
    kind: kind ?? this.kind,
    title: title ?? this.title,
    description: description ?? this.description,
    descriptionFormatted: descriptionFormatted ?? this.descriptionFormatted,
    revision: revision ?? this.revision,
    snapshot: snapshot ?? this.snapshot,
    trackCount: trackCount ?? this.trackCount,
    visibility: visibility ?? this.visibility,
    collective: collective ?? this.collective,
    created: created ?? this.created,
    modified: modified ?? this.modified,
    isBanner: isBanner ?? this.isBanner,
    isPremiere: isPremiere ?? this.isPremiere,
    idForFrom: idForFrom ?? this.idForFrom,
    everPlayed: everPlayed ?? this.everPlayed,
    coverWithoutText: coverWithoutText ?? this.coverWithoutText,
    urlPart: urlPart ?? this.urlPart,
    durationMs: durationMs ?? this.durationMs,
    cover: cover ?? this.cover,
    animatedCoverUri: animatedCoverUri ?? this.animatedCoverUri,
    ogImage: ogImage ?? this.ogImage,
    ogTitle: ogTitle ?? this.ogTitle,
    tracks: tracks ?? this.tracks,
    tags: tags ?? this.tags,
    madeFor: madeFor ?? this.madeFor,
    playCounter: playCounter ?? this.playCounter,
    generatedPlaylistType: generatedPlaylistType ?? this.generatedPlaylistType,
    backgroundVideoUrl: backgroundVideoUrl ?? this.backgroundVideoUrl,
    backgroundImageUrl: backgroundImageUrl ?? this.backgroundImageUrl,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (owner != null) {
      map['owner'] = owner?.toJson();
    }
    map['playlistUuid'] = playlistUuid;
    map['available'] = available;
    map['uid'] = uid;
    map['kind'] = kind;
    map['title'] = title;
    map['description'] = description;
    map['descriptionFormatted'] = descriptionFormatted;
    map['revision'] = revision;
    map['snapshot'] = snapshot;
    map['trackCount'] = trackCount;
    map['visibility'] = visibility;
    map['collective'] = collective;
    map['created'] = created;
    map['modified'] = modified;
    map['isBanner'] = isBanner;
    map['isPremiere'] = isPremiere;
    map['idForFrom'] = idForFrom;
    map['everPlayed'] = everPlayed;
    if (coverWithoutText != null) {
      map['coverWithoutText'] = coverWithoutText?.toJson();
    }
    map['urlPart'] = urlPart;
    map['durationMs'] = durationMs;
    if (cover != null) {
      map['cover'] = cover?.toJson();
    }
    map['animatedCoverUri'] = animatedCoverUri;
    map['ogImage'] = ogImage;
    map['ogTitle'] = ogTitle;
    if (tracks != null) {
      map['tracks'] = tracks?.map((v) => v.toJson()).toList();
    }
    if (tags != null) {
      map['tags'] = tags?.map((v) => v.toJson()).toList();
    }
    if (madeFor != null) {
      map['madeFor'] = madeFor?.toJson();
    }
    if (playCounter != null) {
      map['playCounter'] = playCounter?.toJson();
    }
    map['generatedPlaylistType'] = generatedPlaylistType;
    map['backgroundVideoUrl'] = backgroundVideoUrl;
    map['backgroundImageUrl'] = backgroundImageUrl;
    return map;
  }
}

class MadeFor {
  MadeFor({
    this.userInfo,
    this.caseForms,});

  MadeFor.fromJson(dynamic json) {
    userInfo = json['userInfo'] != null ? UserInfo.fromJson(json['userInfo']) : null;
    caseForms = json['caseForms'] != null ? CaseForms.fromJson(json['caseForms']) : null;
  }
  UserInfo? userInfo;
  CaseForms? caseForms;
  MadeFor copyWith({  UserInfo? userInfo,
    CaseForms? caseForms,
  }) => MadeFor(  userInfo: userInfo ?? this.userInfo,
    caseForms: caseForms ?? this.caseForms,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (userInfo != null) {
      map['userInfo'] = userInfo?.toJson();
    }
    if (caseForms != null) {
      map['caseForms'] = caseForms?.toJson();
    }
    return map;
  }

}
