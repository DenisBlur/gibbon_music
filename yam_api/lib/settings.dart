class Settings {
  Settings({
      List<dynamic>? inAppProducts, 
      List<dynamic>? nativeProducts, 
      String? webPaymentUrl, 
      bool? promoCodesEnabled,}){
    _inAppProducts = inAppProducts;
    _nativeProducts = nativeProducts;
    _webPaymentUrl = webPaymentUrl;
    _promoCodesEnabled = promoCodesEnabled;
}

  Settings.fromJson(dynamic json) {
    if (json['inAppProducts'] != null) {
      _inAppProducts = [];
      json['inAppProducts'].forEach((v) {
        _inAppProducts?.add(v);
      });
    }
    if (json['nativeProducts'] != null) {
      _nativeProducts = [];
      json['nativeProducts'].forEach((v) {
        _nativeProducts?.add(v);
      });
    }
    _webPaymentUrl = json['webPaymentUrl'];
    _promoCodesEnabled = json['promoCodesEnabled'];
  }
  List<dynamic>? _inAppProducts;
  List<dynamic>? _nativeProducts;
  String? _webPaymentUrl;
  bool? _promoCodesEnabled;
Settings copyWith({  List<dynamic>? inAppProducts,
  List<dynamic>? nativeProducts,
  String? webPaymentUrl,
  bool? promoCodesEnabled,
}) => Settings(  inAppProducts: inAppProducts ?? _inAppProducts,
  nativeProducts: nativeProducts ?? _nativeProducts,
  webPaymentUrl: webPaymentUrl ?? _webPaymentUrl,
  promoCodesEnabled: promoCodesEnabled ?? _promoCodesEnabled,
);
  List<dynamic>? get inAppProducts => _inAppProducts;
  List<dynamic>? get nativeProducts => _nativeProducts;
  String? get webPaymentUrl => _webPaymentUrl;
  bool? get promoCodesEnabled => _promoCodesEnabled;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_inAppProducts != null) {
      map['inAppProducts'] = _inAppProducts?.map((v) => v.toJson()).toList();
    }
    if (_nativeProducts != null) {
      map['nativeProducts'] = _nativeProducts?.map((v) => v.toJson()).toList();
    }
    map['webPaymentUrl'] = _webPaymentUrl;
    map['promoCodesEnabled'] = _promoCodesEnabled;
    return map;
  }

}