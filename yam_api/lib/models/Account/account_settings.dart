import '../InvocationInfoBean.dart';

class AccountSettingsModel {
  final InvocationInfoBeanInt? invocationInfo;
  final ResultBean? result;

  AccountSettingsModel(this.invocationInfo, this.result);

  static AccountSettingsModel fromMap(Map<String, dynamic> map) {
    AccountSettingsModel accountSettingsBean = AccountSettingsModel(
     map['invocationInfo']!=null ? InvocationInfoBeanInt.fromMap(map['invocationInfo']) : null,
     map['result']!=null ? ResultBean.fromMap(map['result']) : null,
    );
    return accountSettingsBean;
  }

  Map toJson() => {
    "invocationInfo": invocationInfo?.toJson(),
    "result": result?.toJson(),
  }..removeWhere((k,v)=>v==null);
}

class ResultBean {
  final int? uid;
  final bool? lastFmScrobblingEnabled;
  final bool? facebookScrobblingEnabled;
  final bool? shuffleEnabled;
  final bool? addNewTrackOnPlaylistTop;
  final int? volumePercents;
  final String? userMusicVisibility;
  final String? userSocialVisibility;
  final bool? adsDisabled;
  final String? modified;
  final bool? rbtDisabled;
  final String? theme;
  final bool? promosDisabled;
  final bool? autoPlayRadio;
  final bool? syncQueueEnabled;
  final bool? childModEnabled;

  ResultBean(this.uid, this.lastFmScrobblingEnabled, this.facebookScrobblingEnabled, this.shuffleEnabled, this.addNewTrackOnPlaylistTop, this.volumePercents, this.userMusicVisibility, this.userSocialVisibility, this.adsDisabled, this.modified, this.rbtDisabled, this.theme, this.promosDisabled, this.autoPlayRadio, this.syncQueueEnabled, this.childModEnabled);

  static ResultBean fromMap(Map<String, dynamic> map) {
    ResultBean resultBean = ResultBean(
     map['uid'],
     map['lastFmScrobblingEnabled'],
     map['facebookScrobblingEnabled'],
     map['shuffleEnabled'],
     map['addNewTrackOnPlaylistTop'],
     map['volumePercents'],
     map['userMusicVisibility'],
     map['userSocialVisibility'],
     map['adsDisabled'],
     map['modified'],
     map['rbtDisabled'],
     map['theme'],
     map['promosDisabled'],
     map['autoPlayRadio'],
     map['syncQueueEnabled'],
     map['childModEnabled'],
    );
    return resultBean;
  }

  Map toJson() => {
    "uid": uid,
    "lastFmScrobblingEnabled": lastFmScrobblingEnabled,
    "facebookScrobblingEnabled": facebookScrobblingEnabled,
    "shuffleEnabled": shuffleEnabled,
    "addNewTrackOnPlaylistTop": addNewTrackOnPlaylistTop,
    "volumePercents": volumePercents,
    "userMusicVisibility": userMusicVisibility,
    "userSocialVisibility": userSocialVisibility,
    "adsDisabled": adsDisabled,
    "modified": modified,
    "rbtDisabled": rbtDisabled,
    "theme": theme,
    "promosDisabled": promosDisabled,
    "autoPlayRadio": autoPlayRadio,
    "syncQueueEnabled": syncQueueEnabled,
    "childModEnabled": childModEnabled,
  }..removeWhere((k,v)=>v==null);
}
