import 'package:yam_api/models/PlaylistModel.dart';
import 'package:yam_api/models/TrackModel.dart';

import '../InvocationInfoBean.dart';

class Charts {
  final InvocationInfoBeanStr? invocationInfo;
  final ResultBean? result;

  Charts(this.invocationInfo, this.result);

  static Charts fromMap(Map<String, dynamic> map) {
    Charts chartsBean = Charts(
     map['invocationInfo']!=null ? InvocationInfoBeanStr.fromMap(map['invocationInfo']) : null,
     map['result']!=null ? ResultBean.fromMap(map['result']) : null,
    );
    return chartsBean;
  }

  Map<String, dynamic> toJson() => {
    "invocationInfo": invocationInfo?.toJson(),
    "result": result?.toJson(),
  }..removeWhere((k,v)=>v==null);
}

class ResultBean {
  final String? id;
  final String? type;
  final String? typeForFrom;
  final String? title;
  final String? chartDescription;
  final MenuBean? menu;
  final ChartBean? chart;

  ResultBean(this.id, this.type, this.typeForFrom, this.title, this.chartDescription, this.menu, this.chart);

  static ResultBean fromMap(Map<String, dynamic> map) {
    ResultBean resultBean = ResultBean(
     map['id'],
     map['type'],
     map['typeForFrom'],
     map['title'],
     map['chartDescription'],
     map['menu']!=null ? MenuBean.fromMap(map['menu']) : null,
     map['chart']!=null ? ChartBean.fromMap(map['chart']) : null,
    );
    return resultBean;
  }

  Map toJson() => {
    "id": id,
    "type": type,
    "typeForFrom": typeForFrom,
    "title": title,
    "chartDescription": chartDescription,
    "menu": menu?.toJson(),
    "chart": chart?.toJson(),
  }..removeWhere((k,v)=>v==null);
}

class ChartBean {
  final OwnerBean? owner;
  final String? playlistUuid;
  final bool? available;
  final int? uid;
  final int? kind;
  final String? title;
  final String? description;
  final String? descriptionFormatted;
  final int? revision;
  final int? snapshot;
  final int? trackCount;
  final String? visibility;
  final bool? collective;
  final String? created;
  final String? modified;
  final bool? isBanner;
  final bool? isPremiere;
  final int? durationMs;
  final CoverBean? cover;
  final String? ogImage;
  final List<TrackModel>? tracks;
  final List<dynamic>? tags;
  final int? likesCount;
  final List<PlaylistModel>? similarPlaylists;

  ChartBean(this.owner, this.playlistUuid, this.available, this.uid, this.kind, this.title, this.description, this.descriptionFormatted, this.revision, this.snapshot, this.trackCount, this.visibility, this.collective, this.created, this.modified, this.isBanner, this.isPremiere, this.durationMs, this.cover, this.ogImage, this.tracks, this.tags, this.likesCount, this.similarPlaylists);

  static ChartBean fromMap(Map<String, dynamic> map) {
    ChartBean chartBean = ChartBean(
     map['owner']!=null ? OwnerBean.fromMap(map['owner']) : null,
     map['playlistUuid'],
     map['available'],
     map['uid'],
     map['kind'],
     map['title'],
     map['description'],
     map['descriptionFormatted'],
     map['revision'],
     map['snapshot'],
     map['trackCount'],
     map['visibility'],
     map['collective'],
     map['created'],
     map['modified'],
     map['isBanner'],
     map['isPremiere'],
     map['durationMs'],
     map['cover']!=null ? CoverBean.fromMap(map['cover']) : null,
     map['ogImage'],
     map['tracks']!=null ? ([...(map['tracks'] as List).map((o) => TrackModel.fromMap(o))]) : null,
     map['tags'],
     map['likesCount'],
     map['similarPlaylists']!=null ? ([...(map['similarPlaylists'] as List).map((o) => PlaylistModel.fromMap(o))]) : null,
    );
    return chartBean;
  }

  Map toJson() => {
    "owner": owner?.toJson(),
    "playlistUuid": playlistUuid,
    "available": available,
    "uid": uid,
    "kind": kind,
    "title": title,
    "description": description,
    "descriptionFormatted": descriptionFormatted,
    "revision": revision,
    "snapshot": snapshot,
    "trackCount": trackCount,
    "visibility": visibility,
    "collective": collective,
    "created": created,
    "modified": modified,
    "isBanner": isBanner,
    "isPremiere": isPremiere,
    "durationMs": durationMs,
    "cover": cover?.toJson(),
    "ogImage": ogImage,
    "tracks": tracks,
    "tags": tags,
    "likesCount": likesCount,
    "similarPlaylists": similarPlaylists,
  }..removeWhere((k,v)=>v==null);
}

class CoverBean {
  final String? type;
  final String? dir;
  final String? version;
  final String? uri;
  final bool? custom;

  CoverBean(this.type, this.dir, this.version, this.uri, this.custom);

  static CoverBean fromMap(Map<String, dynamic> map) {
    CoverBean coverBean = CoverBean(
     map['type'],
     map['dir'],
     map['version'],
     map['uri'],
     map['custom'],
    );
    return coverBean;
  }

  Map toJson() => {
    "type": type,
    "dir": dir,
    "version": version,
    "uri": uri,
    "custom": custom,
  }..removeWhere((k,v)=>v==null);
}

class OwnerBean {
  final int? uid;
  final String? login;
  final String? name;
  final String? sex;
  final bool? verified;

  OwnerBean(this.uid, this.login, this.name, this.sex, this.verified);

  static OwnerBean fromMap(Map<String, dynamic> map) {
    OwnerBean ownerBean = OwnerBean(
     map['uid'],
     map['login'],
     map['name'],
     map['sex'],
     map['verified'],
    );
    return ownerBean;
  }

  Map toJson() => {
    "uid": uid,
    "login": login,
    "name": name,
    "sex": sex,
    "verified": verified,
  }..removeWhere((k,v)=>v==null);
}

class MenuBean {
  final List<ItemsBean>? items;

  MenuBean(this.items);

  static MenuBean fromMap(Map<String, dynamic> map) {
    MenuBean menuBean = MenuBean(
     map['items']!=null ? ([...(map['items'] as List).map((o) => ItemsBean.fromMap(o))]) : null,
    );
    return menuBean;
  }

  Map toJson() => {
    "items": items?.map((o)=>o.toJson()).toList(growable: false),
  }..removeWhere((k,v)=>v==null);
}

class ItemsBean {
  final String? title;
  final String? url;
  final bool? selected;

  ItemsBean(this.title, this.url, this.selected);

  static ItemsBean fromMap(Map<String, dynamic> map) {
    ItemsBean itemsBean = ItemsBean(
     map['title'],
     map['url'],
     map['selected'],
    );
    return itemsBean;
  }

  Map toJson() => {
    "title": title,
    "url": url,
    "selected": selected,
  }..removeWhere((k,v)=>v==null);
}