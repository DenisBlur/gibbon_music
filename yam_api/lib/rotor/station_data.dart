import 'package:yam_api/artist/brief_info.dart';

class StationData {
  StationData({
    this.title,
    this.description,
    this.imageUri,
    this.artists,
  });

  StationData.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    imageUri = json['imageUri'];
    if (json['artists'] != null) {
      artists = [];
      json['artists'].forEach((v) {
        artists?.add(BriefInfo.fromJson(v));
      });
    }
  }

  String? title;
  String? description;
  String? imageUri;
  List<BriefInfo>? artists;

  StationData copyWith({
    String? title,
    String? description,
    String? imageUri,
    List<BriefInfo>? artists,
  }) =>
      StationData(
        title: title ?? this.title,
        description: description ?? this.description,
        imageUri: imageUri ?? this.imageUri,
        artists: artists ?? this.artists,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['imageUri'] = imageUri;
    if (artists != null) {
      map['artists'] = artists?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
