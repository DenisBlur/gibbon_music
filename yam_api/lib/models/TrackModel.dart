class TrackModel {
  final int? id;
  final TrackBean? track;
  final String? timestamp;
  final int? playCount;
  final ChartBean? chart;
  final bool? recent;

  TrackModel(this.id, this.track, this.timestamp, this.playCount, this.chart,
      this.recent);

  static TrackModel fromMap(Map<String, dynamic> map) {
    TrackModel chartsBean = TrackModel(
      map['id'],
      map['track'] != null ? TrackBean.fromMap(map['track']) : null,
      map['timestamp'],
      map['playCount'],
      map['chart'] != null ? ChartBean.fromMap(map['chart']) : null,
      map['recent'],
    );
    return chartsBean;
  }

  Map toJson() => {
        "id": id,
        "track": track?.toJson(),
        "timestamp": timestamp,
        "playCount": playCount,
        "chart": chart?.toJson(),
        "recent": recent,
      }..removeWhere((k, v) => v == null);
}

class ChartBean {
  final int? position;
  final String? progress;
  final int? listeners;
  final int? shift;
  final String? bgColor;

  ChartBean(
      this.position, this.progress, this.listeners, this.shift, this.bgColor);

  static ChartBean fromMap(Map<String, dynamic> map) {
    ChartBean chartBean = ChartBean(
      map['position'],
      map['progress'],
      map['listeners'],
      map['shift'],
      map['bgColor'],
    );
    return chartBean;
  }

  Map toJson() => {
        "position": position,
        "progress": progress,
        "listeners": listeners,
        "shift": shift,
        "bgColor": bgColor,
      }..removeWhere((k, v) => v == null);
}

class TrackBean {
  final String? id;
  final String? realId;
  final String? title;
  final String? trackSource;
  final MajorBean? major;
  final bool? available;
  final bool? availableForPremiumUsers;
  final bool? availableFullWithoutPermission;
  final int? durationMs;
  final String? storageDir;
  final int? fileSize;
  final R128Bean? r128;
  final int? previewDurationMs;
  final List<ArtistsBean>? artists;
  final List<AlbumsBean>? albums;
  final String? coverUri;
  final String? ogImage;
  final bool? lyricsAvailable;
  final LyricsInfoBean? lyricsInfo;
  final String? type;
  final bool? rememberPosition;
  final String? backgroundVideoUri;
  final String? trackSharingFlag;

  TrackBean(
      this.id,
      this.realId,
      this.title,
      this.trackSource,
      this.major,
      this.available,
      this.availableForPremiumUsers,
      this.availableFullWithoutPermission,
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
      this.backgroundVideoUri);

  static TrackBean fromMap(Map<String, dynamic> map) {
    TrackBean trackBean = TrackBean(
      map['id'],
      map['realId'],
      map['title'],
      map['trackSource'],
      map['major'] != null ? MajorBean.fromMap(map['major']) : null,
      map['available'],
      map['availableForPremiumUsers'],
      map['availableFullWithoutPermission'],
      map['durationMs'],
      map['storageDir'],
      map['fileSize'],
      map['r128'] != null ? R128Bean.fromMap(map['r128']) : null,
      map['previewDurationMs'],
      map['artists'] != null
          ? ([...(map['artists'] as List).map((o) => ArtistsBean.fromMap(o))])
          : null,
      map['albums'] != null
          ? ([...(map['albums'] as List).map((o) => AlbumsBean.fromMap(o))])
          : null,
      map['coverUri'],
      map['ogImage'],
      map['lyricsAvailable'],
      map['lyricsInfo'] != null
          ? LyricsInfoBean.fromMap(map['lyricsInfo'])
          : null,
      map['type'],
      map['rememberPosition'],
      map['backgroundVideoUri'],
      map['trackSharingFlag'],
    );
    return trackBean;
  }

  Map toJson() => {
        "id": id,
        "realId": realId,
        "title": title,
        "trackSource": trackSource,
        "major": major?.toJson(),
        "available": available,
        "availableForPremiumUsers": availableForPremiumUsers,
        "availableFullWithoutPermission": availableFullWithoutPermission,
        "durationMs": durationMs,
        "storageDir": storageDir,
        "fileSize": fileSize,
        "r128": r128?.toJson(),
        "previewDurationMs": previewDurationMs,
        "artists": artists?.map((o) => o.toJson()).toList(growable: false),
        "albums": albums?.map((o) => o.toJson()).toList(growable: false),
        "coverUri": coverUri,
        "ogImage": ogImage,
        "lyricsAvailable": lyricsAvailable,
        "lyricsInfo": lyricsInfo?.toJson(),
        "type": type,
        "rememberPosition": rememberPosition,
        "backgroundVideoUri": backgroundVideoUri,
        "trackSharingFlag": trackSharingFlag,
      }..removeWhere((k, v) => v == null);
}

class LyricsInfoBean {
  final bool? hasAvailableSyncLyrics;
  final bool? hasAvailableTextLyrics;

