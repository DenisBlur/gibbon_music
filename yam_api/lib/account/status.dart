import 'masterhub.dart';
import 'account.dart';
import 'permissions.dart';
import 'plus.dart';
import 'subscription.dart';

class Status {
  Status({
      Account? account, 
      Permissions? permissions,
      Subscription? subscription, 
      bool? subeditor, 
      num? subeditorLevel, 
      bool? pretrialActive, 
      Masterhub? masterhub, 
      Plus? plus, 
      List<String>? hasOptions, 
      String? defaultEmail, 
      String? userhash,}){
    _account = account;
    _permissions = permissions;
    _subscription = subscription;
    _subeditor = subeditor;
    _subeditorLevel = subeditorLevel;
    _pretrialActive = pretrialActive;
    _masterhub = masterhub;
    _plus = plus;
    _hasOptions = hasOptions;
    _defaultEmail = defaultEmail;
    _userhash = userhash;
}

  Status.fromJson(dynamic json) {
    _account = json['account'] != null ? Account.fromJson(json['account']) : null;
    _permissions = json['permissions'] != null ? Permissions.fromJson(json['permissions']) : null;
    _subscription = json['subscription'] != null ? Subscription.fromJson(json['subscription']) : null;
    _subeditor = json['subeditor'];
    _subeditorLevel = json['subeditorLevel'];
    _pretrialActive = json['pretrialActive'];
    _masterhub = json['masterhub'] != null ? Masterhub.fromJson(json['masterhub']) : null;
    _plus = json['plus'] != null ? Plus.fromJson(json['plus']) : null;
    _hasOptions = json['hasOptions'] != null ? json['hasOptions'].cast<String>() : [];
    _defaultEmail = json['defaultEmail'];
    _userhash = json['userhash'];
  }
  Account? _account;
  Permissions? _permissions;
  Subscription? _subscription;
  bool? _subeditor;
  num? _subeditorLevel;
  bool? _pretrialActive;
  Masterhub? _masterhub;
  Plus? _plus;
  List<String>? _hasOptions;
  String? _defaultEmail;
  String? _userhash;
Status copyWith({  Account? account,
  Permissions? permissions,
  Subscription? subscription,
  bool? subeditor,
  num? subeditorLevel,
  bool? pretrialActive,
  Masterhub? masterhub,
  Plus? plus,
  List<String>? hasOptions,
  String? defaultEmail,
  String? userhash,
}) => Status(  account: account ?? _account,
  permissions: permissions ?? _permissions,
  subscription: subscription ?? _subscription,
  subeditor: subeditor ?? _subeditor,
  subeditorLevel: subeditorLevel ?? _subeditorLevel,
  pretrialActive: pretrialActive ?? _pretrialActive,
  masterhub: masterhub ?? _masterhub,
  plus: plus ?? _plus,
  hasOptions: hasOptions ?? _hasOptions,
  defaultEmail: defaultEmail ?? _defaultEmail,
  userhash: userhash ?? _userhash,
);
  Account? get account => _account;
  Permissions? get permissions => _permissions;
  Subscription? get subscription => _subscription;
  bool? get subeditor => _subeditor;
  num? get subeditorLevel => _subeditorLevel;
  bool? get pretrialActive => _pretrialActive;
  Masterhub? get masterhub => _masterhub;
  Plus? get plus => _plus;
  List<String>? get hasOptions => _hasOptions;
  String? get defaultEmail => _defaultEmail;
  String? get userhash => _userhash;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_account != null) {
      map['account'] = _account?.toJson();
    }
    if (_permissions != null) {
      map['permissions'] = _permissions?.toJson();
    }
    if (_subscription != null) {
      map['subscription'] = _subscription?.toJson();
    }
    map['subeditor'] = _subeditor;
    map['subeditorLevel'] = _subeditorLevel;
    map['pretrialActive'] = _pretrialActive;
    if (_masterhub != null) {
      map['masterhub'] = _masterhub?.toJson();
    }
    if (_plus != null) {
      map['plus'] = _plus?.toJson();
    }
    map['hasOptions'] = _hasOptions;
    map['defaultEmail'] = _defaultEmail;
    map['userhash'] = _userhash;
    return map;
  }

}