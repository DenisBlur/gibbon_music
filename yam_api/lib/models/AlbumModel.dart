class AlbumModel {
  final int? id;
  final String? title;
  final String? metaType;
  final int? year;
  final String? coverUri;
  final String? ogImage;
  final String? genre;
  final List<dynamic>? buy;
  final int? trackCount;
  final int? likesCount;
  final bool? recent;
  final bool? veryImportant;
  final List<ArtistsBean>? artists;
  final List<LabelsBean>? labels;
  final bool? available;
  final bool? availableForPremiumUsers;
  final bool? availableForMobile;
  final bool? availablePartially;
  final List<int>? bests;
  final String? sortOrder;
  final List<Map<String, dynamic>>? volumes;
  final PagerBean? pager;

  AlbumModel(this.id, this.title, this.metaType, this.year, this.coverUri, this.ogImage, this.genre, this.buy, this.trackCount, this.likesCount, this.recent, this.veryImportant, this.artists, this.labels, this.available, this.availableForPremiumUsers, this.availableForMobile, this.availablePartially, this.bests, this.sortOrder, this.volumes, this.pager);

  static AlbumModel fromMap(Map<String, dynamic> map) {
    AlbumModel albumModelBean = AlbumModel(
     map['id'],
     map['title'],
     map['metaType'],
     map['year'],
     map['coverUri'],
     map['ogImage'],
     map['genre'],
     map['buy'],
     map['trackCount'],
     map['likesCount'],
     map['recent'],
     map['veryImportant'],
     map['artists']!=null ? ([...(map['artists'] as List).map((o) => ArtistsBean.fromMap(o))]) : null,
     map['labels']!=null ? ([...(map['labels'] as List).map((o) => LabelsBean.fromMap(o))]) : null,
     map['available'],
     map['availableForPremiumUsers'],
     map['availableForMobile'],
     map['availablePartially'],
     map['bests']!=null ? ([...(map['bests'] as List).map((o) => int.tryParse(o.toString()) ?? 0)]) : null,
     map['sortOrder'],
     map['volumes']!=null ? ([...(map['volumes'] as List).map((o) => o)]) : null,
     map['pager']!=null ? PagerBean.fromMap(map['pager']) : null,
    );
    return albumModelBean;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "metaType": metaType,
    "year": year,
    "coverUri": coverUri,
    "ogImage": ogImage,
    "genre": genre,
    "buy": buy,
    "trackCount": trackCount,
    "likesCount": likesCount,
    "recent": recent,
    "veryImportant": veryImportant,
    "artists": artists?.map((o)=>o.toJson()).toList(growable: false),
    "labels": labels?.map((o)=>o.toJson()).toList(growable: false),
    "available": available,
    "availableForPremiumUsers": availableForPremiumUsers,
    "availableForMobile": availableForMobile,
    "availablePartially": availablePartially,
    "bests": bests,
    "sortOrder": sortOrder,
    "volumes": volumes,
    "pager": pager?.toJson(),
  }..removeWhere((k,v)=>v==null);
}

class PagerBean {
  final int? total;
  final int? page;
  final int? perPage;

  PagerBean(this.total, this.page, this.perPage);

  static PagerBean fromMap(Map<String, dynamic> map) {
    PagerBean pagerBean = PagerBean(
     map['total'],
     map['page'],
     map['perPage'],
    );
    return pagerBean;
  }

  Map toJson() => {
    "total": total,
    "page": page,
    "perPage": perPage,
  }..removeWhere((k,v)=>v==null);
}

class VolumesBean {

  VolumesBean();

  static VolumesBean fromMap(Map<String, dynamic> map) {
    VolumesBean volumesBean = VolumesBean(
    );
    return volumesBean;
  }

  Map toJson() => {
  }..removeWhere((k,v)=>v==null);
}

class LabelsBean {
  final int? id;
  final String? name;

  LabelsBean(this.id, this.name);

  static LabelsBean fromMap(Map<String, dynamic> map) {
    LabelsBean labelsBean = LabelsBean(
     map['id'],
     map['name'],
    );
    return labelsBean;
  }

  Map toJson() => {
    "id": id,
    "name": name,
  }..removeWhere((k,v)=>v==null);
}

class ArtistsBean {
  final int? id;
  final String? name;
  final bool? various;
  final bool? composer;
  final CoverBean? cover;
  final List<dynamic>? genres;

  ArtistsBean(this.id, this.name, this.various, this.composer, this.cover, this.genres);

  static ArtistsBean fromMap(Map<String, dynamic> map) {
    ArtistsBean artistsBean = ArtistsBean(
     map['id'],
     map['name'],
     map['various'],
     map['composer'],
     map['cover']!=null ? CoverBean.fromMap(map['cover']) : null,
     map['genres'],
    );
    return artistsBean;
  }

  Map toJson() => {
    "id": id,
    "name": name,
    "various": various,
    "composer": composer,
    "cover": cover?.toJson(),
    "genres": genres,
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