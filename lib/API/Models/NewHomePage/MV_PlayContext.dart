import '../ArtistPage/MV_ArtistPage.dart';

class MvPlayContext {
  MvPlayContext({
    this.client,
    this.context,
    this.contextItem,
    this.payload,});

  MvPlayContext.fromJson(dynamic json) {
    client = json['client'];
    context = json['context'];
    contextItem = json['contextItem'];
    payload = json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }
  String client;
  String context;
  String contextItem;
  Payload payload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['client'] = client;
    map['context'] = context;
    map['contextItem'] = contextItem;
    if (payload != null) {
      map['payload'] = payload.toJson();
    }
    return map;
  }

}

class Payload {
  Payload({
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
    this.name,
    this.various,
    this.composer,
    this.cover,
    this.genres,
    this.counts,
    this.ratings,
    this.links,
    this.uid,
    this.kind,
    this.revision,
    this.snapshot,
    this.visibility,
    this.collective,
    this.created,
    this.modified,
    this.isBanner,
    this.isPremiere,
    this.owner,
    this.topArtist,});

  Payload.fromJson(dynamic json) {
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
    availableForOptions = json['availableForOptions'] != null ? json['availableForOptions'].cast<String>() : [];
    availableForMobile = json['availableForMobile'];
    availablePartially = json['availablePartially'];
    bests = json['bests'] != null ? json['bests'].cast<num>() : [];
    name = json['name'];
    various = json['various'];
    composer = json['composer'];
    cover = json['cover'] != null ? Cover.fromJson(json['cover']) : null;
    genres = json['genres'] != null ? json['genres'].cast<String>() : [];
    counts = json['counts'] != null ? Counts.fromJson(json['counts']) : null;
    ratings = json['ratings'] != null ? Ratings.fromJson(json['ratings']) : null;
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links.add(Links.fromJson(v));
      });
    }
    uid = json['uid'];
    kind = json['kind'];
    revision = json['revision'];
    snapshot = json['snapshot'];
    visibility = json['visibility'];
    collective = json['collective'];
    created = json['created'];
    modified = json['modified'];
    isBanner = json['isBanner'];
    isPremiere = json['isPremiere'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    if (json['topArtist'] != null) {
      topArtist = [];
      json['topArtist'].forEach((v) {
        topArtist.add(Artists.fromJson(v));
      });
    }
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
  String name;
  bool various;
  bool composer;
  Cover cover;
  List<String> genres;
  Counts counts;
  Ratings ratings;
  List<Links> links;
  num uid;
  num kind;
  num revision;
  num snapshot;
  String visibility;
  bool collective;
  String created;
  String modified;
  bool isBanner;
  bool isPremiere;
  Owner owner;
  List<dynamic> topArtist;

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
    map['name'] = name;
    map['various'] = various;
    map['composer'] = composer;
    if (cover != null) {
      map['cover'] = cover.toJson();
    }
    map['genres'] = genres;
    if (counts != null) {
      map['counts'] = counts.toJson();
    }
    if (ratings != null) {
      map['ratings'] = ratings.toJson();
    }
    if (links != null) {
      map['links'] = links.map((v) => v.toJson()).toList();
    }
    map['uid'] = uid;
    map['kind'] = kind;
    map['revision'] = revision;
    map['snapshot'] = snapshot;
    map['visibility'] = visibility;
    map['collective'] = collective;
    map['created'] = created;
    map['modified'] = modified;
    map['isBanner'] = isBanner;
    map['isPremiere'] = isPremiere;
    if (owner != null) {
      map['owner'] = owner.toJson();
    }
    if (topArtist != null) {
      map['topArtist'] = topArtist.map((v) => v.toJson()).toList();
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
    this.month,
    this.day,
    this.week,});

  Ratings.fromJson(dynamic json) {
    month = json['month'];
    day = json['day'];
    week = json['week'];
  }
  num month;
  num day;
  num week;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['month'] = month;
    map['day'] = day;
    map['week'] = week;
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tracks'] = tracks;
    map['directAlbums'] = directAlbums;
    map['alsoAlbums'] = alsoAlbums;
    map['alsoTracks'] = alsoTracks;
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

