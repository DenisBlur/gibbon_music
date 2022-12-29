// /// id : 21852116
// /// title : "Ольга Примаченко. «К себе нежно. Книга о том, как ценить и беречь себя»"
// /// type : "audiobook"
// /// metaType : "podcast"
// /// year : 2022
// /// releaseDate : "2022-03-05T21:00:00+00:00"
// /// coverUri : "avatars.yandex.net/get-music-content/6058982/95db82ac.a.21852116-1/%%"
// /// ogImage : "avatars.yandex.net/get-music-content/6058982/95db82ac.a.21852116-1/%%"
// /// genre : "selfdevelopment"
// /// trackCount : 12
// /// likesCount : 83047
// /// recent : false
// /// veryImportant : false
// /// artists : [{"id":16307922,"name":"Варвара Шалагина","various":false,"composer":false,"cover":{"type":"from-album-cover","prefix":"95db82ac.a.21852116-1","uri":"avatars.yandex.net/get-music-content/6058982/95db82ac.a.21852116-1/%%"},"genres":[]}]
// /// labels : [{"id":4006342,"name":"Издательство «Эксмо»"}]
// /// available : true
// /// availableForPremiumUsers : true
// /// availableForMobile : true
// /// availablePartially : false
// /// bests : []
//
// class AlbumPayload {
//   AlbumPayload({
//     num? id,
//     String? title,
//     String? type,
//     String? metaType,
//     num? year,
//     String? releaseDate,
//     String? coverUri,
//     String? ogImage,
//     String? genre,
//     num? trackCount,
//     num? likesCount,
//     bool? recent,
//     bool? veryImportant,
//     List<Artists>? artists,
//     List<Labels>? labels,
//     bool? available,
//     bool? availableForPremiumUsers,
//     bool? availableForMobile,
//     bool? availablePartially,
//     List<dynamic>? bests,
//   }) {
//     _id = id;
//     _title = title;
//     _type = type;
//     _metaType = metaType;
//     _year = year;
//     _releaseDate = releaseDate;
//     _coverUri = coverUri;
//     _ogImage = ogImage;
//     _genre = genre;
//     _trackCount = trackCount;
//     _likesCount = likesCount;
//     _recent = recent;
//     _veryImportant = veryImportant;
//     _artists = artists;
//     _labels = labels;
//     _available = available;
//     _availableForPremiumUsers = availableForPremiumUsers;
//     _availableForMobile = availableForMobile;
//     _availablePartially = availablePartially;
//     _bests = bests;
//   }
//
//   AlbumPayload.fromJson(dynamic json) {
//     _id = json['id'];
//     _title = json['title'];
//     _type = json['type'];
//     _metaType = json['metaType'];
//     _year = json['year'];
//     _releaseDate = json['releaseDate'];
//     _coverUri = json['coverUri'];
//     _ogImage = json['ogImage'];
//     _genre = json['genre'];
//     _trackCount = json['trackCount'];
//     _likesCount = json['likesCount'];
//     _recent = json['recent'];
//     _veryImportant = json['veryImportant'];
//     if (json['artists'] != null) {
//       _artists = [];
//       json['artists'].forEach((v) {
//         _artists?.add(Artists.fromJson(v));
//       });
//     }
//     if (json['labels'] != null) {
//       _labels = [];
//       json['labels'].forEach((v) {
//         _labels?.add(Labels.fromJson(v));
//       });
//     }
//     _available = json['available'];
//     _availableForPremiumUsers = json['availableForPremiumUsers'];
//     _availableForMobile = json['availableForMobile'];
//     _availablePartially = json['availablePartially'];
//   }
//
//   static num? _id;
//   static String? _title;
//   static String? _type;
//   static String? _metaType;
//   static num? _year;
//   static String? _releaseDate;
//   static String? _coverUri;
//   static String? _ogImage;
//   static String? _genre;
//   static num? _trackCount;
//   static num? _likesCount;
//   static bool? _recent;
//   static bool? _veryImportant;
//   static List<Artists>? _artists;
//   static List<Labels>? _labels;
//   static bool? _available;
//   static bool? _availableForPremiumUsers;
//   static bool? _availableForMobile;
//   static bool? _availablePartially;
//   static List<dynamic>? _bests;
//
//   AlbumPayload copyWith({
//     num? id,
//     String? title,
//     String? type,
//     String? metaType,
//     num? year,
//     String? releaseDate,
//     String? coverUri,
//     String? ogImage,
//     String? genre,
//     num? trackCount,
//     num? likesCount,
//     bool? recent,
//     bool? veryImportant,
//     List<Artists>? artists,
//     List<Labels>? labels,
//     bool? available,
//     bool? availableForPremiumUsers,
//     bool? availableForMobile,
//     bool? availablePartially,
//     List<dynamic>? bests,
//   }) =>
//       AlbumPayload(
//         id: id ?? _id,
//         title: title ?? _title,
//         type: type ?? _type,
//         metaType: metaType ?? _metaType,
//         year: year ?? _year,
//         releaseDate: releaseDate ?? _releaseDate,
//         coverUri: coverUri ?? _coverUri,
//         ogImage: ogImage ?? _ogImage,
//         genre: genre ?? _genre,
//         trackCount: trackCount ?? _trackCount,
//         likesCount: likesCount ?? _likesCount,
//         recent: recent ?? _recent,
//         veryImportant: veryImportant ?? _veryImportant,
//         artists: artists ?? _artists,
//         labels: labels ?? _labels,
//         available: available ?? _available,
//         availableForPremiumUsers:
//             availableForPremiumUsers ?? _availableForPremiumUsers,
//         availableForMobile: availableForMobile ?? _availableForMobile,
//         availablePartially: availablePartially ?? _availablePartially,
//         bests: bests ?? _bests,
//       );
//
//   num? get id => _id;
//
//   String? get title => _title;
//
//   String? get type => _type;
//
//   String? get metaType => _metaType;
//
//   num? get year => _year;
//
//   String? get releaseDate => _releaseDate;
//
//   String? get coverUri => _coverUri;
//
//   String? get ogImage => _ogImage;
//
//   String? get genre => _genre;
//
//   num? get trackCount => _trackCount;
//
//   num? get likesCount => _likesCount;
//
//   bool? get recent => _recent;
//
//   bool? get veryImportant => _veryImportant;
//
//   List<Artists>? get artists => _artists;
//
//   List<Labels>? get labels => _labels;
//
//   bool? get available => _available;
//
//   bool? get availableForPremiumUsers => _availableForPremiumUsers;
//
//   bool? get availableForMobile => _availableForMobile;
//
//   bool? get availablePartially => _availablePartially;
//
//   List<dynamic>? get bests => _bests;
//
//   static Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['title'] = _title;
//     map['type'] = _type;
//     map['metaType'] = _metaType;
//     map['year'] = _year;
//     map['releaseDate'] = _releaseDate;
//     map['coverUri'] = _coverUri;
//     map['ogImage'] = _ogImage;
//     map['genre'] = _genre;
//     map['trackCount'] = _trackCount;
//     map['likesCount'] = _likesCount;
//     map['recent'] = _recent;
//     map['veryImportant'] = _veryImportant;
//     if (_artists != null) {
//       map['artists'] = _artists?.map((v) => v.toJson()).toList();
//     }
//     if (_labels != null) {
//       map['labels'] = _labels?.map((v) => v.toJson()).toList();
//     }
//     map['available'] = _available;
//     map['availableForPremiumUsers'] = _availableForPremiumUsers;
//     map['availableForMobile'] = _availableForMobile;
//     map['availablePartially'] = _availablePartially;
//     if (_bests != null) {
//       map['bests'] = _bests?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }
//
// /// id : 4006342
// /// name : "Издательство «Эксмо»"
//
// class Labels {
//   Labels({
//     num? id,
//     String? name,
//   }) {
//     _id = id;
//     _name = name;
//   }
//
//   Labels.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//   }
//
//   num? _id;
//   String? _name;
//
//   Labels copyWith({
//     num? id,
//     String? name,
//   }) =>
//       Labels(
//         id: id ?? _id,
//         name: name ?? _name,
//       );
//
//   num? get id => _id;
//
//   String? get name => _name;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     return map;
//   }
// }
//
// /// id : 16307922
// /// name : "Варвара Шалагина"
// /// various : false
// /// composer : false
// /// cover : {"type":"from-album-cover","prefix":"95db82ac.a.21852116-1","uri":"avatars.yandex.net/get-music-content/6058982/95db82ac.a.21852116-1/%%"}
// /// genres : []
//
// class Artists {
//   Artists({
//     num? id,
//     String? name,
//     bool? various,
//     bool? composer,
//     Cover? cover,
//     List<dynamic>? genres,
//   }) {
//     _id = id;
//     _name = name;
//     _various = various;
//     _composer = composer;
//     _cover = cover;
//   }
//
//   Artists.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//     _various = json['various'];
//     _composer = json['composer'];
//     _cover = json['cover'] != null ? Cover.fromJson(json['cover']) : null;
//   }
//
//   num? _id;
//   String? _name;
//   bool? _various;
//   bool? _composer;
//   Cover? _cover;
//   List<dynamic>? _genres;
//
//   Artists copyWith({
//     num? id,
//     String? name,
//     bool? various,
//     bool? composer,
//     Cover? cover,
//     List<dynamic>? genres,
//   }) =>
//       Artists(
//         id: id ?? _id,
//         name: name ?? _name,
//         various: various ?? _various,
//         composer: composer ?? _composer,
//         cover: cover ?? _cover,
//         genres: genres ?? _genres,
//       );
//
//   num? get id => _id;
//
//   String? get name => _name;
//
//   bool? get various => _various;
//
//   bool? get composer => _composer;
//
//   Cover? get cover => _cover;
//
//   List<dynamic>? get genres => _genres;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     map['various'] = _various;
//     map['composer'] = _composer;
//     if (_cover != null) {
//       map['cover'] = _cover?.toJson();
//     }
//     if (_genres != null) {
//       map['genres'] = _genres?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }
//
// /// type : "from-album-cover"
// /// prefix : "95db82ac.a.21852116-1"
// /// uri : "avatars.yandex.net/get-music-content/6058982/95db82ac.a.21852116-1/%%"
//
// class Cover {
//   Cover({
//     String? type,
//     String? prefix,
//     String? uri,
//   }) {
//     _type = type;
//     _prefix = prefix;
//     _uri = uri;
//   }
//
//   Cover.fromJson(dynamic json) {
//     _type = json['type'];
//     _prefix = json['prefix'];
//     _uri = json['uri'];
//   }
//
//   String? _type;
//   String? _prefix;
//   String? _uri;
//
//   Cover copyWith({
//     String? type,
//     String? prefix,
//     String? uri,
//   }) =>
//       Cover(
//         type: type ?? _type,
//         prefix: prefix ?? _prefix,
//         uri: uri ?? _uri,
//       );
//
//   String? get type => _type;
//
//   String? get prefix => _prefix;
//
//   String? get uri => _uri;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['type'] = _type;
//     map['prefix'] = _prefix;
//     map['uri'] = _uri;
//     return map;
//   }
// }
