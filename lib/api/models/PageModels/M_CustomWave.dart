class MCustomWave {
  MCustomWave({
    this.title,
    this.animationUrl,});

  MCustomWave.fromJson(dynamic json) {
    title = json['title'];
    animationUrl = json['animationUrl'];
  }
  String title;
  String animationUrl;
  MCustomWave copyWith({  String title,
    String animationUrl,
  }) => MCustomWave(  title: title ?? this.title,
    animationUrl: animationUrl ?? this.animationUrl,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['animationUrl'] = animationUrl;
    return map;
  }

}