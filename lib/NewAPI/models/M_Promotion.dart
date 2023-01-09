class MPromotion {
  MPromotion({
      this.promoId, 
      this.title, 
      this.subtitle, 
      this.heading, 
      this.urlScheme, 
      this.url, 
      this.textColor, 
      this.gradient, 
      this.image,});

  MPromotion.fromJson(dynamic json) {
    promoId = json['promoId'];
    title = json['title'];
    subtitle = json['subtitle'];
    heading = json['heading'];
    urlScheme = json['urlScheme'];
    url = json['url'];
    textColor = json['textColor'];
    gradient = json['gradient'];
    image = json['image'];
  }
  String promoId;
  String title;
  String subtitle;
  String heading;
  String urlScheme;
  String url;
  String textColor;
  String gradient;
  String image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['promoId'] = promoId;
    map['title'] = title;
    map['subtitle'] = subtitle;
    map['heading'] = heading;
    map['urlScheme'] = urlScheme;
    map['url'] = url;
    map['textColor'] = textColor;
    map['gradient'] = gradient;
    map['image'] = image;
    return map;
  }

}