class PassportPhones {
  PassportPhones({
    String? phone,}){
    _phone = phone;
  }

  PassportPhones.fromJson(dynamic json) {
    _phone = json['phone'];
  }
  String? _phone;
  PassportPhones copyWith({  String? phone,
  }) => PassportPhones(  phone: phone ?? _phone,
  );
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = _phone;
    return map;
  }

}