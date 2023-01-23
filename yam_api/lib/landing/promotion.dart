class Promotion {
  final String? promoId;
  final String? title;
  final String? subtitle;
  final String? heading;
  final String? urlScheme;
  final String? url;
  final String? textColor;
  final String? gradient;
  final String? image;
  const Promotion({this.promoId, this.title, this.subtitle, this.heading, this.urlScheme, this.url, this.textColor, this.gradient, this.image});
  Promotion copyWith({String? promoId, String? title, String? subtitle, String? heading, String? urlScheme, String? url, String? textColor, String? gradient, String? image}) {
    return Promotion(
        promoId: promoId ?? this.promoId,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        heading: heading ?? this.heading,
        urlScheme: urlScheme ?? this.urlScheme,
        url: url ?? this.url,
        textColor: textColor ?? this.textColor,
        gradient: gradient ?? this.gradient,
        image: image ?? this.image);
  }

  Map<String, Object?> toJson() {
    return {'promoId': promoId, 'title': title, 'subtitle': subtitle, 'heading': heading, 'urlScheme': urlScheme, 'url': url, 'textColor': textColor, 'gradient': gradient, 'image': image};
  }

  static Promotion fromJson(Map<String, Object?> json) {
    return Promotion(
        promoId: json['promoId'] == null ? null : json['promoId'] as String,
        title: json['title'] == null ? null : json['title'] as String,
        subtitle: json['subtitle'] == null ? null : json['subtitle'] as String,
        heading: json['heading'] == null ? null : json['heading'] as String,
        urlScheme: json['urlScheme'] == null ? null : json['urlScheme'] as String,
        url: json['url'] == null ? null : json['url'] as String,
        textColor: json['textColor'] == null ? null : json['textColor'] as String,
        gradient: json['gradient'] == null ? null : json['gradient'] as String,
        image: json['image'] == null ? null : json['image'] as String);
  }

  @override
  String toString() {
    return '''Promotion(
                promoId:$promoId,
title:$title,
subtitle:$subtitle,
heading:$heading,
urlScheme:$urlScheme,
url:$url,
textColor:$textColor,
gradient:$gradient,
image:$image
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Promotion &&
        other.runtimeType == runtimeType &&
        other.promoId == promoId &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.heading == heading &&
        other.urlScheme == urlScheme &&
        other.url == url &&
        other.textColor == textColor &&
        other.gradient == gradient &&
        other.image == image;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, promoId, title, subtitle, heading, urlScheme, url, textColor, gradient, image);
  }
}
