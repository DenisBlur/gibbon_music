class ArtistModel {
  final String? id;
  final String? name;
  final bool? various;
  final bool? composer;
  final CoverBean? cover;
  final String? ogImage;
  final List<String>? genres;
  final CountsBean? counts;
  final bool? available;
  final RatingsBean? ratings;
  final List<LinksBean>? links;

  ArtistModel(this.id, this.name, this.various, this.composer, this.cover, this.ogImage, this.genres, this.counts, this.available, this.ratings, this.links);

  static ArtistModel fromMap(Map<String, dynamic> map) {
    ArtistModel artistModelBean = ArtistModel(
     map['id'],
     map['name'],
     map['various'],
     map['composer'],
     map['cover']!=null ? CoverBean.fromMap(map['cover']) : null,
     map['ogImage'],
     map['genres']!=null ? ([...(map['genres'] as List).map((o) => o.toString())]) : null,
     map['counts']!=null ? CountsBean.fromMap(map['counts']) : null,
     map['available'],
     map['ratings']!=null ? RatingsBean.fromMap(map['ratings']) : null,
     map['links']!=null ? ([...(map['links'] as List).map((o) => LinksBean.fromMap(o))]) : null,
    );
    return artistModelBean;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "various": various,
    "composer": composer,
    "cover": cover?.toJson(),
    "ogImage": ogImage,
    "genres": genres,
    "counts": counts?.toJson(),
    "available": available,
    "ratings": ratings?.toJson(),
    "links": links?.map((o)=>o.toJson()).toList(growable: false),
  }..removeWhere((k,v)=>v==null);
}

class LinksBean {
  final String? title;
  final String? href;
  final String? type;

  LinksBean(this.title, this.href, this.type);

  static LinksBean fromMap(Map<String, dynamic> map) {
    LinksBean linksBean = LinksBean(
     map['title'],
     map['href'],
     map['type'],
    );
    return linksBean;
  }

  Map toJson() => {
    "title": title,
    "href": href,
    "type": type,
  }..removeWhere((k,v)=>v==null);
}

class RatingsBean {
  final int? day;
  final int? week;
  final int? month;

  RatingsBean(this.day, this.week, this.month);

  static RatingsBean fromMap(Map<String, dynamic> map) {
    RatingsBean ratingsBean = RatingsBean(
     map['day'],
     map['week'],
     map['month'],
    );
    return ratingsBean;
  }

  Map toJson() => {
    "day": day,
    "week": week,
    "month": month,
  }..removeWhere((k,v)=>v==null);
}

class CountsBean {
  final int? tracks;
  final int? directAlbums;
  final int? alsoAlbums;
  final int? alsoTracks;

  CountsBean(this.tracks, this.directAlbums, this.alsoAlbums, this.alsoTracks);

  static CountsBean fromMap(Map<String, dynamic> map) {
    CountsBean countsBean = CountsBean(
     map['tracks'],
     map['directAlbums'],
     map['alsoAlbums'],
     map['alsoTracks'],
    );
    return countsBean;
  }

  Map toJson() => {
    "tracks": tracks,
    "directAlbums": directAlbums,
    "alsoAlbums": alsoAlbums,
    "alsoTracks": alsoTracks,
  }..removeWhere((k,v)=>v==null);
}

class CoverBean {
  final String? type;
  final String? prefix;
  final String? uri;

  CoverBean(this.type, this.prefix, this.uri);

  static CoverBean fromMap(Map<String, dynamic> map) {
    CoverBean coverBean = CoverBean(
     map['type'],
     map['prefix'],
     map['uri'],
    );
    return coverBean;
  }

  Map toJson() => {
    "type": type,
    "prefix": prefix,
    "uri": uri,
  }..removeWhere((k,v)=>v==null);
}