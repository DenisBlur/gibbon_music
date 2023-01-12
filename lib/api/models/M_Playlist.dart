import 'M_Artist.dart';

class MPlaylist {
  MPlaylist({
      this.uid, 
      this.kind, 
      this.title, 
      this.revision, 
      this.snapshot, 
      this.visibility, 
      this.collective, 
      this.created, 
      this.modified, 
      this.available, 
      this.isBanner, 
      this.isPremiere, 
      this.owner, 
      this.trackCount, 
      this.cover, 
      this.likesCount, 
      this.topArtist,});

  MPlaylist.fromJson(dynamic json) {
    uid = json['uid'];
    kind = json['kind'];
    title = json['title'];
    revision = json['revision'];
    snapshot = json['snapshot'];
    visibility = json['visibility'];
    collective = json['collective'];
    created = json['created'];
    modified = json['modified'];
    available = json['available'];
    isBanner = json['isBanner'];
    isPremiere = json['isPremiere'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    trackCount = json['trackCount'];
    cover = json['cover'] != null ? Cover.fromJson(json['cover']) : null;
    likesCount = json['likesCount'];
    if (json['topArtist'] != null) {
      topArtist = [];
      json['topArtist'].forEach((v) {
        topArtist.add(MArtist.fromJson(v));
      });
    }
  }
  num uid;
  num kind;
  String title;
  num revision;
  num snapshot;
  String visibility;
  bool collective;
  String created;
  String modified;
  bool available;
  bool isBanner;
  bool isPremiere;
  Owner owner;
  num trackCount;
  Cover cover;
  num likesCount;
  List<MArtist> topArtist;
MPlaylist copyWith({  num uid,
  num kind,
  String title,
  num revision,
  num snapshot,
  String visibility,
  bool collective,
  String created,
  String modified,
  bool available,
  bool isBanner,
  bool isPremiere,
  Owner owner,
  num trackCount,
  Cover cover,
  num likesCount,
  List<dynamic> topArtist,
}) => MPlaylist(  uid: uid ?? this.uid,
  kind: kind ?? this.kind,
  title: title ?? this.title,
  revision: revision ?? this.revision,
  snapshot: snapshot ?? this.snapshot,
  visibility: visibility ?? this.visibility,
  collective: collective ?? this.collective,
  created: created ?? this.created,
  modified: modified ?? this.modified,
  available: available ?? this.available,
  isBanner: isBanner ?? this.isBanner,
  isPremiere: isPremiere ?? this.isPremiere,
  owner: owner ?? this.owner,
  trackCount: trackCount ?? this.trackCount,
  cover: cover ?? this.cover,
  likesCount: likesCount ?? this.likesCount,
  topArtist: topArtist ?? this.topArtist,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = uid;
    map['kind'] = kind;
    map['title'] = title;
    map['revision'] = revision;
    map['snapshot'] = snapshot;
    map['visibility'] = visibility;
    map['collective'] = collective;
    map['created'] = created;
    map['modified'] = modified;
    map['available'] = available;
    map['isBanner'] = isBanner;
    map['isPremiere'] = isPremiere;
    if (owner != null) {
      map['owner'] = owner.toJson();
    }
    map['trackCount'] = trackCount;
    if (cover != null) {
      map['cover'] = cover.toJson();
    }
    map['likesCount'] = likesCount;
    if (topArtist != null) {
      map['topArtist'] = topArtist.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Cover {
  Cover({
      this.type, 
      this.itemsUri, 
      this.uri, 
      this.custom,});

  Cover.fromJson(dynamic json) {
    type = json['type'];
    itemsUri = json['itemsUri'] != null ? json['itemsUri'].cast<String>() : [];
    uri = json['uri'];
    custom = json['custom'];
  }
  String type;
  List<String> itemsUri;
  String uri;
  bool custom;
Cover copyWith({  String type,
  List<String> itemsUri,
  String uri,
  bool custom,
}) => Cover(  type: type ?? this.type,
  itemsUri: itemsUri ?? this.itemsUri,
  uri: uri ?? this.uri,
  custom: custom ?? this.custom,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['itemsUri'] = itemsUri;
    map['uri'] = uri;
    map['custom'] = custom;
    return map;
  }

}

class Owner {
  Owner({
      this.uid, 
      this.login, 
      this.name, 
      this.sex, 
      this.verified,});

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
Owner copyWith({  num uid,
  String login,
  String name,
  String sex,
  bool verified,
}) => Owner(  uid: uid ?? this.uid,
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