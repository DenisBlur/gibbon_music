class Price {
  Price({
    num? amount,
    String? currency,}){
    _amount = amount;
    _currency = currency;
  }

  Price.fromJson(dynamic json) {
    _amount = json['amount'];
    _currency = json['currency'];
  }
  num? _amount;
  String? _currency;
  Price copyWith({  num? amount,
    String? currency,
  }) => Price(  amount: amount ?? _amount,
    currency: currency ?? _currency,
  );
  num? get amount => _amount;
  String? get currency => _currency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = _amount;
    map['currency'] = _currency;
    return map;
  }

}