  LyricsInfoBean(this.hasAvailableSyncLyrics, this.hasAvailableTextLyrics);

  static LyricsInfoBean fromMap(Map<String, dynamic> map) {
    LyricsInfoBean lyricsInfoBean = LyricsInfoBean(
      map['hasAvailableSyncLyrics'],
      map['hasAvailableTextLyrics'],
    );
    return lyricsInfoBean;
  }

  Map toJson() => {
        "hasAvailableSyncLyrics": hasAvailableSyncLyrics,
        "hasAvailableTextLyrics": hasAvailableTextLyrics,
      }..removeWhere((k, v) => v == null);
}

class AlbumsBean {
  final int? id;
  final String? title;
  final String? type;
  final String? metaType;
  final int? year;
  final String? releaseDate;
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
  final List<dynamic>? bests;
  final TrackPositionBean? trackPosition;

  AlbumsBean(
      this.id,
      this.title,
      this.type,
      this.metaType,
      this.year,
      this.releaseDate,
      this.coverUri,
      this.ogImage,
      this.genre,
      this.buy,
      this.trackCount,
      this.likesCount,
      this.recent,
      this.veryImportant,
      this.artists,
      this.labels,
      this.available,
      this.availableForPremiumUsers,
      this.availableForMobile,
      this.availablePartially,
      this.bests,
      this.trackPosition);

  static AlbumsBean fromMap(Map<String, dynamic> map) {
    AlbumsBean albumsBean = AlbumsBean(
      map['id'],
      map['title'],
      map['type'],
      map['metaType'],
      map['year'],
      map['releaseDate'],
      map['coverUri'],
      map['ogImage'],
      map['genre'],
      map['buy'],
      map['trackCount'],
      map['likesCount'],
      map['recent'],
      map['veryImportant'],
      map['artists'] != null
          ? ([...(map['artists'] as List).map((o) => ArtistsBean.fromMap(o))])
          : null,
      map['labels'] != null
          ? ([...(map['labels'] as List).map((o) => LabelsBean.fromMap(o))])
          : null,
      map['available'],
      map['availableForPremiumUsers'],
      map['availableForMobile'],
      map['availablePartially'],
      map['bests'],
      map['trackPosition'] != null
          ? TrackPositionBean.fromMap(map['trackPosition'])
          : null,
    );
    return albumsBean;
  }

  Map toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "metaType": metaType,
        "year": year,
        "releaseDate": releaseDate,
        "coverUri": coverUri,
        "ogImage": ogImage,
        "genre": genre,
        "buy": buy,
        "trackCount": trackCount,
        "likesCount": likesCount,
        "recent": recent,
        "veryImportant": veryImportant,
        "artists": artists?.map((o) => o.toJson()).toList(growable: false),
        "labels": labels?.map((o) => o.toJson()).toList(growable: false),
        "available": available,
        "availableForPremiumUsers": availableForPremiumUsers,
        "availableForMobile": availableForMobile,
        "availablePartially": availablePartially,
        "bests": bests,
        "trackPosition": trackPosition?.toJson(),
      }..removeWhere((k, v) => v == null);
}

class TrackPositionBean {
  final int? volume;
  final int? index;

  TrackPositionBean(this.volume, this.index);

  static TrackPositionBean fromMap(Map<String, dynamic> map) {
    TrackPositionBean trackPositionBean = TrackPositionBean(
      map['volume'],
      map['index'],
    );
    return trackPositionBean;
  }

  Map toJson() => {
        "volume": volume,
        "index": index,
      }..removeWhere((k, v) => v == null);
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
      }..removeWhere((k, v) => v == null);
}

class ArtistsBean {
  final int? id;
  final String? name;
  final bool? various;
  final bool? composer;
  final CoverBean? cover;
  final List<dynamic>? genres;

  ArtistsBean(
      this.id, this.name, this.various, this.composer, this.cover, this.genres);

  static ArtistsBean fromMap(Map<String, dynamic> map) {
    ArtistsBean artistsBean = ArtistsBean(
      map['id'],
      map['name'],
      map['various'],
      map['composer'],
      map['cover'] != null ? CoverBean.fromMap(map['cover']) : null,
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
      }..removeWhere((k, v) => v == null);
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
      }..removeWhere((k, v) => v == null);
}

class R128Bean {
  final double? i;
  final double? tp;

  R128Bean(this.i, this.tp);

  static R128Bean fromMap(Map<String, dynamic> map) {
    R128Bean r128Bean = R128Bean(
      map['i'],
      map['tp'],
    );
    return r128Bean;
  }

  Map toJson() => {
        "i": i,
        "tp": tp,
      }..removeWhere((k, v) => v == null);
}

class MajorBean {
  final int? id;
  final String? name;

  MajorBean(this.id, this.name);

  static MajorBean fromMap(Map<String, dynamic> map) {
    MajorBean majorBean = MajorBean(
      map['id'],
      map['name'],
    );
    return majorBean;
  }

  Map toJson() => {
        "id": id,
        "name": name,
      }..removeWhere((k, v) => v == null);
}
