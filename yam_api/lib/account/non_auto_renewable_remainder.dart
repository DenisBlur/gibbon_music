class NonAutoRenewableRemainder {
  NonAutoRenewableRemainder({
    num? days,}){
    _days = days;
  }

  NonAutoRenewableRemainder.fromJson(dynamic json) {
    _days = json['days'];
  }
  num? _days;
  NonAutoRenewableRemainder copyWith({  num? days,
  }) => NonAutoRenewableRemainder(  days: days ?? _days,
  );
  num? get days => _days;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['days'] = _days;
    return map;
  }

}