import 'package:yam_api/artist/brief_info.dart';
import 'package:yam_api/track/track.dart';

import '../custom_wave.dart';
import '../pager.dart';
import 'label.dart';

class Album {
  Album({
      this.id, 
      this.title, 
      this.metaType, 
      this.year, 
      this.releaseDate, 
      this.coverUri, 
      this.ogImage, 
      this.genre, 
      this.metaTagId, 
      this.trackCount, 
      this.likesCount, 
      this.recent, 
      this.veryImportant, 
      this.artists, 
      this.labels, 
      this.available, 
      this.availableForPremiumUsers, 
      this.availableForOptions, 
      this.availableForMobile, 
      this.availablePartially, 
      this.bests, 
      this.customWave, 
      this.sortOrder, 
      this.volumes, 
      this.pager,});

  Album.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    metaType = json['metaType'];
    year = json['year'];
    releaseDate = json['releaseDate'];
    coverUri = json['coverUri'];
    ogImage = json['ogImage'];
    genre = json['genre'];
    metaTagId = json['metaTagId'];
    trackCount = json['trackCount'];
    likesCount = json['likesCount'];
    recent = json['recent'];
    veryImportant = json['veryImportant'];
    if (json['artists'] != null) {
      artists = [];
      json['artists'].forEach((v) {
        artists?.add(BriefInfo.fromJson(v));
      });
    }
    // if (json['labels'] != null) {
    //   labels = [];
    //   json['labels'].forEach((v) {
    //     labels?.add(Labels.fromJson(v));
    //   });
    // }
    available = json['available'];
    availableForPremiumUsers = json['availableForPremiumUsers'];
    availableForOptions = json['availableForOptions'] != null ? json['availableForOptions'].cast<String>() : [];
    availableForMobile = json['availableForMobile'];
    availablePartially = json['availablePartially'];
    bests = json['bests'] != null ? json['bests'].cast<num>() : [];
    customWave = json['customWave'] != null ? CustomWave.fromJson(json['customWave']) : null;
    sortOrder = json['sortOrder'];
    if (json['volumes'] != null) {
      volumes = [];
      json['volumes'][0].forEach((v) {
        volumes!.add(Track.fromJson(v));
      });
    }
    pager = json['pager'] != null ? Pager.fromJson(json['pager']) : null;
  }
  num? id;
  String? title;
  String? metaType;
  num? year;
  String? releaseDate;
  String? coverUri;
  String? ogImage;
  String? genre;
  String? metaTagId;
  num? trackCount;
  num? likesCount;
  bool? recent;
  bool? veryImportant;
  List<BriefInfo>? artists;
  List<Labels>? labels;
  bool? available;
  bool? availableForPremiumUsers;
  List<String>? availableForOptions;
  bool? availableForMobile;
  bool? availablePartially;
  List<num>? bests;
  CustomWave? customWave;
  String? sortOrder;
  List<Track>? volumes;
  Pager? pager;
Album copyWith({  num? id,
  String? title,
  String? metaType,
  num? year,
  String? releaseDate,
  String? coverUri,
  String? ogImage,
  String? genre,
  String? metaTagId,
  num? trackCount,
  num? likesCount,
  bool? recent,
  bool? veryImportant,
  List<BriefInfo>? artists,
  // List<Labels>? labels,
  bool? available,
  bool? availableForPremiumUsers,
  List<String>? availableForOptions,
  bool? availableForMobile,
  bool? availablePartially,
  List<num>? bests,
  CustomWave? customWave,
  String? sortOrder,
  List<Track>? volumes,
  Pager? pager,
}) => Album(  id: id ?? this.id,
  title: title ?? this.title,
  metaType: metaType ?? this.metaType,
  year: year ?? this.year,
  releaseDate: releaseDate ?? this.releaseDate,
  coverUri: coverUri ?? this.coverUri,
  ogImage: ogImage ?? this.ogImage,
  genre: genre ?? this.genre,
  metaTagId: metaTagId ?? this.metaTagId,
  trackCount: trackCount ?? this.trackCount,
  likesCount: likesCount ?? this.likesCount,
  recent: recent ?? this.recent,
  veryImportant: veryImportant ?? this.veryImportant,
  artists: artists ?? this.artists,
  // labels: labels ?? this.labels,
  available: available ?? this.available,
  availableForPremiumUsers: availableForPremiumUsers ?? this.availableForPremiumUsers,
  availableForOptions: availableForOptions ?? this.availableForOptions,
  availableForMobile: availableForMobile ?? this.availableForMobile,
  availablePartially: availablePartially ?? this.availablePartially,
  bests: bests ?? this.bests,
  customWave: customWave ?? this.customWave,
  sortOrder: sortOrder ?? this.sortOrder,
  volumes: volumes ?? this.volumes,
  pager: pager ?? this.pager,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['metaType'] = metaType;
    map['year'] = year;
    map['releaseDate'] = releaseDate;
    map['coverUri'] = coverUri;
    map['ogImage'] = ogImage;
    map['genre'] = genre;
    map['metaTagId'] = metaTagId;
    map['trackCount'] = trackCount;
    map['likesCount'] = likesCount;
    map['recent'] = recent;
    map['veryImportant'] = veryImportant;
    if (artists != null) {
      map['artists'] = artists?.map((v) => v.toJson()).toList();
    }
    // if (labels != null) {
    //   map['labels'] = labels?.map((v) => v.toJson()).toList();
    // }
    map['available'] = available;
    map['availableForPremiumUsers'] = availableForPremiumUsers;
    map['availableForOptions'] = availableForOptions;
    map['availableForMobile'] = availableForMobile;
    map['availablePartially'] = availablePartially;
    map['bests'] = bests;
    if (customWave != null) {
      map['customWave'] = customWave?.toJson();
    }
    map['sortOrder'] = sortOrder;
    if (volumes != null) {
      map['volumes'] = volumes?.map((v) => v.toJson()).toList();
    }
    if (pager != null) {
      map['pager'] = pager?.toJson();
    }
    return map;
  }

}


