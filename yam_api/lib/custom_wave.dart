class CustomWave {
  CustomWave({
    this.title,
    this.animationUrl,});

  CustomWave.fromJson(dynamic json) {
    title = json['title'];
    animationUrl = json['animationUrl'];
  }
  String? title;
  String? animationUrl;
  CustomWave copyWith({  String? title,
    String? animationUrl,
  }) => CustomWave(  title: title ?? this.title,
    animationUrl: animationUrl ?? this.animationUrl,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['animationUrl'] = animationUrl;
    return map;
  }

}