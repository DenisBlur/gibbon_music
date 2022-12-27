class PlaylistModel {
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
  final String? backgroundColor;
  final String? textColor;
  final String? image;
  final bool? isBanner;
  final bool? isPremiere;
  final int? durationMs;
  final CoverBean? cover;
  final String? ogImage;
  final List<TagsBean>? tags;
  final int? likesCount;
  final ActionButtonBean? actionButton;

  PlaylistModel(this.owner, this.playlistUuid, this.available, this.uid, this.kind, this.title, this.description, this.descriptionFormatted, this.revision, this.snapshot, this.trackCount, this.visibility, this.collective, this.created, this.modified, this.backgroundColor, this.textColor, this.image, this.isBanner, this.isPremiere, this.durationMs, this.cover, this.ogImage, this.tags, this.likesCount, this.actionButton);

  static PlaylistModel fromMap(Map<String, dynamic> map) {
    PlaylistModel albumModelBean = PlaylistModel(
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
     map['backgroundColor'],
     map['textColor'],
     map['image'],
     map['isBanner'],
     map['isPremiere'],
     map['durationMs'],
     map['cover']!=null ? CoverBean.fromMap(map['cover']) : null,
     map['ogImage'],
     map['tags']!=null ? ([...(map['tags'] as List).map((o) => TagsBean.fromMap(o))]) : null,
     map['likesCount'],
     map['actionButton']!=null ? ActionButtonBean.fromMap(map['actionButton']) : null,
    );
    return albumModelBean;
  }

  Map<String, dynamic> toJson() => {
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
    "backgroundColor": backgroundColor,
    "textColor": textColor,
    "image": image,
    "isBanner": isBanner,
    "isPremiere": isPremiere,
    "durationMs": durationMs,
    "cover": cover?.toJson(),
    "ogImage": ogImage,
    "tags": tags?.map((o)=>o.toJson()).toList(growable: false),
    "likesCount": likesCount,
    "actionButton": actionButton?.toJson(),
  }..removeWhere((k,v)=>v==null);
}

class ActionButtonBean {
  final String? text;
  final String? url;
  final String? color;

  ActionButtonBean(this.text, this.url, this.color);

  static ActionButtonBean fromMap(Map<String, dynamic> map) {
    ActionButtonBean actionButtonBean = ActionButtonBean(
     map['text'],
     map['url'],
     map['color'],
    );
    return actionButtonBean;
  }

  Map toJson() => {
    "text": text,
    "url": url,
    "color": color,
  }..removeWhere((k,v)=>v==null);
}

class TagsBean {
  final String? id;
  final String? value;

  TagsBean(this.id, this.value);

  static TagsBean fromMap(Map<String, dynamic> map) {
    TagsBean tagsBean = TagsBean(
     map['id'],
     map['value'],
    );
    return tagsBean;
  }

  Map toJson() => {
    "id": id,
    "value": value,
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