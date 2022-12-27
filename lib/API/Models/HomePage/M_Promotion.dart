/// id : "zOeoEwvreBuhj9OY"
/// type : "promotions"
/// typeForFrom : "promotions"
/// title : "Интересно сейчас"
/// entities : [{"id":"pn6qqnWN","type":"promotion","data":{"promoId":"632c78fe87fab56c3435b83a","title":"Куда пропадает эйфория? ","subtitle":"«Ночные Снайперы» о меняющихся чувствах","heading":"Сингл","urlScheme":"yandexmusic://album/23516925","url":"/album/23516925","textColor":"","gradient":"","image":"avatars.yandex.net/get-music-feed-promotion/27702/632c78fe87fab56c3435b83a-landing.image/%%"}},{"id":"e3ha3hN9","type":"promotion","data":{"promoId":"632c597a87fab56c3435b745","title":"Громкие новинки: рэп","subtitle":"LIZER, MAYOT и GUF, L'One и другие","heading":"Плейлист","urlScheme":"yandexmusic://users/music-blog/playlists/2441","url":"/users/music-blog/playlists/2441","textColor":"","gradient":"","image":"avatars.yandex.net/get-music-feed-promotion/69892/632c597a87fab56c3435b745-landing.image/%%"}},{"id":"JlBTFJq0","type":"promotion","data":{"promoId":"632c783a87fab56c3435b835","title":"Трэп-люкс от Yanix","subtitle":"При участии SODA LUV","heading":"Сингл","urlScheme":"yandexmusic://album/23573249","url":"/album/23573249","textColor":"","gradient":"","image":"avatars.yandex.net/get-music-feed-promotion/51767/632c783a87fab56c3435b835-landing.image/%%"}},{"id":"E3FXcAhT","type":"promotion","data":{"promoId":"6323861cc0cc79533903252a","title":"ЕГОР НАТС открывает свой внутренний мир","subtitle":"Рассказ о самом себе через чувства к другим","heading":"Альбом","urlScheme":"yandexmusic://album/23366428","url":"/album/23366428","textColor":"","gradient":"","image":"avatars.yandex.net/get-music-feed-promotion/34168/6323861cc0cc79533903252a-landing.image/%%"}},{"id":"OzmQbfOW","type":"promotion","data":{"promoId":"6323675c27d9334351fce44b","title":"Тяжёлый, исцеляющий альбом «Аквариум»","subtitle":"Крик души и исповедь Бориса Гребенщикова","heading":"Альбом","urlScheme":"yandexmusic://album/23506304","url":"/album/23506304","textColor":"","gradient":"","image":"avatars.yandex.net/get-music-feed-promotion/59901/6323675c27d9334351fce44b-landing.image/%%"}},{"id":"OqzUTbWz","type":"promotion","data":{"promoId":"632c77cb87fab56c3435b833","title":"Интеллигентный хип-хоп от LIZER","subtitle":"Рефлексия поверх новых грувов","heading":"Сингл","urlScheme":"yandexmusic://album/23595256","url":"/album/23595256","textColor":"","gradient":"","image":"avatars.yandex.net/get-music-feed-promotion/30089/632c77cb87fab56c3435b833-landing.image/%%"}}]

class MPromotion {
  MPromotion({
      String? id, 
      String? type, 
      String? typeForFrom, 
      String? title, 
      List<Entities>? entities,}){
    _id = id;
    _type = type;
    _typeForFrom = typeForFrom;
    _title = title;
    _entities = entities;
}

  MPromotion.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _typeForFrom = json['typeForFrom'];
    _title = json['title'];
    if (json['entities'] != null) {
      _entities = [];
      json['entities'].forEach((v) {
        _entities?.add(Entities.fromJson(v));
      });
    }
  }
  String? _id;
  String? _type;
  String? _typeForFrom;
  String? _title;
  List<Entities>? _entities;
