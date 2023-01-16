import 'auto_renewable.dart';
import 'non_auto_renewable_remainder.dart';

class Subscription {
  Subscription({
    List<AutoRenewable>? autoRenewable,
    NonAutoRenewableRemainder? nonAutoRenewableRemainder,
    bool? hadAnySubscription,
    bool? canStartTrial,
    bool? mcdonalds,}){
    _autoRenewable = autoRenewable;
    _nonAutoRenewableRemainder = nonAutoRenewableRemainder;
    _hadAnySubscription = hadAnySubscription;
    _canStartTrial = canStartTrial;
    _mcdonalds = mcdonalds;
  }

  Subscription.fromJson(dynamic json) {
    if (json['autoRenewable'] != null) {
      _autoRenewable = [];
      json['autoRenewable'].forEach((v) {
        _autoRenewable?.add(AutoRenewable.fromJson(v));
      });
    }
    _nonAutoRenewableRemainder = json['nonAutoRenewableRemainder'] != null ? NonAutoRenewableRemainder.fromJson(json['nonAutoRenewableRemainder']) : null;
    _hadAnySubscription = json['hadAnySubscription'];
    _canStartTrial = json['canStartTrial'];
    _mcdonalds = json['mcdonalds'];
  }
  List<AutoRenewable>? _autoRenewable;
  NonAutoRenewableRemainder? _nonAutoRenewableRemainder;
  bool? _hadAnySubscription;
  bool? _canStartTrial;
  bool? _mcdonalds;
  Subscription copyWith({  List<AutoRenewable>? autoRenewable,
    NonAutoRenewableRemainder? nonAutoRenewableRemainder,
    bool? hadAnySubscription,
    bool? canStartTrial,
    bool? mcdonalds,
  }) => Subscription(  autoRenewable: autoRenewable ?? _autoRenewable,
    nonAutoRenewableRemainder: nonAutoRenewableRemainder ?? _nonAutoRenewableRemainder,
    hadAnySubscription: hadAnySubscription ?? _hadAnySubscription,
    canStartTrial: canStartTrial ?? _canStartTrial,
    mcdonalds: mcdonalds ?? _mcdonalds,
  );
  List<AutoRenewable>? get autoRenewable => _autoRenewable;
  NonAutoRenewableRemainder? get nonAutoRenewableRemainder => _nonAutoRenewableRemainder;
  bool? get hadAnySubscription => _hadAnySubscription;
  bool? get canStartTrial => _canStartTrial;
  bool? get mcdonalds => _mcdonalds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_autoRenewable != null) {
      map['autoRenewable'] = _autoRenewable?.map((v) => v.toJson()).toList();
    }
    if (_nonAutoRenewableRemainder != null) {
      map['nonAutoRenewableRemainder'] = _nonAutoRenewableRemainder?.toJson();
    }
    map['hadAnySubscription'] = _hadAnySubscription;
    map['canStartTrial'] = _canStartTrial;
    map['mcdonalds'] = _mcdonalds;
    return map;
  }

}