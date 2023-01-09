import 'M_Cover.dart';

class MArtist {
  MArtist({
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
      this.links,});

  MArtist.fromJson(dynamic json) {
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
MArtist copyWith({  String id,
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
}) => MArtist(  id: id ?? this.id,
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