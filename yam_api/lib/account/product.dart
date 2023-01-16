import 'price.dart';

class Product {
  Product({
    String? productId,
    String? type,
    String? commonPeriodDuration,
    num? duration,
    num? trialDuration,
    Price? price,
    bool? family,
    bool? plus,
    String? feature,
    List<String>? features,
    bool? debug,}){
    _productId = productId;
    _type = type;
    _commonPeriodDuration = commonPeriodDuration;
    _duration = duration;
    _trialDuration = trialDuration;
    _price = price;
    _family = family;
    _plus = plus;
    _feature = feature;
    _features = features;
    _debug = debug;
  }

  Product.fromJson(dynamic json) {
    _productId = json['productId'];
    _type = json['type'];
    _commonPeriodDuration = json['commonPeriodDuration'];
    _duration = json['duration'];
    _trialDuration = json['trialDuration'];
    _price = json['price'] != null ? Price.fromJson(json['price']) : null;
    _family = json['family'];
    _plus = json['plus'];
    _feature = json['feature'];
    _features = json['features'] != null ? json['features'].cast<String>() : [];
    _debug = json['debug'];
  }
  String? _productId;
  String? _type;
  String? _commonPeriodDuration;
  num? _duration;
  num? _trialDuration;
  Price? _price;
  bool? _family;
  bool? _plus;
  String? _feature;
  List<String>? _features;
  bool? _debug;
  Product copyWith({  String? productId,
    String? type,
    String? commonPeriodDuration,
    num? duration,
    num? trialDuration,
    Price? price,
    bool? family,
    bool? plus,
    String? feature,
    List<String>? features,
    bool? debug,
  }) => Product(  productId: productId ?? _productId,
    type: type ?? _type,
    commonPeriodDuration: commonPeriodDuration ?? _commonPeriodDuration,
    duration: duration ?? _duration,
    trialDuration: trialDuration ?? _trialDuration,
    price: price ?? _price,
    family: family ?? _family,
    plus: plus ?? _plus,
    feature: feature ?? _feature,
    features: features ?? _features,
    debug: debug ?? _debug,
  );
  String? get productId => _productId;
  String? get type => _type;
  String? get commonPeriodDuration => _commonPeriodDuration;
  num? get duration => _duration;
  num? get trialDuration => _trialDuration;
  Price? get price => _price;
  bool? get family => _family;
  bool? get plus => _plus;
  String? get feature => _feature;
  List<String>? get features => _features;
  bool? get debug => _debug;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = _productId;
    map['type'] = _type;
    map['commonPeriodDuration'] = _commonPeriodDuration;
    map['duration'] = _duration;
    map['trialDuration'] = _trialDuration;
    if (_price != null) {
      map['price'] = _price?.toJson();
    }
    map['family'] = _family;
    map['plus'] = _plus;
    map['feature'] = _feature;
    map['features'] = _features;
    map['debug'] = _debug;
    return map;
  }

}