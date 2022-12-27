/// uid : 139954184
/// kind : 1029
/// title : "Хиты FM"
/// description : "На обложке: Туве Лу\r\nПесни из чартов российских радиостанций."
/// descriptionFormatted : "На обложке: Туве Лу<br/>Песни из чартов российских радиостанций."
/// revision : 6153
/// snapshot : 1555
/// visibility : "public"
/// collective : false
/// created : "2013-10-24T16:28:54+00:00"
/// modified : "2022-09-20T07:37:51+00:00"
/// available : true
/// backgroundColor : ""
/// textColor : "#000000"
/// image : ""
/// isBanner : false
/// isPremiere : false
/// owner : {"uid":139954184,"login":"music.partners","name":"Музыкальная редакция","sex":"female","verified":true}
/// trackCount : 87
/// cover : {"type":"pic","dir":"/get-music-user-playlist/59900/139954184.1029.53313/","version":"1663659421649","uri":"avatars.yandex.net/get-music-user-playlist/51766/139954184.1029.20416ru/%%?1663659421649","custom":true}
/// likesCount : 474642
/// topArtist : []

class PlaylistPayload {
  PlaylistPayload({
    num? uid,
    num? kind,
    String? title,
    String? description,
    String? descriptionFormatted,
    num? revision,
    num? snapshot,
    String? visibility,
    bool? collective,
    String? created,
    String? modified,
    bool? available,
    String? backgroundColor,
    String? textColor,
    String? image,
    bool? isBanner,
    bool? isPremiere,
    Owner? owner,
    num? trackCount,
    Cover? cover,
    num? likesCount,
    List<dynamic>? topArtist,}){
    _uid = uid;
    _kind = kind;
    _title = title;
    _description = description;
    _descriptionFormatted = descriptionFormatted;
    _revision = revision;
    _snapshot = snapshot;
    _visibility = visibility;
    _collective = collective;
    _created = created;
    _modified = modified;
    _available = available;
    _backgroundColor = backgroundColor;
    _textColor = textColor;
    _image = image;
    _isBanner = isBanner;
    _isPremiere = isPremiere;
    _owner = owner;
    _trackCount = trackCount;
    _cover = cover;
    _likesCount = likesCount;
  }

  PlaylistPayload.fromJson(dynamic json) {
    _uid = json['uid'];
    _kind = json['kind'];
    _title = json['title'];
    _description = json['description'];
    _descriptionFormatted = json['descriptionFormatted'];
    _revision = json['revision'];
    _snapshot = json['snapshot'];
    _visibility = json['visibility'];
    _collective = json['collective'];
    _created = json['created'];
    _modified = json['modified'];
    _available = json['available'];
    _backgroundColor = json['backgroundColor'];
    _textColor = json['textColor'];
    _image = json['image'];
    _isBanner = json['isBanner'];
    _isPremiere = json['isPremiere'];
    _owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    _trackCount = json['trackCount'];
    _cover = json['cover'] != null ? Cover.fromJson(json['cover']) : null;
    _likesCount = json['likesCount'];
  }
 static num? _uid;
 static num? _kind;
 static String? _title;
 static String? _description;
 static String? _descriptionFormatted;
 static num? _revision;
 static num? _snapshot;
 static String? _visibility;
 static bool? _collective;
 static String? _created;
 static String? _modified;
 static bool? _available;
 static String? _backgroundColor;
 static String? _textColor;
 static String? _image;
 static bool? _isBanner;
 static bool? _isPremiere;
 static Owner? _owner;
 static num? _trackCount;
 static Cover? _cover;
 static num? _likesCount;
  PlaylistPayload copyWith({  num? uid,
    num? kind,
    String? title,
    String? description,
    String? descriptionFormatted,
    num? revision,
    num? snapshot,
    String? visibility,
    bool? collective,
    String? created,
    String? modified,
    bool? available,
    String? backgroundColor,
    String? textColor,
    String? image,
    bool? isBanner,
    bool? isPremiere,
    Owner? owner,
    num? trackCount,
    Cover? cover,
    num? likesCount,
    List<dynamic>? topArtist,
  }) => PlaylistPayload(  uid: uid ?? _uid,
    kind: kind ?? _kind,
    title: title ?? _title,
    description: description ?? _description,
    descriptionFormatted: descriptionFormatted ?? _descriptionFormatted,
    revision: revision ?? _revision,
    snapshot: snapshot ?? _snapshot,
    visibility: visibility ?? _visibility,
    collective: collective ?? _collective,
    created: created ?? _created,
    modified: modified ?? _modified,
    available: available ?? _available,
    backgroundColor: backgroundColor ?? _backgroundColor,
    textColor: textColor ?? _textColor,
    image: image ?? _image,
    isBanner: isBanner ?? _isBanner,
    isPremiere: isPremiere ?? _isPremiere,
    owner: owner ?? _owner,
    trackCount: trackCount ?? _trackCount,
    cover: cover ?? _cover,
    likesCount: likesCount ?? _likesCount,
  );
  num? get uid => _uid;
  num? get kind => _kind;
  String? get title => _title;
  String? get description => _description;
  String? get descriptionFormatted => _descriptionFormatted;
  num? get revision => _revision;
  num? get snapshot => _snapshot;
  String? get visibility => _visibility;
  bool? get collective => _collective;
  String? get created => _created;
  String? get modified => _modified;
  bool? get available => _available;
  String? get backgroundColor => _backgroundColor;
  String? get textColor => _textColor;
  String? get image => _image;
  bool? get isBanner => _isBanner;
  bool? get isPremiere => _isPremiere;
  Owner? get owner => _owner;
  num? get trackCount => _trackCount;
  Cover? get cover => _cover;
  num? get likesCount => _likesCount;

