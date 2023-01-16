import 'package:yam_api/artist/brief_info.dart';

class Concert {
  Concert({
    this.artist,
    this.id,
    this.concertTitle,
    this.afishaUrl,
    this.city,
    this.place,
    this.address,
    this.datetime,
    this.coordinates,
    this.map,
    this.mapUrl,
    this.hash,
    this.images,
    this.contentRating,
    this.datasessionid,
    this.metrostations,});

  Concert.fromJson(dynamic json) {
    artist = json['artist'] != null ? BriefInfo.fromJson(json['artist']) : null;
    id = json['id'];
    concertTitle = json['concertTitle'];
    afishaUrl = json['afishaUrl'];
    city = json['city'];
    place = json['place'];
    address = json['address'];
    datetime = json['datetime'];
    coordinates = json['coordinates'] != null ? json['coordinates'].cast<num>() : [];
    map = json['map'];
    mapUrl = json['mapUrl'];
    hash = json['hash'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    contentRating = json['contentRating'];
    datasessionid = json['data-session-id'];
    if (json['metro-stations'] != null) {
      metrostations = [];
      json['metro-stations'].forEach((v) {
        metrostations?.add(MetroStations.fromJson(v));
      });
    }
  }
  BriefInfo? artist;
  String? id;
  String? concertTitle;
  String? afishaUrl;
  String? city;
  String? place;
  String? address;
  String? datetime;
  List<num>? coordinates;
  String? map;
  String? mapUrl;
  String? hash;
  List<String>? images;
  String? contentRating;
  String? datasessionid;
  List<MetroStations>? metrostations;
  Concert copyWith({  BriefInfo? artist,
    String? id,
    String? concertTitle,
    String? afishaUrl,
    String? city,
    String? place,
    String? address,
    String? datetime,
    List<num>? coordinates,
    String? map,
    String? mapUrl,
    String? hash,
    List<String>? images,
    String? contentRating,
    String? datasessionid,
    List<MetroStations>? metrostations,
  }) => Concert(  artist: artist ?? this.artist,
    id: id ?? this.id,
    concertTitle: concertTitle ?? this.concertTitle,
    afishaUrl: afishaUrl ?? this.afishaUrl,
    city: city ?? this.city,
    place: place ?? this.place,
    address: address ?? this.address,
    datetime: datetime ?? this.datetime,
    coordinates: coordinates ?? this.coordinates,
    map: map ?? this.map,
    mapUrl: mapUrl ?? this.mapUrl,
    hash: hash ?? this.hash,
    images: images ?? this.images,
    contentRating: contentRating ?? this.contentRating,
    datasessionid: datasessionid ?? this.datasessionid,
    metrostations: metrostations ?? this.metrostations,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (artist != null) {
      map['artist'] = artist?.toJson();
    }
    map['id'] = id;
    map['concertTitle'] = concertTitle;
    map['afishaUrl'] = afishaUrl;
    map['city'] = city;
    map['place'] = place;
    map['address'] = address;
    map['datetime'] = datetime;
    map['coordinates'] = coordinates;
    map['map'] = map;
    map['mapUrl'] = mapUrl;
    map['hash'] = hash;
    map['images'] = images;
    map['contentRating'] = contentRating;
    map['data-session-id'] = datasessionid;
    if (metrostations != null) {
      map['metro-stations'] = metrostations?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class MetroStations {
  MetroStations({
    this.title,
    this.linecolor,});

  MetroStations.fromJson(dynamic json) {
    title = json['title'];
    linecolor = json['line-color'];
  }
  String? title;
  String? linecolor;
  MetroStations copyWith({  String? title,
    String? linecolor,
  }) => MetroStations(  title: title ?? this.title,
    linecolor: linecolor ?? this.linecolor,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['line-color'] = linecolor;
    return map;
  }

}