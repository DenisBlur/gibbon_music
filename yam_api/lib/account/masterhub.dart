class Masterhub {
  Masterhub({
    List<dynamic>? activeSubscriptions,
    List<dynamic>? availableSubscriptions,}){
    _activeSubscriptions = activeSubscriptions;
    _availableSubscriptions = availableSubscriptions;
  }

  Masterhub.fromJson(dynamic json) {
    if (json['activeSubscriptions'] != null) {
      _activeSubscriptions = [];
      json['activeSubscriptions'].forEach((v) {
        _activeSubscriptions?.add(v);
      });
    }
    if (json['availableSubscriptions'] != null) {
      _availableSubscriptions = [];
      json['availableSubscriptions'].forEach((v) {
        _availableSubscriptions?.add(v);
      });
    }
  }
  List<dynamic>? _activeSubscriptions;
  List<dynamic>? _availableSubscriptions;
  Masterhub copyWith({  List<dynamic>? activeSubscriptions,
    List<dynamic>? availableSubscriptions,
  }) => Masterhub(  activeSubscriptions: activeSubscriptions ?? _activeSubscriptions,
    availableSubscriptions: availableSubscriptions ?? _availableSubscriptions,
  );
  List<dynamic>? get activeSubscriptions => _activeSubscriptions;
  List<dynamic>? get availableSubscriptions => _availableSubscriptions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_activeSubscriptions != null) {
      map['activeSubscriptions'] = _activeSubscriptions?.map((v) => v.toJson()).toList();
    }
    if (_availableSubscriptions != null) {
      map['availableSubscriptions'] = _availableSubscriptions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
