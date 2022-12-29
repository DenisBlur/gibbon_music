class MvPromotion {
  MvPromotion({
    String id,
    String type,
    String promoId,
    String title,
    String subTitle,
    String heading,
    String url,
    String image,
  }) {
    _id = id;
    _type = type;
    _promoId = promoId;
    _title = title;
    _subTitle = subTitle;
    _heading = heading;
    _url = url;
    _image = image;
  }

  MvPromotion.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _promoId = json['data']['promoId'];
    _title = json['data']['title'];
    _subTitle = json['data']['subtitle'];
    _heading = json['data']['heading'];
    _url = json['data']['url'];
    _image = json['data']['image'];
  }

  String _id;
  String _type;
  String _promoId;
  String _title;
  String _subTitle;
  String _heading;
  String _url;
  String _image;

  MvPromotion copyWith({
    String id,
    String type,
    String promoId,
    String title,
    String subTitle,
    String heading,
    String url,
    String image,
  }) =>
      MvPromotion(
        id: id ?? _id,
        type: type ?? _type,
        promoId: promoId ?? _promoId,
        title: title ?? _title,
        subTitle: subTitle ?? _subTitle,
        heading: heading ?? _heading,
        url: url ?? _url,
        image: image ?? _image,
      );

  String get id => _id;
  String get type => _type;
  String get promoId => _promoId;
  String get title => _title;
  String get subTitle => _subTitle;
  String get heading => _heading;
  String get url => _url;
  String get image => _image;

}
