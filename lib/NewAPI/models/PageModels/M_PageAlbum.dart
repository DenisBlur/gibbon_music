import 'package:gibbon_music/NewAPI/models/InnerModel/M_InnerArtist.dart';
import 'package:gibbon_music/NewAPI/models/M_Track.dart';
import 'package:gibbon_music/NewAPI/models/PageModels/M_Labels.dart';

import '../M_Album.dart';
import 'M_CustomWave.dart';
import 'M_Pager.dart';

class MPageAlbum {
  MPageAlbum({
      this.id, 
      this.title, 
      this.metaType, 
      this.version, 
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
      this.duplicates, 
      this.customWave, 
      this.sortOrder, 
      this.volumes, 
      this.pager,});

  MPageAlbum.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    metaType = json['metaType'];
    version = json['version'];
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
        artists.add(MInnerArtist.fromJson(v));
      });
    }
    if (json['labels'] != null) {
      labels = [];
      json['labels'].forEach((v) {
        labels.add(MLabels.fromJson(v));
      });
    }
    available = json['available'];
    availableForPremiumUsers = json['availableForPremiumUsers'];
    availableForOptions = json['availableForOptions'] != null ? json['availableForOptions'].cast<String>() : [];
    availableForMobile = json['availableForMobile'];
    availablePartially = json['availablePartially'];
    bests = json['bests'] != null ? json['bests'].cast<num>() : [];
    if (json['duplicates'] != null) {
      duplicates = [];
      json['duplicates'].forEach((v) {
        duplicates.add(MAlbum.fromJson(v));
      });
    }
    customWave = json['customWave'] != null ? MCustomWave.fromJson(json['customWave']) : null;
    sortOrder = json['sortOrder'];
    if (json['volumes'] != null) {
      volumes = [];
      json['volumes'][0].forEach((v) {
        volumes.add(MTrack.fromJson(v));
      });
    }
    pager = json['pager'] != null ? MPager.fromJson(json['pager']) : null;
  }
  num id;
  String title;
  String metaType;
  String version;
  num year;
  String releaseDate;
  String coverUri;
  String ogImage;
  String genre;
  String metaTagId;
  num trackCount;
  num likesCount;
  bool recent;
  bool veryImportant;
  List<MInnerArtist> artists;
  List<MLabels> labels;
  bool available;
  bool availableForPremiumUsers;
  List<String> availableForOptions;
  bool availableForMobile;
  bool availablePartially;
  List<num> bests;
  List<MAlbum> duplicates;
  MCustomWave customWave;
  String sortOrder;
  List<MTrack> volumes;
  MPager pager;
MPageAlbum copyWith({  num id,
  String title,
  String metaType,
  String version,
  num year,
  String releaseDate,
  String coverUri,
  String ogImage,
  String genre,
  String metaTagId,
  num trackCount,
  num likesCount,
  bool recent,
  bool veryImportant,
  List<MInnerArtist> artists,
  List<MLabels> labels,
  bool available,
  bool availableForPremiumUsers,
  List<String> availableForOptions,
  bool availableForMobile,
  bool availablePartially,
  List<num> bests,
  List<MAlbum> duplicates,
  MCustomWave customWave,
  String sortOrder,
  List<MTrack> volumes,
  MPager pager,
}) => MPageAlbum(  id: id ?? this.id,
  title: title ?? this.title,
  metaType: metaType ?? this.metaType,
  version: version ?? this.version,
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
  labels: labels ?? this.labels,
  available: available ?? this.available,
  availableForPremiumUsers: availableForPremiumUsers ?? this.availableForPremiumUsers,
  availableForOptions: availableForOptions ?? this.availableForOptions,
  availableForMobile: availableForMobile ?? this.availableForMobile,
  availablePartially: availablePartially ?? this.availablePartially,
  bests: bests ?? this.bests,
  duplicates: duplicates ?? this.duplicates,
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
    map['version'] = version;
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
      map['artists'] = artists.map((v) => v.toJson()).toList();
    }
    if (labels != null) {
      map['labels'] = labels.map((v) => v.toJson()).toList();
    }
    map['available'] = available;
    map['availableForPremiumUsers'] = availableForPremiumUsers;
    map['availableForOptions'] = availableForOptions;
    map['availableForMobile'] = availableForMobile;
    map['availablePartially'] = availablePartially;
    map['bests'] = bests;
    if (duplicates != null) {
      map['duplicates'] = duplicates.map((v) => v.toJson()).toList();
    }
    if (customWave != null) {
      map['customWave'] = customWave.toJson();
    }
    map['sortOrder'] = sortOrder;
    if (volumes != null) {
      map['volumes'] = volumes.map((v) => v.toJson()).toList();
    }
    if (pager != null) {
      map['pager'] = pager.toJson();
    }
    return map;
  }

}

class LyricsInfo {
  LyricsInfo({
      this.hasAvailableSyncLyrics, 
      this.hasAvailableTextLyrics,});

  LyricsInfo.fromJson(dynamic json) {
    hasAvailableSyncLyrics = json['hasAvailableSyncLyrics'];
    hasAvailableTextLyrics = json['hasAvailableTextLyrics'];
  }
  bool hasAvailableSyncLyrics;
  bool hasAvailableTextLyrics;
LyricsInfo copyWith({  bool hasAvailableSyncLyrics,
  bool hasAvailableTextLyrics,
}) => LyricsInfo(  hasAvailableSyncLyrics: hasAvailableSyncLyrics ?? this.hasAvailableSyncLyrics,
  hasAvailableTextLyrics: hasAvailableTextLyrics ?? this.hasAvailableTextLyrics,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hasAvailableSyncLyrics'] = hasAvailableSyncLyrics;
    map['hasAvailableTextLyrics'] = hasAvailableTextLyrics;
    return map;
  }

}

