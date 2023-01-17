import '../cover.dart';
import 'count.dart';
import 'link.dart';
import 'rating.dart';

class BriefInfo {
  BriefInfo({
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
    this.ticketsAvailable,});

  BriefInfo.fromJson(dynamic json) {
    id = json['id'].toString();
    name = json['name'];
    various = json['various'];
    composer = json['composer'];
    cover = json['cover'] != null ? Cover.fromJson(json['cover']) : null;
    ogImage = json['ogImage'];
    genres = json['genres'] != null ? json['genres'].cast<String>() : [];
    counts = json['counts'] != null ? Count.fromJson(json['counts']) : null;
    available = json['available'];
    ratings = json['ratings'] != null ? Rating.fromJson(json['ratings']) : null;
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links?.add(Link.fromJson(v));
      });
    }
    ticketsAvailable = json['ticketsAvailable'];
  }
  String? id;
  String? name;
  bool? various;
  bool? composer;
  Cover? cover;
  String? ogImage;
  List<String>? genres;
  Count? counts;
  bool? available;
  Rating? ratings;
  List<Link>? links;
  bool? ticketsAvailable;
  BriefInfo copyWith({  String? id,
    String? name,
    bool? various,
    bool? composer,
    Cover? cover,
    String? ogImage,
    List<String>? genres,
    Count? counts,
    bool? available,
    Rating? ratings,
    List<Link>? links,
    bool? ticketsAvailable,
  }) => BriefInfo(  id: id ?? this.id,
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
    ticketsAvailable: ticketsAvailable ?? this.ticketsAvailable,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['various'] = various;
    map['composer'] = composer;
    if (cover != null) {
      map['cover'] = cover?.toJson();
    }
    map['ogImage'] = ogImage;
    map['genres'] = genres;
    if (counts != null) {
      map['counts'] = counts?.toJson();
    }
    map['available'] = available;
    if (ratings != null) {
      map['ratings'] = ratings?.toJson();
    }
    if (links != null) {
      map['links'] = links?.map((v) => v.toJson()).toList();
    }
    map['ticketsAvailable'] = ticketsAvailable;
    return map;
  }

}