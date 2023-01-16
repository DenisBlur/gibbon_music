import 'package:yam_api/account/passport_phones.dart';

class Account {
  Account({
    String? now,
    num? uid,
    String? login,
    num? region,
    String? fullName,
    String? secondName,
    String? firstName,
    String? displayName,
    String? birthday,
    bool? serviceAvailable,
    bool? hostedUser,
    List<PassportPhones>? passportphones,
    String? registeredAt,
    bool? child,
    bool? nonOwnerFamilyMember,}){
    _now = now;
    _uid = uid;
    _login = login;
    _region = region;
    _fullName = fullName;
    _secondName = secondName;
    _firstName = firstName;
    _displayName = displayName;
    _birthday = birthday;
    _serviceAvailable = serviceAvailable;
    _hostedUser = hostedUser;
    _passportphones = passportphones;
    _registeredAt = registeredAt;
    _child = child;
    _nonOwnerFamilyMember = nonOwnerFamilyMember;
  }

  Account.fromJson(dynamic json) {
    _now = json['now'];
    _uid = json['uid'];
    _login = json['login'];
    _region = json['region'];
    _fullName = json['fullName'];
    _secondName = json['secondName'];
    _firstName = json['firstName'];
    _displayName = json['displayName'];
    _birthday = json['birthday'];
    _serviceAvailable = json['serviceAvailable'];
    _hostedUser = json['hostedUser'];
    if (json['passport-phones'] != null) {
      _passportphones = [];
      json['passport-phones'].forEach((v) {
        _passportphones?.add(PassportPhones.fromJson(v));
      });
    }
    _registeredAt = json['registeredAt'];
    _child = json['child'];
    _nonOwnerFamilyMember = json['nonOwnerFamilyMember'];
  }
  String? _now;
  num? _uid;
  String? _login;
  num? _region;
  String? _fullName;
  String? _secondName;
  String? _firstName;
  String? _displayName;
  String? _birthday;
  bool? _serviceAvailable;
  bool? _hostedUser;
  List<PassportPhones>? _passportphones;
  String? _registeredAt;
  bool? _child;
  bool? _nonOwnerFamilyMember;
  Account copyWith({  String? now,
    num? uid,
    String? login,
    num? region,
    String? fullName,
    String? secondName,
    String? firstName,
    String? displayName,
    String? birthday,
    bool? serviceAvailable,
    bool? hostedUser,
    List<PassportPhones>? passportphones,
    String? registeredAt,
    bool? child,
    bool? nonOwnerFamilyMember,
  }) => Account(  now: now ?? _now,
    uid: uid ?? _uid,
    login: login ?? _login,
    region: region ?? _region,
    fullName: fullName ?? _fullName,
    secondName: secondName ?? _secondName,
    firstName: firstName ?? _firstName,
    displayName: displayName ?? _displayName,
    birthday: birthday ?? _birthday,
    serviceAvailable: serviceAvailable ?? _serviceAvailable,
    hostedUser: hostedUser ?? _hostedUser,
    passportphones: passportphones ?? _passportphones,
    registeredAt: registeredAt ?? _registeredAt,
    child: child ?? _child,
    nonOwnerFamilyMember: nonOwnerFamilyMember ?? _nonOwnerFamilyMember,
  );
  String? get now => _now;
  num? get uid => _uid;
  String? get login => _login;
  num? get region => _region;
  String? get fullName => _fullName;
  String? get secondName => _secondName;
  String? get firstName => _firstName;
  String? get displayName => _displayName;
  String? get birthday => _birthday;
  bool? get serviceAvailable => _serviceAvailable;
  bool? get hostedUser => _hostedUser;
  List<PassportPhones>? get passportphones => _passportphones;
  String? get registeredAt => _registeredAt;
  bool? get child => _child;
  bool? get nonOwnerFamilyMember => _nonOwnerFamilyMember;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['now'] = _now;
    map['uid'] = _uid;
    map['login'] = _login;
    map['region'] = _region;
    map['fullName'] = _fullName;
    map['secondName'] = _secondName;
    map['firstName'] = _firstName;
    map['displayName'] = _displayName;
    map['birthday'] = _birthday;
    map['serviceAvailable'] = _serviceAvailable;
    map['hostedUser'] = _hostedUser;
    if (_passportphones != null) {
      map['passport-phones'] = _passportphones?.map((v) => v.toJson()).toList();
    }
    map['registeredAt'] = _registeredAt;
    map['child'] = _child;
    map['nonOwnerFamilyMember'] = _nonOwnerFamilyMember;
    return map;
  }

}