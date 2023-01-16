class UserSettings {
  UserSettings({
      num? uid, 
      bool? lastFmScrobblingEnabled, 
      bool? facebookScrobblingEnabled, 
      bool? shuffleEnabled, 
      bool? addNewTrackOnPlaylistTop, 
      num? volumePercents, 
      String? userMusicVisibility, 
      String? userSocialVisibility, 
      bool? adsDisabled,
      String? modified, 
      bool? rbtDisabled, 
      String? theme, 
      bool? promosDisabled, 
      bool? autoPlayRadio, 
      bool? syncQueueEnabled, 
      bool? childModEnabled,}){
    _uid = uid;
    _lastFmScrobblingEnabled = lastFmScrobblingEnabled;
    _facebookScrobblingEnabled = facebookScrobblingEnabled;
    _shuffleEnabled = shuffleEnabled;
    _addNewTrackOnPlaylistTop = addNewTrackOnPlaylistTop;
    _volumePercents = volumePercents;
    _userMusicVisibility = userMusicVisibility;
    _userSocialVisibility = userSocialVisibility;
    _adsDisabled = adsDisabled;
    _modified = modified;
    _rbtDisabled = rbtDisabled;
    _theme = theme;
    _promosDisabled = promosDisabled;
    _autoPlayRadio = autoPlayRadio;
    _syncQueueEnabled = syncQueueEnabled;
    _childModEnabled = childModEnabled;
}

  UserSettings.fromJson(dynamic json) {
    _uid = json['uid'];
    _lastFmScrobblingEnabled = json['lastFmScrobblingEnabled'];
    _facebookScrobblingEnabled = json['facebookScrobblingEnabled'];
    _shuffleEnabled = json['shuffleEnabled'];
    _addNewTrackOnPlaylistTop = json['addNewTrackOnPlaylistTop'];
    _volumePercents = json['volumePercents'];
    _userMusicVisibility = json['userMusicVisibility'];
    _userSocialVisibility = json['userSocialVisibility'];
    _adsDisabled = json['adsDisabled'];
    _modified = json['modified'];
    _rbtDisabled = json['rbtDisabled'];
    _theme = json['theme'];
    _promosDisabled = json['promosDisabled'];
    _autoPlayRadio = json['autoPlayRadio'];
    _syncQueueEnabled = json['syncQueueEnabled'];
    _childModEnabled = json['childModEnabled'];
  }
  num? _uid;
  bool? _lastFmScrobblingEnabled;
  bool? _facebookScrobblingEnabled;
  bool? _shuffleEnabled;
  bool? _addNewTrackOnPlaylistTop;
  num? _volumePercents;
  String? _userMusicVisibility;
  String? _userSocialVisibility;
  bool? _adsDisabled;
  String? _modified;
  bool? _rbtDisabled;
  String? _theme;
  bool? _promosDisabled;
  bool? _autoPlayRadio;
  bool? _syncQueueEnabled;
  bool? _childModEnabled;
UserSettings copyWith({  num? uid,
  bool? lastFmScrobblingEnabled,
  bool? facebookScrobblingEnabled,
  bool? shuffleEnabled,
  bool? addNewTrackOnPlaylistTop,
  num? volumePercents,
  String? userMusicVisibility,
  String? userSocialVisibility,
  bool? adsDisabled,
  String? modified,
  bool? rbtDisabled,
  String? theme,
  bool? promosDisabled,
  bool? autoPlayRadio,
  bool? syncQueueEnabled,
  bool? childModEnabled,
}) => UserSettings(  uid: uid ?? _uid,
  lastFmScrobblingEnabled: lastFmScrobblingEnabled ?? _lastFmScrobblingEnabled,
  facebookScrobblingEnabled: facebookScrobblingEnabled ?? _facebookScrobblingEnabled,
  shuffleEnabled: shuffleEnabled ?? _shuffleEnabled,
  addNewTrackOnPlaylistTop: addNewTrackOnPlaylistTop ?? _addNewTrackOnPlaylistTop,
  volumePercents: volumePercents ?? _volumePercents,
  userMusicVisibility: userMusicVisibility ?? _userMusicVisibility,
  userSocialVisibility: userSocialVisibility ?? _userSocialVisibility,
  adsDisabled: adsDisabled ?? _adsDisabled,
  modified: modified ?? _modified,
  rbtDisabled: rbtDisabled ?? _rbtDisabled,
  theme: theme ?? _theme,
  promosDisabled: promosDisabled ?? _promosDisabled,
  autoPlayRadio: autoPlayRadio ?? _autoPlayRadio,
  syncQueueEnabled: syncQueueEnabled ?? _syncQueueEnabled,
  childModEnabled: childModEnabled ?? _childModEnabled,
);
  num? get uid => _uid;
  bool? get lastFmScrobblingEnabled => _lastFmScrobblingEnabled;
  bool? get facebookScrobblingEnabled => _facebookScrobblingEnabled;
  bool? get shuffleEnabled => _shuffleEnabled;
  bool? get addNewTrackOnPlaylistTop => _addNewTrackOnPlaylistTop;
  num? get volumePercents => _volumePercents;
  String? get userMusicVisibility => _userMusicVisibility;
  String? get userSocialVisibility => _userSocialVisibility;
  bool? get adsDisabled => _adsDisabled;
  String? get modified => _modified;
  bool? get rbtDisabled => _rbtDisabled;
  String? get theme => _theme;
  bool? get promosDisabled => _promosDisabled;
  bool? get autoPlayRadio => _autoPlayRadio;
  bool? get syncQueueEnabled => _syncQueueEnabled;
  bool? get childModEnabled => _childModEnabled;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = _uid;
    map['lastFmScrobblingEnabled'] = _lastFmScrobblingEnabled;
    map['facebookScrobblingEnabled'] = _facebookScrobblingEnabled;
    map['shuffleEnabled'] = _shuffleEnabled;
    map['addNewTrackOnPlaylistTop'] = _addNewTrackOnPlaylistTop;
    map['volumePercents'] = _volumePercents;
    map['userMusicVisibility'] = _userMusicVisibility;
    map['userSocialVisibility'] = _userSocialVisibility;
    map['adsDisabled'] = _adsDisabled;
    map['modified'] = _modified;
    map['rbtDisabled'] = _rbtDisabled;
    map['theme'] = _theme;
    map['promosDisabled'] = _promosDisabled;
    map['autoPlayRadio'] = _autoPlayRadio;
    map['syncQueueEnabled'] = _syncQueueEnabled;
    map['childModEnabled'] = _childModEnabled;
    return map;
  }

}