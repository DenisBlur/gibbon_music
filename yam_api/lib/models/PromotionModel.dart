class PromotionModel {
  final String? promoId;
  final String? title;
  final String? subtitle;
  final String? heading;
  final String? urlScheme;
  final String? url;
  final String? textColor;
  final String? gradient;
  final String? image;

  PromotionModel(this.promoId, this.title, this.subtitle, this.heading, this.urlScheme, this.url, this.textColor, this.gradient, this.image);

  static PromotionModel fromMap(Map<String, dynamic> map) {
    PromotionModel dataBean = PromotionModel(
     map['promoId'],
     map['title'],
     map['subtitle'],
     map['heading'],
     map['urlScheme'],
     map['url'],
     map['textColor'],
     map['gradient'],
     map['image'],
    );
    return dataBean;
  }

  Map toJson() => {
    "promoId": promoId,
    "title": title,
    "subtitle": subtitle,
    "heading": heading,
    "urlScheme": urlScheme,
    "url": url,
    "textColor": textColor,
    "gradient": gradient,
    "image": image,
  }..removeWhere((k,v)=>v==null);
}

