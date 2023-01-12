import 'package:gibbon_music/NewAPI/models/InnerModel/M_InnerArtist.dart';

import 'M_Artist.dart';

class MAlbum {
  MAlbum({
    this.id,
    this.title,
    this.metaType,
    this.year,
    this.releaseDate,
    this.coverUri,
    this.ogImage,
    this.genre,
    this.trackCount,
    this.likesCount,
    this.recent,
    this.veryImportant,
    this.artists,
    this.available,
    this.availableForPremiumUsers,
    this.availableForOptions,
    this.availableForMobile,
    this.availablePartially,
    this.bests,
  });

  MAlbum.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    metaType = json['metaType'];
    year = json['year'];
    releaseDate = json['releaseDate'];
    coverUri = json['coverUri'];
    ogImage = json['ogImage'];
    genre = json['genre'];
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
    available = json['available'];
    availableForPremiumUsers = json['availableForPremiumUsers'];
    availableForOptions = json['availableForOptions'] != null ? json['availableForOptions'].cast<String>() : [];
    availableForMobile = json['availableForMobile'];
    availablePartially = json['availablePartially'];
    bests = json['bests'] != null ? json['bests'].cast<num>() : [];
  }

  num id;
  String title;
  String metaType;
  num year;
  String releaseDate;
  String coverUri;
  String ogImage;
  String genre;
  num trackCount;
  num likesCount;
  bool recent;
  bool veryImportant;
  List<MInnerArtist> artists;
  List<Labels> labels;
  bool available;
  bool availableForPremiumUsers;
  List<String> availableForOptions;
  bool availableForMobile;
  bool availablePartially;
  List<num> bests;

  MAlbum copyWith({
    num id,
    String title,
    String metaType,
    num year,
    String releaseDate,
    String coverUri,
    String ogImage,
    String genre,
    num trackCount,
    num likesCount,
    bool recent,
    bool veryImportant,
    List<MArtist> artists,
    List<Labels> labels,
    bool available,
    bool availableForPremiumUsers,
    List<String> availableForOptions,
    bool availableForMobile,
    bool availablePartially,
    List<num> bests,
  }) =>
      MAlbum(
        id: id ?? this.id,
        title: title ?? this.title,
        metaType: metaType ?? this.metaType,
        year: year ?? this.year,
        releaseDate: releaseDate ?? this.releaseDate,
        coverUri: coverUri ?? this.coverUri,
        ogImage: ogImage ?? this.ogImage,
        genre: genre ?? this.genre,
        trackCount: trackCount ?? this.trackCount,
        likesCount: likesCount ?? this.likesCount,
        recent: recent ?? this.recent,
        veryImportant: veryImportant ?? this.veryImportant,
        artists: artists ?? this.artists,
        available: available ?? this.available,
        availableForPremiumUsers: availableForPremiumUsers ?? this.availableForPremiumUsers,
        availableForOptions: availableForOptions ?? this.availableForOptions,
        availableForMobile: availableForMobile ?? this.availableForMobile,
        availablePartially: availablePartially ?? this.availablePartially,
        bests: bests ?? this.bests,
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
    return map;
  }
}

class Labels {
  Labels({
    this.id,
    this.name,
  });

  Labels.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  num id;
  String name;

  Labels copyWith({
    num id,
    String name,
  }) =>
      Labels(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
