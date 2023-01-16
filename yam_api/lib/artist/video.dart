class Video {
  Video({
    this.title,
    this.cover,
    this.embedUrl,
    this.provider,
    this.providerVideoId,});

  Video.fromJson(dynamic json) {
    title = json['title'];
    cover = json['cover'];
    embedUrl = json['embedUrl'];
    provider = json['provider'];
    providerVideoId = json['providerVideoId'];
  }
  String? title;
  String? cover;
  String? embedUrl;
  String? provider;
  String? providerVideoId;
  Video copyWith({  String? title,
    String? cover,
    String? embedUrl,
    String? provider,
    String? providerVideoId,
  }) => Video(  title: title ?? this.title,
    cover: cover ?? this.cover,
    embedUrl: embedUrl ?? this.embedUrl,
    provider: provider ?? this.provider,
    providerVideoId: providerVideoId ?? this.providerVideoId,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['cover'] = cover;
    map['embedUrl'] = embedUrl;
    map['provider'] = provider;
    map['providerVideoId'] = providerVideoId;
    return map;
  }

}