import 'package:gibbon_music/NewAPI/models/M_Playlist.dart';
import 'package:gibbon_music/NewAPI/models/M_Track.dart';

import '../M_Cover.dart';
import 'M_CustomWave.dart';
import 'M_Pager.dart';

class MPagePlaylist {
  MPagePlaylist({
    this.owner,
    this.playlistUuid,
    this.available,
    this.uid,
    this.kind,
    this.title,
    this.revision,
    this.snapshot,
    this.trackCount,
    this.visibility,
    this.collective,
    this.created,
    this.modified,
    this.isBanner,
    this.isPremiere,
    this.durationMs,
    this.cover,
    this.ogImage,
    this.tracks,
    this.tags,
    this.likesCount,
    this.lastOwnerPlaylists,
    this.customWave,
    this.pager,
  });

  MPagePlaylist.fromJson(dynamic json) {
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    playlistUuid = json['playlistUuid'];
    available = json['available'];
    uid = json['uid'];
    kind = json['kind'];
    title = json['title'];
    revision = json['revision'];
    snapshot = json['snapshot'];
    trackCount = json['trackCount'];
    visibility = json['visibility'];
    collective = json['collective'];
    created = json['created'];
    modified = json['modified'];
    isBanner = json['isBanner'];
    isPremiere = json['isPremiere'];
    durationMs = json['durationMs'];
    cover = json['cover'] != null ? MCover.fromJson(json['cover']) : null;
    ogImage = json['ogImage'];
    if (json['tracks'] != null) {
      tracks = [];
      json['tracks'].forEach((v) {
        tracks.add(Tracks.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) {
        tags.add(v);
      });
    }
    likesCount = json['likesCount'];
    if (json['lastOwnerPlaylists'] != null) {
      lastOwnerPlaylists = [];
      json['lastOwnerPlaylists'].forEach((v) {
        lastOwnerPlaylists.add(MPlaylist.fromJson(v));
      });
    }
    customWave = json['customWave'] != null ? MCustomWave.fromJson(json['customWave']) : null;
    pager = json['pager'] != null ? MPager.fromJson(json['pager']) : null;
  }

  Owner owner;
  String playlistUuid;
  bool available;
  num uid;
  num kind;
  String title;
  num revision;
  num snapshot;
  num trackCount;
  String visibility;
  bool collective;
  String created;
  String modified;
  bool isBanner;
  bool isPremiere;
  num durationMs;
  MCover cover;
  String ogImage;
  List<Tracks> tracks;
  List<dynamic> tags;
  num likesCount;
  List<MPlaylist> lastOwnerPlaylists;
  MCustomWave customWave;
  MPager pager;

  MPagePlaylist copyWith({
    Owner owner,
    String playlistUuid,
    bool available,
    num uid,
    num kind,
    String title,
    num revision,
    num snapshot,
    num trackCount,
    String visibility,
    bool collective,
    String created,
    String modified,
    bool isBanner,
    bool isPremiere,
    num durationMs,
    MCover cover,
    String ogImage,
    List<Tracks> tracks,
    List<dynamic> tags,
    num likesCount,
    List<MPlaylist> lastOwnerPlaylists,
    MCustomWave customWave,
    MPager pager,
  }) =>
      MPagePlaylist(
        owner: owner ?? this.owner,
        playlistUuid: playlistUuid ?? this.playlistUuid,
        available: available ?? this.available,
        uid: uid ?? this.uid,
        kind: kind ?? this.kind,
        title: title ?? this.title,
        revision: revision ?? this.revision,
        snapshot: snapshot ?? this.snapshot,
        trackCount: trackCount ?? this.trackCount,
        visibility: visibility ?? this.visibility,
        collective: collective ?? this.collective,
        created: created ?? this.created,
        modified: modified ?? this.modified,
        isBanner: isBanner ?? this.isBanner,
        isPremiere: isPremiere ?? this.isPremiere,
        durationMs: durationMs ?? this.durationMs,
        cover: cover ?? this.cover,
        ogImage: ogImage ?? this.ogImage,
        tracks: tracks ?? this.tracks,
        tags: tags ?? this.tags,
        likesCount: likesCount ?? this.likesCount,
        lastOwnerPlaylists: lastOwnerPlaylists ?? this.lastOwnerPlaylists,
        customWave: customWave ?? this.customWave,
        pager: pager ?? this.pager,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (owner != null) {
      map['owner'] = owner.toJson();
    }
    map['playlistUuid'] = playlistUuid;
    map['available'] = available;
    map['uid'] = uid;
    map['kind'] = kind;
    map['title'] = title;
    map['revision'] = revision;
    map['snapshot'] = snapshot;
    map['trackCount'] = trackCount;
    map['visibility'] = visibility;
    map['collective'] = collective;
    map['created'] = created;
    map['modified'] = modified;
    map['isBanner'] = isBanner;
    map['isPremiere'] = isPremiere;
    map['durationMs'] = durationMs;
    if (cover != null) {
      map['cover'] = cover.toJson();
    }
    map['ogImage'] = ogImage;
    if (tracks != null) {
      map['tracks'] = tracks.map((v) => v.toJson()).toList();
    }
    if (tags != null) {
      map['tags'] = tags.map((v) => v.toJson()).toList();
    }
    map['likesCount'] = likesCount;
    if (lastOwnerPlaylists != null) {
      map['lastOwnerPlaylists'] = lastOwnerPlaylists.map((v) => v.toJson()).toList();
    }
    if (customWave != null) {
      map['customWave'] = customWave.toJson();
    }
    if (pager != null) {
      map['pager'] = pager.toJson();
    }
    return map;
  }
}

class Owner {
  Owner({
    this.uid,
    this.login,
    this.name,
    this.sex,
    this.verified,
  });

  Owner.fromJson(dynamic json) {
    uid = json['uid'];
    login = json['login'];
    name = json['name'];
    sex = json['sex'];
    verified = json['verified'];
  }

  num uid;
  String login;
  String name;
  String sex;
  bool verified;

  Owner copyWith({
    num uid,
    String login,
    String name,
    String sex,
    bool verified,
  }) =>
      Owner(
        uid: uid ?? this.uid,
        login: login ?? this.login,
        name: name ?? this.name,
        sex: sex ?? this.sex,
        verified: verified ?? this.verified,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = uid;
    map['login'] = login;
    map['name'] = name;
    map['sex'] = sex;
    map['verified'] = verified;
    return map;
  }
}

class Tracks {
  Tracks({
    this.id,
    this.track,
    this.timestamp,
    this.originalIndex,
    this.recent,
  });

  Tracks.fromJson(dynamic json) {
    id = json['id'];
    track = json['track'] != null ? MTrack.fromJson(json['track']) : null;
    timestamp = json['timestamp'];
    originalIndex = json['originalIndex'];
    recent = json['recent'];
  }

  num id;
  MTrack track;
  String timestamp;
  num originalIndex;
  bool recent;

  Tracks copyWith({
    num id,
    MTrack track,
    String timestamp,
    num originalIndex,
    bool recent,
  }) =>
      Tracks(
        id: id ?? this.id,
        track: track ?? this.track,
        timestamp: timestamp ?? this.timestamp,
        originalIndex: originalIndex ?? this.originalIndex,
        recent: recent ?? this.recent,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (track != null) {
      map['track'] = track.toJson();
    }
    map['timestamp'] = timestamp;
    map['originalIndex'] = originalIndex;
    map['recent'] = recent;
    return map;
  }
}