  static Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = _uid;
    map['kind'] = _kind;
    map['title'] = _title;
    map['description'] = _description;
    map['descriptionFormatted'] = _descriptionFormatted;
    map['revision'] = _revision;
    map['snapshot'] = _snapshot;
    map['visibility'] = _visibility;
    map['collective'] = _collective;
    map['created'] = _created;
    map['modified'] = _modified;
    map['available'] = _available;
    map['backgroundColor'] = _backgroundColor;
    map['textColor'] = _textColor;
    map['image'] = _image;
    map['isBanner'] = _isBanner;
    map['isPremiere'] = _isPremiere;
    if (_owner != null) {
      map['owner'] = _owner?.toJson();
    }
    map['trackCount'] = _trackCount;
    if (_cover != null) {
      map['cover'] = _cover?.toJson();
    }
    map['likesCount'] = _likesCount;
    return map;
  }

}

/// type : "pic"
/// dir : "/get-music-user-playlist/59900/139954184.1029.53313/"
/// version : "1663659421649"
/// uri : "avatars.yandex.net/get-music-user-playlist/51766/139954184.1029.20416ru/%%?1663659421649"
/// custom : true

class Cover {
  Cover({
    String? type,
    String? dir,
    String? version,
    String? uri,
    bool? custom,}){
    _type = type;
    _dir = dir;
    _version = version;
    _uri = uri;
    _custom = custom;
  }

  Cover.fromJson(dynamic json) {
    _type = json['type'];
    _dir = json['dir'];
    _version = json['version'];
    _uri = json['uri'];
    _custom = json['custom'];
  }
  String? _type;
  String? _dir;
  String? _version;
  String? _uri;
  bool? _custom;
  Cover copyWith({  String? type,
    String? dir,
    String? version,
    String? uri,
    bool? custom,
  }) => Cover(  type: type ?? _type,
    dir: dir ?? _dir,
    version: version ?? _version,
    uri: uri ?? _uri,
    custom: custom ?? _custom,
  );
  String? get type => _type;
  String? get dir => _dir;
  String? get version => _version;
  String? get uri => _uri;
  bool? get custom => _custom;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['dir'] = _dir;
    map['version'] = _version;
    map['uri'] = _uri;
    map['custom'] = _custom;
    return map;
  }

}

/// uid : 139954184
/// login : "music.partners"
/// name : "Музыкальная редакция"
/// sex : "female"
/// verified : true

class Owner {
  Owner({
    num? uid,
    String? login,
    String? name,
    String? sex,
    bool? verified,}){
    _uid = uid;
    _login = login;
    _name = name;
    _sex = sex;
    _verified = verified;
  }

  Owner.fromJson(dynamic json) {
    _uid = json['uid'];
    _login = json['login'];
    _name = json['name'];
    _sex = json['sex'];
    _verified = json['verified'];
  }
  num? _uid;
  String? _login;
  String? _name;
  String? _sex;
  bool? _verified;
  Owner copyWith({  num? uid,
    String? login,
    String? name,
    String? sex,
    bool? verified,
  }) => Owner(  uid: uid ?? _uid,
    login: login ?? _login,
    name: name ?? _name,
    sex: sex ?? _sex,
    verified: verified ?? _verified,
  );
  num? get uid => _uid;
  String? get login => _login;
  String? get name => _name;
  String? get sex => _sex;
  bool? get verified => _verified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = _uid;
    map['login'] = _login;
    map['name'] = _name;
    map['sex'] = _sex;
    map['verified'] = _verified;
    return map;
  }

}