MPromotion copyWith({  String? id,
  String? type,
  String? typeForFrom,
  String? title,
  List<Entities>? entities,
}) => MPromotion(  id: id ?? _id,
  type: type ?? _type,
  typeForFrom: typeForFrom ?? _typeForFrom,
  title: title ?? _title,
  entities: entities ?? _entities,
);
  String? get id => _id;
  String? get type => _type;
  String? get typeForFrom => _typeForFrom;
  String? get title => _title;
  List<Entities>? get entities => _entities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['typeForFrom'] = _typeForFrom;
    map['title'] = _title;
    if (_entities != null) {
      map['entities'] = _entities?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "pn6qqnWN"
/// type : "promotion"
/// data : {"promoId":"632c78fe87fab56c3435b83a","title":"Куда пропадает эйфория? ","subtitle":"«Ночные Снайперы» о меняющихся чувствах","heading":"Сингл","urlScheme":"yandexmusic://album/23516925","url":"/album/23516925","textColor":"","gradient":"","image":"avatars.yandex.net/get-music-feed-promotion/27702/632c78fe87fab56c3435b83a-landing.image/%%"}

class Entities {
  Entities({
      String? id, 
      String? type, 
      Data? data,}){
    _id = id;
    _type = type;
    _data = data;
}

  Entities.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _id;
  String? _type;
  Data? _data;
Entities copyWith({  String? id,
  String? type,
  Data? data,
}) => Entities(  id: id ?? _id,
  type: type ?? _type,
  data: data ?? _data,
);
  String? get id => _id;
  String? get type => _type;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// promoId : "632c78fe87fab56c3435b83a"
/// title : "Куда пропадает эйфория? "
/// subtitle : "«Ночные Снайперы» о меняющихся чувствах"
/// heading : "Сингл"
/// urlScheme : "yandexmusic://album/23516925"
/// url : "/album/23516925"
/// textColor : ""
/// gradient : ""
/// image : "avatars.yandex.net/get-music-feed-promotion/27702/632c78fe87fab56c3435b83a-landing.image/%%"

class Data {
  Data({
      String? promoId, 
      String? title, 
      String? subtitle, 
      String? heading, 
      String? urlScheme, 
      String? url, 
      String? textColor, 
      String? gradient, 
      String? image,}){
    _promoId = promoId;
    _title = title;
    _subtitle = subtitle;
    _heading = heading;
    _urlScheme = urlScheme;
    _url = url;
    _textColor = textColor;
    _gradient = gradient;
    _image = image;
}

  Data.fromJson(dynamic json) {
    _promoId = json['promoId'];
    _title = json['title'];
    _subtitle = json['subtitle'];
    _heading = json['heading'];
    _urlScheme = json['urlScheme'];
    _url = json['url'];
    _textColor = json['textColor'];
    _gradient = json['gradient'];
    _image = json['image'];
  }
  String? _promoId;
  String? _title;
  String? _subtitle;
  String? _heading;
  String? _urlScheme;
  String? _url;
  String? _textColor;
  String? _gradient;
  String? _image;
Data copyWith({  String? promoId,
  String? title,
  String? subtitle,
  String? heading,
  String? urlScheme,
  String? url,
  String? textColor,
  String? gradient,
  String? image,
}) => Data(  promoId: promoId ?? _promoId,
  title: title ?? _title,
  subtitle: subtitle ?? _subtitle,
  heading: heading ?? _heading,
  urlScheme: urlScheme ?? _urlScheme,
  url: url ?? _url,
  textColor: textColor ?? _textColor,
  gradient: gradient ?? _gradient,
  image: image ?? _image,
);
  String? get promoId => _promoId;
  String? get title => _title;
  String? get subtitle => _subtitle;
  String? get heading => _heading;
  String? get urlScheme => _urlScheme;
  String? get url => _url;
  String? get textColor => _textColor;
  String? get gradient => _gradient;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['promoId'] = _promoId;
    map['title'] = _title;
    map['subtitle'] = _subtitle;
    map['heading'] = _heading;
    map['urlScheme'] = _urlScheme;
    map['url'] = _url;
    map['textColor'] = _textColor;
    map['gradient'] = _gradient;
    map['image'] = _image;
    return map;
  }

}