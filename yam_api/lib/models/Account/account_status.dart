import '../InvocationInfoBean.dart';

class AccountStatusModel {
  final InvocationInfoBeanStr? invocationInfo;
  final ResultBean? result;

  AccountStatusModel(this.invocationInfo, this.result);

  static AccountStatusModel fromMap(Map<String, dynamic> map) {
    AccountStatusModel accountBean = AccountStatusModel(
      map['invocationInfo'] != null
          ? InvocationInfoBeanStr.fromMap(map['invocationInfo'])
          : null,
      map['result'] != null ? ResultBean.fromMap(map['result']) : null,
    );
    return accountBean;
  }

  Map toJson() => {
        "invocationInfo": invocationInfo?.toJson(),
        "result": result?.toJson(),
      }..removeWhere((k, v) => v == null);
}

class ResultBean {
  final AccountBean? account;
  final PermissionsBean? permissions;
  final SubscriptionBean? subscription;
  final bool? subeditor;
  final int? subeditorLevel;
  final bool? pretrialActive;
  final MasterhubBean? masterhub;
  final PlusBean? plus;
  final String? defaultEmail;
  final String? userhash;

  ResultBean(
      this.account,
      this.permissions,
      this.subscription,
      this.subeditor,
      this.subeditorLevel,
      this.pretrialActive,
      this.masterhub,
      this.plus,
      this.defaultEmail,
      this.userhash);

  static ResultBean fromMap(Map<String, dynamic> map) {
    ResultBean resultBean = ResultBean(
      map['account'] != null ? AccountBean.fromMap(map['account']) : null,
      map['permissions'] != null
          ? PermissionsBean.fromMap(map['permissions'])
          : null,
      map['subscription'] != null
          ? SubscriptionBean.fromMap(map['subscription'])
          : null,
      map['subeditor'],
      map['subeditorLevel'],
      map['pretrialActive'],
      map['masterhub'] != null ? MasterhubBean.fromMap(map['masterhub']) : null,
      map['plus'] != null ? PlusBean.fromMap(map['plus']) : null,
      map['defaultEmail'],
      map['userhash'],
    );
    return resultBean;
  }

  Map toJson() => {
        "account": account?.toJson(),
        "permissions": permissions?.toJson(),
        "subscription": subscription?.toJson(),
        "subeditor": subeditor,
        "subeditorLevel": subeditorLevel,
        "pretrialActive": pretrialActive,
        "masterhub": masterhub?.toJson(),
        "plus": plus?.toJson(),
        "defaultEmail": defaultEmail,
        "userhash": userhash,
      }..removeWhere((k, v) => v == null);
}

class PlusBean {
  final bool? hasPlus;
  final bool? isTutorialCompleted;

  PlusBean(this.hasPlus, this.isTutorialCompleted);

  static PlusBean fromMap(Map<String, dynamic> map) {
    PlusBean plusBean = PlusBean(
      map['hasPlus'],
      map['isTutorialCompleted'],
    );
    return plusBean;
  }

  Map toJson() => {
        "hasPlus": hasPlus,
        "isTutorialCompleted": isTutorialCompleted,
      }..removeWhere((k, v) => v == null);
}

class MasterhubBean {
  final List<dynamic>? activeSubscriptions;
  final List<dynamic>? availableSubscriptions;

  MasterhubBean(this.activeSubscriptions, this.availableSubscriptions);

  static MasterhubBean fromMap(Map<String, dynamic> map) {
    MasterhubBean masterhubBean = MasterhubBean(
      map['activeSubscriptions'],
      map['availableSubscriptions'],
    );
    return masterhubBean;
  }

  Map toJson() => {
        "activeSubscriptions": activeSubscriptions,
        "availableSubscriptions": availableSubscriptions,
      }..removeWhere((k, v) => v == null);
}

class SubscriptionBean {
  final List<FamilyAutoRenewableBean>? familyAutoRenewable;
  final bool? hadAnySubscription;
  final bool? canStartTrial;
  final bool? mcdonalds;

  SubscriptionBean(this.familyAutoRenewable, this.hadAnySubscription,
      this.canStartTrial, this.mcdonalds);

  static SubscriptionBean fromMap(Map<String, dynamic> map) {
    SubscriptionBean subscriptionBean = SubscriptionBean(
      map['familyAutoRenewable'] != null
          ? ([...(map['familyAutoRenewable'] as List)
              .map((o) => FamilyAutoRenewableBean.fromMap(o))])
          : null,
      map['hadAnySubscription'],
      map['canStartTrial'],
      map['mcdonalds'],
    );
    return subscriptionBean;
  }

