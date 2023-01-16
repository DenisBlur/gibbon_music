import 'package:yam_api/account/product.dart';

class AutoRenewable {
  AutoRenewable({
    String? expires,
    String? vendor,
    String? vendorHelpUrl,
    String? productId,
    Product? product,
    num? orderId,
    bool? finished,}){
    _expires = expires;
    _vendor = vendor;
    _vendorHelpUrl = vendorHelpUrl;
    _productId = productId;
    _product = product;
    _orderId = orderId;
    _finished = finished;
  }

  AutoRenewable.fromJson(dynamic json) {
    _expires = json['expires'];
    _vendor = json['vendor'];
    _vendorHelpUrl = json['vendorHelpUrl'];
    _productId = json['productId'];
    _product = json['product'] != null ? Product.fromJson(json['product']) : null;
    _orderId = json['orderId'];
    _finished = json['finished'];
  }
  String? _expires;
  String? _vendor;
  String? _vendorHelpUrl;
  String? _productId;
  Product? _product;
  num? _orderId;
  bool? _finished;
  AutoRenewable copyWith({  String? expires,
    String? vendor,
    String? vendorHelpUrl,
    String? productId,
    Product? product,
    num? orderId,
    bool? finished,
  }) => AutoRenewable(  expires: expires ?? _expires,
    vendor: vendor ?? _vendor,
    vendorHelpUrl: vendorHelpUrl ?? _vendorHelpUrl,
    productId: productId ?? _productId,
    product: product ?? _product,
    orderId: orderId ?? _orderId,
    finished: finished ?? _finished,
  );
  String? get expires => _expires;
  String? get vendor => _vendor;
  String? get vendorHelpUrl => _vendorHelpUrl;
  String? get productId => _productId;
  Product? get product => _product;
  num? get orderId => _orderId;
  bool? get finished => _finished;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['expires'] = _expires;
    map['vendor'] = _vendor;
    map['vendorHelpUrl'] = _vendorHelpUrl;
    map['productId'] = _productId;
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    map['orderId'] = _orderId;
    map['finished'] = _finished;
    return map;
  }

}