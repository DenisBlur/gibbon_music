class UserInfo {
  UserInfo({
    this.uid,
    this.login,
    this.name,
    this.sex,
    this.verified,});

  UserInfo.fromJson(dynamic json) {
    uid = json['uid'];
    login = json['login'];
    name = json['name'];
    sex = json['sex'];
    verified = json['verified'];
  }
  num? uid;
  String? login;
  String? name;
  String? sex;
  bool? verified;
  UserInfo copyWith({  num? uid,
    String? login,
    String? name,
    String? sex,
    bool? verified,
  }) => UserInfo(  uid: uid ?? this.uid,
    login: login ?? this.login,
    name: name ?? this.name,
    sex: sex ?? this.sex,
    verified: verified ?? this.verified,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = uid;
    map['login'] = login;
    map['name'] = name;
    map['sex'] = sex;
    map['verified'] = verified;
    return map;
  }

}