  Map toJson() => {
        "familyAutoRenewable":
            familyAutoRenewable?.map((o) => o.toJson()).toList(growable: false),
        "hadAnySubscription": hadAnySubscription,
        "canStartTrial": canStartTrial,
        "mcdonalds": mcdonalds,
      }..removeWhere((k, v) => v == null);
}

class FamilyAutoRenewableBean {
  final String? expires;
  final String? vendor;
  final String? vendorHelpUrl;
  final String? productId;
  final MasterInfoBean? masterInfo;
  final bool? finished;

  FamilyAutoRenewableBean(this.expires, this.vendor, this.vendorHelpUrl,
      this.productId, this.masterInfo, this.finished);

  static FamilyAutoRenewableBean fromMap(Map<String, dynamic> map) {
    FamilyAutoRenewableBean familyAutoRenewableBean = FamilyAutoRenewableBean(
      map['expires'],
      map['vendor'],
      map['vendorHelpUrl'],
      map['productId'],
      map['masterInfo'] != null
          ? MasterInfoBean.fromMap(map['masterInfo'])
          : null,
      map['finished'],
    );
    return familyAutoRenewableBean;
  }

  Map toJson() => {
        "expires": expires,
        "vendor": vendor,
        "vendorHelpUrl": vendorHelpUrl,
        "productId": productId,
        "masterInfo": masterInfo?.toJson(),
        "finished": finished,
      }..removeWhere((k, v) => v == null);
}

class MasterInfoBean {
  final int? uid;
  final String? login;
  final String? displayName;

  MasterInfoBean(this.uid, this.login, this.displayName);

  static MasterInfoBean fromMap(Map<String, dynamic> map) {
    MasterInfoBean masterInfoBean = MasterInfoBean(
      map['uid'],
      map['login'],
      map['displayName'],
    );
    return masterInfoBean;
  }

  Map toJson() => {
        "uid": uid,
        "login": login,
        "displayName": displayName,
      }..removeWhere((k, v) => v == null);
}

class PermissionsBean {
  final String? until;
  final List<String>? values;
  final List<String>? defaultField;

  PermissionsBean(this.until, this.values, this.defaultField);

  static PermissionsBean fromMap(Map<String, dynamic> map) {
    PermissionsBean permissionsBean = PermissionsBean(
      map['until'],
      map['values'] != null
          ? ([...(map['values'] as List).map((o) => o.toString())])
          : null,
      map['default'] != null
          ? ([...(map['default'] as List).map((o) => o.toString())])
          : null,
    );
    return permissionsBean;
  }

  Map toJson() => {
        "until": until,
        "values": values,
        "default": defaultField,
      }..removeWhere((k, v) => v == null);
}

class AccountBean {
  final String? now;
  final int? uid;
  final String? login;
  final int? region;
  final String? fullName;
  final String? secondName;
  final String? firstName;
  final String? displayName;
  final String? birthday;
  final bool? serviceAvailable;
  final bool? hostedUser;
  final List<PassportPhonesBean>? passportPhones;
  final String? registeredAt;

  AccountBean(
      this.now,
      this.uid,
      this.login,
      this.region,
      this.fullName,
      this.secondName,
      this.firstName,
      this.displayName,
      this.birthday,
      this.serviceAvailable,
      this.hostedUser,
      this.passportPhones,
      this.registeredAt);

  static AccountBean fromMap(Map<String, dynamic> map) {
    AccountBean accountBean = AccountBean(
      map['now'],
      map['uid'],
      map['login'],
      map['region'],
      map['fullName'],
      map['secondName'],
      map['firstName'],
      map['displayName'],
      map['birthday'],
      map['serviceAvailable'],
      map['hostedUser'],
      map['passport-phones'] != null
          ? ([
              ...(map['passport-phones'] as List)
                  .map((o) => PassportPhonesBean.fromMap(o))
            ])
          : null,
      map['registeredAt'],
    );
    return accountBean;
  }

  Map toJson() => {
        "now": now,
        "uid": uid,
        "login": login,
        "region": region,
        "fullName": fullName,
        "secondName": secondName,
        "firstName": firstName,
        "displayName": displayName,
        "birthday": birthday,
        "serviceAvailable": serviceAvailable,
        "hostedUser": hostedUser,
        "passport-phones":
            passportPhones?.map((o) => o.toJson()).toList(growable: false),
        "registeredAt": registeredAt,
      }..removeWhere((k, v) => v == null);
}

class PassportPhonesBean {
  final String? phone;

  PassportPhonesBean(this.phone);

  static PassportPhonesBean fromMap(Map<String, dynamic> map) {
    PassportPhonesBean passportPhonesBean = PassportPhonesBean(
      map['phone'],
    );
    return passportPhonesBean;
  }

  Map toJson() => {
        "phone": phone,
      }..removeWhere((k, v) => v == null);
}